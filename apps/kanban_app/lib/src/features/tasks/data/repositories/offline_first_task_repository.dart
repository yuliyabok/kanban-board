import 'dart:convert';

import 'package:uuid/uuid.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../../../core/sync/sync_operation.dart';
import '../../../../core/sync/sync_outbox.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/entities/task_history_entry.dart';
import '../../domain/policies/task_policy.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_history_local_datasource.dart';
import '../datasources/task_local_datasource.dart';
import '../datasources/task_remote_datasource.dart';
import '../mappers/task_mapper.dart';

final class OfflineFirstTaskRepository implements TaskRepository {
  const OfflineFirstTaskRepository({
    required TaskLocalDataSource localDataSource,
    required TaskHistoryLocalDataSource historyLocalDataSource,
    required TaskRemoteDataSource remoteDataSource,
    required SyncOutbox syncOutbox,
    required Uuid uuid,
  }) : _localDataSource = localDataSource,
       _historyLocalDataSource = historyLocalDataSource,
       _remoteDataSource = remoteDataSource,
       _syncOutbox = syncOutbox,
       _uuid = uuid;

  final TaskLocalDataSource _localDataSource;
  final TaskHistoryLocalDataSource _historyLocalDataSource;
  final TaskRemoteDataSource _remoteDataSource;
  final SyncOutbox _syncOutbox;
  final Uuid _uuid;

  @override
  Stream<List<TaskEntity>> watchByBoard(String boardId) {
    return _localDataSource
        .watchByBoard(boardId)
        .map(
          (rows) => rows.map((row) => row.toEntity()).toList(growable: false),
        );
  }

  @override
  Future<List<TaskEntity>> getByBoard(String boardId) async {
    final rows = await _localDataSource.getByBoard(boardId);
    return rows.map((row) => row.toEntity()).toList(growable: false);
  }

  @override
  Future<Result<TaskEntity>> create({
    required String boardId,
    required String title,
    String? columnId,
    String? parentTaskId,
    String? taskTypeId,
    String? description,
    String? actorUserId,
  }) async {
    try {
      final trimmedTitle = title.trim();
      final now = DateTime.now().toUtc();
      final existingTasks = await _localDataSource.getByBoard(boardId);
      final parent = parentTaskId == null
          ? null
          : existingTasks
                .where((task) => task.id == parentTaskId)
                .firstOrNull
                ?.toEntity();
      final localTask = TaskEntity(
        id: _uuid.v7(),
        boardId: boardId,
        columnId: columnId,
        parentTaskId: parentTaskId,
        taskTypeId: taskTypeId,
        title: trimmedTitle,
        description: description?.trim(),
        depth: parent == null ? 0 : parent.depth + 1,
        position: parentTaskId == null
            ? existingTasks.where((task) => task.parentTaskId == null).length
            : existingTasks
                  .where((task) => task.parentTaskId == parentTaskId)
                  .length,
        createdAt: now,
        updatedAt: now,
      );
      final validation = TaskPolicy.validate(
        localTask,
        existingTasks.map((row) => row.toEntity()),
      );
      if (validation != null) return Error(validation);

      await _localDataSource.upsert(
        localTask.toCompanion(syncAction: 'create'),
      );
      await _recordHistory(
        task: localTask,
        action: 'create',
        summary: 'Задача создана',
        changedAt: now,
        actorUserId: actorUserId,
        detailsJson: jsonEncode([
          {'field': 'title', 'to': trimmedTitle},
        ]),
      );
      await _tryPushCreate(localTask);

      return Success(localTask);
    } on Exception catch (error) {
      return Error(StorageFailure(error.toString()));
    }
  }

  @override
  Future<Result<TaskEntity>> update(
    TaskEntity task, {
    String? actorUserId,
  }) async {
    try {
      final existingTasks = await _localDataSource.getByBoard(task.boardId);
      final previousTask = existingTasks
          .where((row) => row.id == task.id)
          .firstOrNull
          ?.toEntity();
      final validation = TaskPolicy.validate(
        task,
        existingTasks.map((row) => row.toEntity()),
      );
      if (validation != null) return Error(validation);

      final optimisticTask = task.copyWith(
        title: task.title.trim(),
        description: task.description?.trim(),
        completedAt: task.isCompleted
            ? task.completedAt ?? DateTime.now().toUtc()
            : null,
        updatedAt: DateTime.now().toUtc(),
        isSynced: false,
      );

      await _localDataSource.upsert(
        optimisticTask.toCompanion(syncAction: 'update'),
      );
      final description = previousTask == null
          ? const _TaskHistoryDescription(summary: 'Задача обновлена')
          : _describeTaskChanges(previousTask, optimisticTask);
      if (description != null) {
        await _recordHistory(
          task: optimisticTask,
          action: 'update',
          summary: description.summary,
          changedAt: optimisticTask.updatedAt,
          actorUserId: actorUserId,
          detailsJson: description.detailsJson,
        );
      }
      await _tryPushUpdate(optimisticTask);

      return Success(optimisticTask);
    } on Exception catch (error) {
      return Error(StorageFailure(error.toString()));
    }
  }

  @override
  Future<Result<void>> delete(
    String taskId, {
    bool cascade = true,
    String? actorUserId,
  }) async {
    try {
      final task = await _localDataSource.getById(taskId);
      if (task == null) return const Success(null);
      final siblings = await _localDataSource.getByBoard(task.boardId);
      final children = siblings
          .where((item) => item.parentTaskId == taskId)
          .map((row) => row.toEntity())
          .toList(growable: false);
      await _localDataSource.softDelete(
        id: taskId,
        deletedAt: DateTime.now().toUtc(),
      );
      await _recordHistory(
        task: task.toEntity(),
        action: 'delete',
        summary: 'Задача удалена',
        changedAt: DateTime.now().toUtc(),
        actorUserId: actorUserId,
      );
      if (cascade) {
        for (final child in children) {
          await delete(child.id, actorUserId: actorUserId);
        }
      } else {
        for (final child in children) {
          await update(
            child.copyWith(
              parentTaskId: task.parentTaskId,
              depth: task.parentTaskId == null ? 0 : child.depth - 1,
            ),
            actorUserId: actorUserId,
          );
        }
      }
      await _tryPushDelete(taskId);
      return const Success(null);
    } on Exception catch (error) {
      return Error(StorageFailure(error.toString()));
    }
  }

  Future<void> _tryPushCreate(TaskEntity task) async {
    try {
      final remoteTask = await _remoteDataSource.create(task.toDto());
      await _localDataSource.upsert(
        remoteTask.toEntity().toCompanion(),
      );
      await _localDataSource.markSynced(task.id);
    } on Exception catch (e) {
      // Добавить в очередь повторных попыток
      await _syncOutbox.enqueue(
        SyncOperation(
          id: _uuid.v7(),
          entityType: 'task',
          entityId: task.id,
          action: SyncAction.create,
          payload: task.toDto().toJson(),
          createdAt: DateTime.now().toUtc(),
          lastError: e.toString(),
        ),
      );
    }
  }

  Future<void> _tryPushUpdate(TaskEntity task) async {
    try {
      final remoteTask = await _remoteDataSource.update(task.toDto());
      await _localDataSource.upsert(
        remoteTask.toEntity().toCompanion(),
      );
      await _localDataSource.markSynced(task.id);
    } on Exception catch (e) {
      // Добавить в очередь повторных попыток
      await _syncOutbox.enqueue(
        SyncOperation(
          id: _uuid.v7(),
          entityType: 'task',
          entityId: task.id,
          action: SyncAction.update,
          payload: task.toDto().toJson(),
          createdAt: DateTime.now().toUtc(),
          lastError: e.toString(),
        ),
      );
    }
  }

  Future<void> _tryPushDelete(String taskId) async {
    try {
      await _remoteDataSource.delete(taskId);
      await _localDataSource.markSynced(taskId);
    } on Exception catch (e) {
      // Добавить в очередь повторных попыток
      await _syncOutbox.enqueue(
        SyncOperation(
          id: _uuid.v7(),
          entityType: 'task',
          entityId: taskId,
          action: SyncAction.delete,
          payload: {'id': taskId},
          createdAt: DateTime.now().toUtc(),
          lastError: e.toString(),
        ),
      );
    }
  }

  Future<void> _recordHistory({
    required TaskEntity task,
    required String action,
    required String summary,
    required DateTime changedAt,
    String? actorUserId,
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

  _TaskHistoryDescription? _describeTaskChanges(
    TaskEntity before,
    TaskEntity after,
  ) {
    final changes = <_TaskFieldChange>[];
    void add(String field, String label, Object? from, Object? to) {
      changes.add(
        _TaskFieldChange(field: field, label: label, from: from, to: to),
      );
    }

    if (before.title != after.title) {
      add('title', 'изменено название', before.title, after.title);
    }
    if (before.description != after.description) {
      add(
        'description',
        'изменено описание',
        before.description,
        after.description,
      );
    }
    if (before.columnId != after.columnId) {
      add('columnId', 'изменен столбец', before.columnId, after.columnId);
    }
    if (before.position != after.position) {
      add('position', 'изменен порядок', before.position, after.position);
    }
    if (before.parentTaskId != after.parentTaskId) {
      add(
        'parentTaskId',
        'изменена родительская задача',
        before.parentTaskId,
        after.parentTaskId,
      );
    }
    if (before.taskTypeId != after.taskTypeId) {
      add('taskTypeId', 'изменен тип', before.taskTypeId, after.taskTypeId);
    }
    if (before.priority != after.priority) {
      add(
        'priority',
        'изменен приоритет',
        before.priority.name,
        after.priority.name,
      );
    }
    if (before.status != after.status) {
      add('status', 'изменен статус', before.status.name, after.status.name);
    }
    if (before.isCompleted != after.isCompleted) {
      add(
        'isCompleted',
        after.isCompleted ? 'задача завершена' : 'задача возвращена',
        before.isCompleted,
        after.isCompleted,
      );
    }
    if (before.startDate != after.startDate) {
      add(
        'startDate',
        'изменена дата начала',
        before.startDate?.toIso8601String(),
        after.startDate?.toIso8601String(),
      );
    }
    if (before.dueDate != after.dueDate) {
      add(
        'dueDate',
        'изменен дедлайн',
        before.dueDate?.toIso8601String(),
        after.dueDate?.toIso8601String(),
      );
    }
    if (before.estimatedDurationMinutes != after.estimatedDurationMinutes) {
      add(
        'estimatedDurationMinutes',
        'изменена оценка времени',
        before.estimatedDurationMinutes,
        after.estimatedDurationMinutes,
      );
    }
    if (before.actualDurationMinutes != after.actualDurationMinutes) {
      add(
        'actualDurationMinutes',
        'изменено фактическое время',
        before.actualDurationMinutes,
        after.actualDurationMinutes,
      );
    }
    if (before.cardBackgroundColor != after.cardBackgroundColor) {
      add(
        'cardBackgroundColor',
        'изменен фон карточки',
        before.cardBackgroundColor,
        after.cardBackgroundColor,
      );
    }
    if (before.cardTextColor != after.cardTextColor) {
      add(
        'cardTextColor',
        'изменен цвет текста',
        before.cardTextColor,
        after.cardTextColor,
      );
    }
    if (before.labels.join('\u0000') != after.labels.join('\u0000')) {
      add('labels', 'изменены метки', before.labels, after.labels);
    }
    if (changes.isEmpty) return null;
    return _TaskHistoryDescription(
      summary: changes.map((change) => change.label).join(', '),
      detailsJson: jsonEncode(
        changes.map((change) => change.toJson()).toList(),
      ),
    );
  }
}

final class _TaskHistoryDescription {
  const _TaskHistoryDescription({
    required this.summary,
    this.detailsJson,
  });

  final String summary;
  final String? detailsJson;
}

final class _TaskFieldChange {
  const _TaskFieldChange({
    required this.field,
    required this.label,
    required this.from,
    required this.to,
  });

  final String field;
  final String label;
  final Object? from;
  final Object? to;

  Map<String, Object?> toJson() => {
    'field': field,
    'label': label,
    'from': from,
    'to': to,
  };
}
