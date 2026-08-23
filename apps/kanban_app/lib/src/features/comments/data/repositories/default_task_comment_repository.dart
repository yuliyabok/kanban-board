import 'dart:convert';

import 'package:uuid/uuid.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../../../core/sync/realtime_service.dart';
import '../../../../core/sync/sync_operation.dart';
import '../../../../core/sync/sync_outbox.dart';
import '../../../permissions/domain/entities/permission.dart';
import '../../../permissions/domain/repositories/permission_repository.dart';
import '../../../tasks/data/datasources/task_history_local_datasource.dart';
import '../../../tasks/domain/entities/task_history_entry.dart';
import '../../domain/entities/task_comment_entity.dart';
import '../../domain/repositories/task_comment_repository.dart';
import '../datasources/task_comment_local_datasource.dart';
import '../datasources/task_comment_remote_datasource.dart';
import '../mappers/task_comment_mapper.dart';

final class DefaultTaskCommentRepository implements TaskCommentRepository {
  const DefaultTaskCommentRepository({
    required AppDatabase database,
    required TaskCommentLocalDataSource localDataSource,
    required TaskCommentRemoteDataSource remoteDataSource,
    required TaskHistoryLocalDataSource historyLocalDataSource,
    required PermissionRepository permissionRepository,
    required RealtimeService realtimeService,
    required SyncOutbox syncOutbox,
    required Uuid uuid,
  }) : _database = database,
       _localDataSource = localDataSource,
       _remoteDataSource = remoteDataSource,
       _historyLocalDataSource = historyLocalDataSource,
       _permissionRepository = permissionRepository,
       _realtimeService = realtimeService,
       _syncOutbox = syncOutbox,
       _uuid = uuid;

  final AppDatabase _database;
  final TaskCommentLocalDataSource _localDataSource;
  final TaskCommentRemoteDataSource _remoteDataSource;
  final TaskHistoryLocalDataSource _historyLocalDataSource;
  final PermissionRepository _permissionRepository;
  final RealtimeService _realtimeService;
  final SyncOutbox _syncOutbox;
  final Uuid _uuid;

  @override
  Stream<List<TaskCommentEntity>> watchByTask(String taskId) {
    return _localDataSource
        .watchByTask(taskId)
        .map(
          (rows) => rows.map((row) => row.toEntity()).toList(growable: false),
        );
  }

  @override
  Future<Result<TaskCommentEntity>> create({
    required String taskId,
    required String authorId,
    required String content,
  }) async {
    try {
      final task = await _task(taskId);
      if (task == null) {
        return const Error(ValidationFailure('Задача не найдена'));
      }
      final validation = _validateContent(content);
      if (validation != null) {
        return Error(validation);
      }
      if (!await _permissionRepository.hasBoardPermission(
        userId: authorId,
        boardId: task.boardId,
        permission: Permission.commentTask,
      )) {
        return const Error(ValidationFailure('Недостаточно прав'));
      }
      final now = DateTime.now().toUtc();
      final comment = TaskCommentEntity(
        id: _uuid.v7(),
        taskId: taskId,
        authorId: authorId,
        content: content.trim(),
        createdAt: now,
        updatedAt: now,
      );
      await _localDataSource.upsert(comment.toCompanion(syncAction: 'create'));
      await _recordHistory(
        task: task,
        action: 'comment_create',
        summary: 'добавлен комментарий',
        actorUserId: authorId,
        changedAt: now,
        detailsJson: jsonEncode([
          {
            'field': 'comment',
            'label': 'добавлен комментарий',
            'to': comment.content,
          },
        ]),
      );
      await _tryPushCreate(comment);
      _publish(RealtimeEvents.commentCreated, comment);
      return Success(comment);
    } on Exception catch (error) {
      return Error(StorageFailure(error.toString()));
    }
  }

  @override
  Future<Result<void>> delete({
    required String id,
    required String actorUserId,
  }) async {
    try {
      final existing = await _localDataSource.getById(id);
      if (existing == null) return const Success(null);
      final task = await _task(existing.taskId);
      if (task == null) return const Success(null);
      if (!await _canEditComment(
        existing,
        task.boardId,
        actorUserId,
        delete: true,
      )) {
        return const Error(ValidationFailure('Недостаточно прав'));
      }
      final deleted = existing.toEntity().copyWith(
        deletedAt: DateTime.now().toUtc(),
        updatedAt: DateTime.now().toUtc(),
      );
      await _localDataSource.upsert(deleted.toCompanion(syncAction: 'delete'));
      await _recordHistory(
        task: task,
        action: 'comment_delete',
        summary: 'комментарий удален',
        actorUserId: actorUserId,
        changedAt: deleted.updatedAt,
        detailsJson: jsonEncode([
          {
            'field': 'comment',
            'label': 'комментарий удален',
            'from': existing.content,
          },
        ]),
      );
      await _tryPushDelete(deleted);
      _publish(RealtimeEvents.commentDeleted, deleted);
      return const Success(null);
    } on Exception catch (error) {
      return Error(StorageFailure(error.toString()));
    }
  }

  @override
  Future<Result<List<TaskCommentEntity>>> getByTask(String taskId) async {
    try {
      final rows = await _localDataSource.getByTask(taskId);
      return Success(rows.map((row) => row.toEntity()).toList(growable: false));
    } on Exception catch (error) {
      return Error(StorageFailure(error.toString()));
    }
  }

  @override
  Future<Result<TaskCommentEntity>> update({
    required String id,
    required String actorUserId,
    required String content,
  }) async {
    try {
      final existing = await _localDataSource.getById(id);
      if (existing == null) {
        return const Error(ValidationFailure('Комментарий не найден'));
      }
      final task = await _task(existing.taskId);
      if (task == null) {
        return const Error(ValidationFailure('Задача не найдена'));
      }
      final validation = _validateContent(content);
      if (validation != null) {
        return Error(validation);
      }
      if (!await _canEditComment(existing, task.boardId, actorUserId)) {
        return const Error(ValidationFailure('Недостаточно прав'));
      }
      final updated = existing.toEntity().copyWith(
        content: content.trim(),
        updatedAt: DateTime.now().toUtc(),
      );
      await _localDataSource.upsert(updated.toCompanion(syncAction: 'update'));
      await _recordHistory(
        task: task,
        action: 'comment_update',
        summary: 'комментарий изменен',
        actorUserId: actorUserId,
        changedAt: updated.updatedAt,
        detailsJson: jsonEncode([
          {
            'field': 'comment',
            'label': 'комментарий изменен',
            'from': existing.content,
            'to': updated.content,
          },
        ]),
      );
      await _tryPushUpdate(updated);
      _publish(RealtimeEvents.commentUpdated, updated);
      return Success(updated);
    } on Exception catch (error) {
      return Error(StorageFailure(error.toString()));
    }
  }

  Failure? _validateContent(String content) {
    final trimmed = content.trim();
    if (trimmed.isEmpty) {
      return const ValidationFailure('Комментарий не пустой');
    }
    if (trimmed.length > 5000) {
      return const ValidationFailure('Комментарий максимум 5000 символов');
    }
    return null;
  }

  Future<bool> _canEditComment(
    TaskCommentsTableData comment,
    String boardId,
    String actorUserId, {
    bool delete = false,
  }) async {
    if (comment.authorId == actorUserId) return true;
    return _permissionRepository.hasBoardPermission(
      userId: actorUserId,
      boardId: boardId,
      permission: delete ? Permission.deleteComment : Permission.manageBoard,
    );
  }

  Future<TasksTableData?> _task(String taskId) {
    return (_database.select(
      _database.tasksTable,
    )..where((table) => table.id.equals(taskId))).getSingleOrNull();
  }

  Future<void> _recordHistory({
    required TasksTableData task,
    required String action,
    required String summary,
    required String actorUserId,
    required DateTime changedAt,
    String? detailsJson,
  }) {
    return _historyLocalDataSource.insert(
      TaskHistoryEntry(
        id: _uuid.v7(),
        taskId: task.id,
        boardId: task.boardId,
        action: action,
        summary: summary,
        detailsJson: detailsJson,
        actorUserId: actorUserId,
        changedAt: changedAt,
      ),
    );
  }

  void _publish(String type, TaskCommentEntity comment) {
    _realtimeService.publish(
      RealtimeEvent(
        type: type,
        payload: {'commentId': comment.id, 'taskId': comment.taskId},
        occurredAt: DateTime.now().toUtc(),
      ),
    );
  }

  Future<void> _tryPushCreate(TaskCommentEntity comment) async {
    try {
      final remoteComment = await _remoteDataSource.create(comment.toDto());
      await _localDataSource.upsert(
        remoteComment.toEntity().toCompanion(syncAction: null),
      );
    } on Exception catch (error) {
      await _enqueue(
        comment: comment,
        action: SyncAction.create,
        error: error,
      );
      // Local comment stays pending and can be retried by the sync layer.
    }
  }

  Future<void> _tryPushUpdate(TaskCommentEntity comment) async {
    try {
      final remoteComment = await _remoteDataSource.update(comment.toDto());
      await _localDataSource.upsert(
        remoteComment.toEntity().toCompanion(syncAction: null),
      );
    } on Exception catch (error) {
      await _enqueue(
        comment: comment,
        action: SyncAction.update,
        error: error,
      );
      // Local comment stays pending and can be retried by the sync layer.
    }
  }

  Future<void> _tryPushDelete(TaskCommentEntity comment) async {
    try {
      await _remoteDataSource.delete(comment.id);
      await _localDataSource.upsert(
        comment.copyWith(isSynced: true).toCompanion(syncAction: null),
      );
    } on Exception catch (error) {
      await _enqueue(
        comment: comment,
        action: SyncAction.delete,
        error: error,
      );
      // Local tombstone stays pending and can be retried by the sync layer.
    }
  }

  Future<void> _enqueue({
    required TaskCommentEntity comment,
    required SyncAction action,
    required Object error,
  }) {
    return _syncOutbox.enqueue(
      SyncOperation(
        id: _uuid.v7(),
        entityType: 'comment',
        entityId: comment.id,
        action: action,
        payload: comment.toDto().toJson(),
        createdAt: DateTime.now().toUtc(),
        lastError: error.toString(),
      ),
    );
  }
}
