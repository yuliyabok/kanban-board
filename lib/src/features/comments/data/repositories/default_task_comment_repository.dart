import 'package:uuid/uuid.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../../../core/sync/realtime_service.dart';
import '../../../permissions/domain/entities/permission.dart';
import '../../../permissions/domain/repositories/permission_repository.dart';
import '../../domain/entities/task_comment_entity.dart';
import '../../domain/repositories/task_comment_repository.dart';
import '../datasources/task_comment_local_datasource.dart';
import '../mappers/task_comment_mapper.dart';

final class DefaultTaskCommentRepository implements TaskCommentRepository {
  const DefaultTaskCommentRepository({
    required AppDatabase database,
    required TaskCommentLocalDataSource localDataSource,
    required PermissionRepository permissionRepository,
    required RealtimeService realtimeService,
    required Uuid uuid,
  }) : _database = database,
       _localDataSource = localDataSource,
       _permissionRepository = permissionRepository,
       _realtimeService = realtimeService,
       _uuid = uuid;

  final AppDatabase _database;
  final TaskCommentLocalDataSource _localDataSource;
  final PermissionRepository _permissionRepository;
  final RealtimeService _realtimeService;
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

  void _publish(String type, TaskCommentEntity comment) {
    _realtimeService.publish(
      RealtimeEvent(
        type: type,
        payload: {'commentId': comment.id, 'taskId': comment.taskId},
        occurredAt: DateTime.now().toUtc(),
      ),
    );
  }
}
