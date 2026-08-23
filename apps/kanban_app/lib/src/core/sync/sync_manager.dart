// Координатор синхронизации: в local-режиме ничего опасного не делает, а в
// server-режиме уже умеет запрашивать `/sync/delta`.
import 'dart:async';

import 'package:drift/drift.dart';
import 'package:kanban_contracts/kanban_contracts.dart' show SyncDeltaDto;

import '../database/app_database.dart';
import '../error/failure.dart';
import '../network/api_endpoints.dart';
import '../network/api_client.dart';
import '../sync/server_state_puller.dart';
import '../sync/realtime_connection.dart';
import '../sync/sync_operation.dart';
import '../sync/sync_outbox.dart';
import '../../features/comments/data/dto/task_comment_dto.dart'
    as app_comment_dto;
import '../../features/tasks/data/dto/task_dto.dart' as app_task_dto;

enum SyncStatus { idle, syncing, failed }

abstract interface class SyncManager {
  Stream<SyncStatus> get status;

  Future<void> start();

  Future<void> stop();

  Future<void> syncPending();
}

final class LocalFirstSyncManager implements SyncManager {
  LocalFirstSyncManager({
    required AppDatabase database,
    required ApiClient apiClient,
    required RealtimeConnection realtimeConnection,
    required SyncOutbox syncOutbox,
    required bool usesServerRemote,
  }) : _database = database,
       _apiClient = apiClient,
       _realtimeConnection = realtimeConnection,
       _syncOutbox = syncOutbox,
       _usesServerRemote = usesServerRemote,
       _statusController = StreamController<SyncStatus>.broadcast();

  final AppDatabase _database;
  final ApiClient _apiClient;
  final RealtimeConnection _realtimeConnection;
  final SyncOutbox _syncOutbox;
  final bool _usesServerRemote;
  final StreamController<SyncStatus> _statusController;

  bool _isRunning = false;
  bool _isSyncing = false;
  StreamSubscription<Map<String, dynamic>>? _realtimeSubscription;

  @override
  Stream<SyncStatus> get status => _statusController.stream;

  @override
  Future<void> start() async {
    if (_isRunning) {
      return;
    }

    _isRunning = true;
    await _realtimeConnection.connect();
    _realtimeSubscription ??= _realtimeConnection.messages.listen((_) {
      if (_usesServerRemote && _isRunning && !_isSyncing) {
        unawaited(syncPending());
      }
    });
    _emitStatus(SyncStatus.idle);
    await syncPending();
  }

  @override
  Future<void> stop() async {
    if (!_isRunning) {
      return;
    }

    _isRunning = false;
    await _realtimeSubscription?.cancel();
    _realtimeSubscription = null;
    await _realtimeConnection.close();
    _emitStatus(SyncStatus.idle);
  }

  @override
  Future<void> syncPending() async {
    if (!_isRunning) {
      _emitStatus(SyncStatus.failed);
      return;
    }
    if (_isSyncing) {
      return;
    }

    try {
      _isSyncing = true;
      _emitStatus(SyncStatus.syncing);
      final AppDatabase database = _database;
      final ApiClient apiClient = _apiClient;
      // Keep the fields alive for feature-driven sync coordination.
      database;
      if (!_usesServerRemote) {
        await Future<void>.delayed(const Duration(milliseconds: 100));
        _emitStatus(SyncStatus.idle);
        return;
      }

      final deltaJson = await apiClient.getJson(ApiEndpoints.syncDelta);
      SyncDeltaDto.fromJson(deltaJson);
      await _pushPendingOutbox();
      await ServerStatePuller(
        database: database,
        apiClient: apiClient,
      ).pull();
      _emitStatus(SyncStatus.idle);
    } on Exception catch (error) {
      _emitStatus(SyncStatus.failed);
      throw UnexpectedFailure('Sync failed: $error');
    } finally {
      _isSyncing = false;
    }
  }

  Future<void> _pushPendingOutbox() async {
    final operations = await _syncOutbox.pending();
    for (final operation in operations) {
      await _syncOutbox.markInFlight(operation.id);
      try {
        await _pushOperation(operation);
        await _syncOutbox.markDone(operation.id);
      } on Exception catch (error) {
        await _syncOutbox.markFailed(
          operationId: operation.id,
          error: error.toString(),
        );
      }
    }
  }

  Future<void> _pushOperation(SyncOperation operation) async {
    switch (operation.entityType) {
      case 'task':
        return _pushTaskOperation(operation);
      case 'board':
        return _pushBoardOperation(operation);
      case 'column':
        return _pushColumnOperation(operation);
      case 'comment':
        return _pushCommentOperation(operation);
      default:
        throw UnsupportedError(
          'Unsupported sync entity type: ${operation.entityType}',
        );
    }
  }

  Future<void> _pushTaskOperation(SyncOperation operation) async {
    switch (operation.action) {
      case SyncAction.create:
        await _apiClient.postJson(
          ApiEndpoints.tasks,
          body: operation.payload,
        );
        await _markTaskSynced(operation.entityId);
      case SyncAction.update:
        final task = app_task_dto.TaskDto.fromJson(
          Map<String, dynamic>.from(operation.payload),
        );
        await _apiClient.patchJson(
          '/tasks/${task.id}',
          body: task.toJson(),
        );
        await _markTaskSynced(operation.entityId);
      case SyncAction.delete:
        await _apiClient.delete('/tasks/${operation.entityId}');
        await _markTaskSynced(operation.entityId);
    }
  }

  Future<void> _pushBoardOperation(SyncOperation operation) async {
    switch (operation.action) {
      case SyncAction.create:
        await _apiClient.postJson(
          ApiEndpoints.boards,
          body: operation.payload,
        );
        await _markBoardSynced(operation.entityId);
      case SyncAction.update:
        await _apiClient.patchJson(
          ApiEndpoints.board(operation.entityId),
          body: operation.payload,
        );
        await _markBoardSynced(operation.entityId);
      case SyncAction.delete:
        await _apiClient.delete(ApiEndpoints.board(operation.entityId));
        await _markBoardSynced(operation.entityId);
    }
  }

  Future<void> _pushColumnOperation(SyncOperation operation) async {
    switch (operation.action) {
      case SyncAction.create:
        await _apiClient.postJson(
          ApiEndpoints.columns,
          body: operation.payload,
        );
        await _markColumnSynced(operation.entityId);
      case SyncAction.update:
        await _apiClient.patchJson(
          ApiEndpoints.column(operation.entityId),
          body: operation.payload,
        );
        await _markColumnSynced(operation.entityId);
      case SyncAction.delete:
        await _apiClient.delete(ApiEndpoints.column(operation.entityId));
        await _markColumnSynced(operation.entityId);
    }
  }

  Future<void> _pushCommentOperation(SyncOperation operation) async {
    final comment = app_comment_dto.TaskCommentDto.fromJson(
      Map<String, dynamic>.from(operation.payload),
    );
    switch (operation.action) {
      case SyncAction.create:
        await _apiClient.postJson(
          ApiEndpoints.taskComments(comment.taskId),
          body: comment.toJson(),
        );
        await _markCommentSynced(operation.entityId);
      case SyncAction.update:
        await _apiClient.patchJson(
          ApiEndpoints.comment(operation.entityId),
          body: comment.toJson(),
        );
        await _markCommentSynced(operation.entityId);
      case SyncAction.delete:
        await _apiClient.delete(ApiEndpoints.comment(operation.entityId));
        await _markCommentSynced(operation.entityId);
    }
  }

  Future<void> _markTaskSynced(String taskId) async {
    await (_database.update(
      _database.tasksTable,
    )..where((task) => task.id.equals(taskId))).write(
      const TasksTableCompanion(
        isSynced: Value(true),
        syncAction: Value(null),
      ),
    );
  }

  Future<void> _markBoardSynced(String boardId) async {
    await (_database.update(
      _database.boardsTable,
    )..where((board) => board.id.equals(boardId))).write(
      const BoardsTableCompanion(
        isSynced: Value(true),
        syncAction: Value(null),
      ),
    );
  }

  Future<void> _markColumnSynced(String columnId) async {
    await (_database.update(
      _database.boardColumnsTable,
    )..where((column) => column.id.equals(columnId))).write(
      const BoardColumnsTableCompanion(
        isSynced: Value(true),
        syncAction: Value(null),
      ),
    );
  }

  Future<void> _markCommentSynced(String commentId) async {
    await (_database.update(
      _database.taskCommentsTable,
    )..where((comment) => comment.id.equals(commentId))).write(
      const TaskCommentsTableCompanion(
        isSynced: Value(true),
        syncAction: Value(null),
      ),
    );
  }

  void _emitStatus(SyncStatus value) {
    if (!_statusController.isClosed) {
      _statusController.add(value);
    }
  }
}
