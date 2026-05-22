import 'package:uuid/uuid.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_local_datasource.dart';
import '../datasources/task_remote_datasource.dart';
import '../mappers/task_mapper.dart';

final class OfflineFirstTaskRepository implements TaskRepository {
  const OfflineFirstTaskRepository({
    required TaskLocalDataSource localDataSource,
    required TaskRemoteDataSource remoteDataSource,
    required Uuid uuid,
  }) : _localDataSource = localDataSource,
       _remoteDataSource = remoteDataSource,
       _uuid = uuid;

  final TaskLocalDataSource _localDataSource;
  final TaskRemoteDataSource _remoteDataSource;
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
  Future<Result<TaskEntity>> create({
    required String boardId,
    required String title,
    String? columnId,
    String? parentTaskId,
    String? taskTypeId,
    String? description,
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
      final validation = _validateTask(
        localTask,
        existingTasks.map((row) => row.toEntity()),
      );
      if (validation != null) return Error(validation);

      await _localDataSource.upsert(
        localTask.toCompanion(syncAction: 'create'),
      );
      await _tryPushCreate(localTask);

      return Success(localTask);
    } on Exception catch (error) {
      return Error(StorageFailure(error.toString()));
    }
  }

  @override
  Future<Result<TaskEntity>> update(TaskEntity task) async {
    try {
      final existingTasks = await _localDataSource.getByBoard(task.boardId);
      final validation = _validateTask(
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
      await _tryPushUpdate(optimisticTask);

      return Success(optimisticTask);
    } on Exception catch (error) {
      return Error(StorageFailure(error.toString()));
    }
  }

  @override
  Future<Result<void>> delete(String taskId, {bool cascade = true}) async {
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
      if (cascade) {
        for (final child in children) {
          await delete(child.id);
        }
      } else {
        for (final child in children) {
          await update(
            child.copyWith(
              parentTaskId: task.parentTaskId,
              depth: task.parentTaskId == null ? 0 : child.depth - 1,
            ),
          );
        }
      }
      await _tryPushDelete(taskId);
      return const Success(null);
    } on Exception catch (error) {
      return Error(StorageFailure(error.toString()));
    }
  }

  Failure? _validateTask(TaskEntity task, Iterable<TaskEntity> existingTasks) {
    final trimmedTitle = task.title.trim();
    if (trimmedTitle.isEmpty) {
      return const ValidationFailure('Название задачи не может быть пустым');
    }
    if (trimmedTitle.length > 120) {
      return const ValidationFailure('Название задачи не длиннее 120 символов');
    }
    if ((task.description?.length ?? 0) > 1000) {
      return const ValidationFailure('Описание не длиннее 1000 символов');
    }
    if (task.startDate != null &&
        task.dueDate != null &&
        task.dueDate!.isBefore(task.startDate!)) {
      return const ValidationFailure('Дата окончания не раньше даты начала');
    }
    if (task.depth > 3) {
      return const ValidationFailure('Максимальная вложенность подзадач — 3');
    }
    if (task.parentTaskId == task.id) {
      return const ValidationFailure(
        'Задача не может быть дочерней самой себе',
      );
    }
    if (_createsCycle(task, existingTasks)) {
      return const ValidationFailure('Нельзя создать циклическую зависимость');
    }
    return null;
  }

  bool _createsCycle(TaskEntity task, Iterable<TaskEntity> existingTasks) {
    final byId = {for (final item in existingTasks) item.id: item};
    var parentId = task.parentTaskId;
    var guard = 0;
    while (parentId != null && guard < 10) {
      if (parentId == task.id) return true;
      parentId = byId[parentId]?.parentTaskId;
      guard++;
    }
    return false;
  }

  Future<void> _tryPushCreate(TaskEntity task) async {
    try {
      final remoteTask = await _remoteDataSource.create(task.toDto());
      await _localDataSource.upsert(
        remoteTask.toEntity().toCompanion(),
      );
      await _localDataSource.markSynced(task.id);
    } on Exception {
      // The sync queue will retry later. Local state remains the source of UI.
    }
  }

  Future<void> _tryPushUpdate(TaskEntity task) async {
    try {
      final remoteTask = await _remoteDataSource.update(task.toDto());
      await _localDataSource.upsert(
        remoteTask.toEntity().toCompanion(),
      );
      await _localDataSource.markSynced(task.id);
    } on Exception {
      // The sync queue will retry later. Local state remains the source of UI.
    }
  }

  Future<void> _tryPushDelete(String taskId) async {
    try {
      await _remoteDataSource.delete(taskId);
      await _localDataSource.markSynced(taskId);
    } on Exception {
      // The sync queue will retry later. Local tombstone is preserved.
    }
  }
}
