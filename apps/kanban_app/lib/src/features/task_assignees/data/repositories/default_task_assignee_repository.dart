import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../../../core/sync/realtime_service.dart';
import '../../../permissions/domain/entities/permission.dart';
import '../../../permissions/domain/repositories/permission_repository.dart';
import '../../../tasks/data/datasources/task_history_local_datasource.dart';
import '../../../tasks/domain/entities/task_history_entry.dart';
import '../../domain/entities/task_assignee_entity.dart';
import '../../domain/repositories/task_assignee_repository.dart';
import '../datasources/task_assignee_local_datasource.dart';
import '../datasources/task_assignee_remote_datasource.dart';
import '../mappers/task_assignee_mapper.dart';

final class DefaultTaskAssigneeRepository implements TaskAssigneeRepository {
  const DefaultTaskAssigneeRepository({
    required AppDatabase database,
    required TaskAssigneeLocalDataSource localDataSource,
    required TaskAssigneeRemoteDataSource remoteDataSource,
    required TaskHistoryLocalDataSource historyLocalDataSource,
    required PermissionRepository permissionRepository,
    required RealtimeService realtimeService,
    required Uuid uuid,
  }) : _database = database,
       _localDataSource = localDataSource,
       _remoteDataSource = remoteDataSource,
       _historyLocalDataSource = historyLocalDataSource,
       _permissionRepository = permissionRepository,
       _realtimeService = realtimeService,
       _uuid = uuid;

  final AppDatabase _database;
  final TaskAssigneeLocalDataSource _localDataSource;
  final TaskAssigneeRemoteDataSource _remoteDataSource;
  final TaskHistoryLocalDataSource _historyLocalDataSource;
  final PermissionRepository _permissionRepository;
  final RealtimeService _realtimeService;
  final Uuid _uuid;

  @override
  Stream<List<TaskAssigneeEntity>> watchByTask(String taskId) {
    return _localDataSource
        .watchByTask(taskId)
        .map(
          (rows) => rows.map((row) => row.toEntity()).toList(growable: false),
        );
  }

  @override
  Future<Result<TaskAssigneeEntity>> assign({
    required String taskId,
    required String userId,
    required String assignedBy,
  }) async {
    try {
      final task = await _task(taskId);
      if (task == null) {
        return const Error(ValidationFailure('Задача не найдена'));
      }
      if (!await _permissionRepository.hasBoardPermission(
        userId: assignedBy,
        boardId: task.boardId,
        permission: Permission.assignTask,
      )) {
        return const Error(ValidationFailure('Недостаточно прав'));
      }
      if (!await _isBoardOrWorkspaceMember(
        boardId: task.boardId,
        userId: userId,
      )) {
        return const Error(
          ValidationFailure('Пользователь не состоит в доске/workspace'),
        );
      }
      final existing = await _localDataSource.get(
        taskId: taskId,
        userId: userId,
      );
      if (existing != null) return Success(existing.toEntity());
      final assignee = TaskAssigneeEntity(
        id: _uuid.v7(),
        taskId: taskId,
        userId: userId,
        assignedBy: assignedBy,
        assignedAt: DateTime.now().toUtc(),
      );
      await _localDataSource.upsert(assignee.toCompanion(syncAction: 'create'));
      await _recordHistory(
        task: task,
        action: 'assign',
        summary: 'назначен исполнитель',
        actorUserId: assignedBy,
        changedAt: assignee.assignedAt,
        detailsJson: jsonEncode([
          {'field': 'assignee', 'label': 'назначен исполнитель', 'to': userId},
        ]),
      );
      await _tryPushAssign(assignee);
      _realtimeService.publish(
        RealtimeEvent(
          type: RealtimeEvents.taskAssigned,
          payload: {'taskId': taskId, 'userId': userId},
          occurredAt: DateTime.now().toUtc(),
        ),
      );
      return Success(assignee);
    } on Exception catch (error) {
      return Error(StorageFailure(error.toString()));
    }
  }

  @override
  Future<Result<List<TaskAssigneeEntity>>> getByTask(String taskId) async {
    try {
      final rows = await _localDataSource.getByTask(taskId);
      return Success(rows.map((row) => row.toEntity()).toList(growable: false));
    } on Exception catch (error) {
      return Error(StorageFailure(error.toString()));
    }
  }

  @override
  Future<Result<List<TaskAssigneeEntity>>> getMyTasks({
    required String boardId,
    required String userId,
  }) async {
    try {
      final rows = await _localDataSource.getByUser(userId);
      final tasks = await (_database.select(
        _database.tasksTable,
      )..where((table) => table.boardId.equals(boardId))).get();
      final taskIds = tasks.map((task) => task.id).toSet();
      return Success(
        rows
            .where((row) => taskIds.contains(row.taskId))
            .map((row) => row.toEntity())
            .toList(growable: false),
      );
    } on Exception catch (error) {
      return Error(StorageFailure(error.toString()));
    }
  }

  @override
  Future<Result<void>> unassign({
    required String taskId,
    required String userId,
    required String actorUserId,
  }) async {
    try {
      final task = await _task(taskId);
      if (task == null) return const Success(null);
      if (!await _permissionRepository.hasBoardPermission(
        userId: actorUserId,
        boardId: task.boardId,
        permission: Permission.assignTask,
      )) {
        return const Error(ValidationFailure('Недостаточно прав'));
      }
      await _localDataSource.delete(taskId: taskId, userId: userId);
      await _recordHistory(
        task: task,
        action: 'unassign',
        summary: 'исполнитель снят',
        actorUserId: actorUserId,
        changedAt: DateTime.now().toUtc(),
        detailsJson: jsonEncode([
          {'field': 'assignee', 'label': 'исполнитель снят', 'from': userId},
        ]),
      );
      await _tryPushUnassign(taskId: taskId, userId: userId);
      _realtimeService.publish(
        RealtimeEvent(
          type: RealtimeEvents.taskUnassigned,
          payload: {'taskId': taskId, 'userId': userId},
          occurredAt: DateTime.now().toUtc(),
        ),
      );
      return const Success(null);
    } on Exception catch (error) {
      return Error(StorageFailure(error.toString()));
    }
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

  Future<bool> _isBoardOrWorkspaceMember({
    required String boardId,
    required String userId,
  }) async {
    final boardMember =
        await (_database.select(_database.boardMembersTable)..where(
              (table) =>
                  table.boardId.equals(boardId) & table.userId.equals(userId),
            ))
            .getSingleOrNull();
    if (boardMember != null) return true;
    final board = await (_database.select(
      _database.boardsTable,
    )..where((table) => table.id.equals(boardId))).getSingleOrNull();
    final workspaceId = board?.workspaceId;
    if (workspaceId == null) return board?.ownerId == userId;
    final workspaceMember =
        await (_database.select(_database.workspaceMembersTable)..where(
              (table) =>
                  table.workspaceId.equals(workspaceId) &
                  table.userId.equals(userId),
            ))
            .getSingleOrNull();
    return workspaceMember != null;
  }

  Future<void> _tryPushAssign(TaskAssigneeEntity assignee) async {
    try {
      final remoteAssignee = await _remoteDataSource.assign(assignee.toDto());
      await _localDataSource.upsert(
        remoteAssignee.toEntity().toCompanion(syncAction: null),
      );
    } on Exception {
      // Local assignment stays pending and can be retried by the sync layer.
    }
  }

  Future<void> _tryPushUnassign({
    required String taskId,
    required String userId,
  }) async {
    try {
      await _remoteDataSource.unassign(taskId: taskId, userId: userId);
    } on Exception {
      // The local removal is kept; the sync layer can retry the server delete.
    }
  }
}
