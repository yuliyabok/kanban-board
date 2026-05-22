import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/result.dart';
import '../../domain/entities/task_entity.dart';
import '../providers/task_providers.dart';

final tasksControllerProvider = AsyncNotifierProvider<TasksController, void>(
  TasksController.new,
  isAutoDispose: true,
);

class TasksController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> create({
    required String boardId,
    required String title,
    String? columnId,
    String? parentTaskId,
    String? taskTypeId,
    String? description,
  }) async {
    state = const AsyncLoading();
    final result = await ref
        .read(createTaskProvider)
        .call(
          boardId: boardId,
          title: title,
          columnId: columnId,
          parentTaskId: parentTaskId,
          taskTypeId: taskTypeId,
          description: description,
        );
    state = _toAsyncValue(result);
  }

  Future<void> toggleComplete({
    required String boardId,
    required String taskId,
  }) async {
    final tasks = await ref.read(boardTasksProvider(boardId).future);
    final task = tasks.where((item) => item.id == taskId).firstOrNull;
    if (task == null) {
      return;
    }

    state = const AsyncLoading();
    final result = await ref
        .read(updateTaskProvider)
        .call(
          task.copyWith(isCompleted: !task.isCompleted),
        );
    state = _toAsyncValue(result);
  }

  Future<void> updateTaskType({
    required TaskEntity task,
    required String? taskTypeId,
  }) async {
    state = const AsyncLoading();
    final result = await ref
        .read(updateTaskTypeProvider)
        .call(task: task, taskTypeId: taskTypeId);
    state = _toAsyncValue(result);
  }

  Future<void> updateTask(TaskEntity task) async {
    state = const AsyncLoading();
    final result = await ref.read(updateTaskProvider).call(task);
    state = _toAsyncValue(result);
  }

  Future<void> reorder({
    required String boardId,
    required int oldIndex,
    required int newIndex,
  }) async {
    final tasks = [...await ref.read(boardTasksProvider(boardId).future)];
    final targetIndex = oldIndex < newIndex ? newIndex - 1 : newIndex;

    final task = tasks.removeAt(oldIndex);
    tasks.insert(targetIndex, task);

    state = const AsyncLoading();
    for (var index = 0; index < tasks.length; index++) {
      final result = await ref
          .read(updateTaskProvider)
          .call(
            tasks[index].copyWith(position: index),
          );
      if (result case Error(:final failure)) {
        state = AsyncError(failure, StackTrace.current);
        return;
      }
    }
    state = const AsyncData(null);
  }

  Future<void> reorderInColumn({
    required String boardId,
    required String? columnId,
    required int oldIndex,
    required int newIndex,
  }) async {
    final allTasks = await ref.read(boardTasksProvider(boardId).future);
    final columnTasks = allTasks
        .where((task) => task.columnId == columnId)
        .toList(growable: true);
    final targetIndex = oldIndex < newIndex ? newIndex - 1 : newIndex;

    final task = columnTasks.removeAt(oldIndex);
    columnTasks.insert(targetIndex, task);

    state = const AsyncLoading();
    for (var index = 0; index < columnTasks.length; index++) {
      final result = await ref
          .read(updateTaskProvider)
          .call(columnTasks[index].copyWith(position: index));
      if (result case Error(:final failure)) {
        state = AsyncError(failure, StackTrace.current);
        return;
      }
    }
    state = const AsyncData(null);
  }

  Future<void> moveToColumn({
    required String boardId,
    required TaskEntity task,
    required String? columnId,
  }) async {
    if (task.columnId == columnId) return;

    final allTasks = await ref.read(boardTasksProvider(boardId).future);
    final targetPosition = allTasks
        .where((item) => item.columnId == columnId && item.id != task.id)
        .length;

    state = const AsyncLoading();
    final result = await ref
        .read(updateTaskProvider)
        .call(task.copyWith(columnId: columnId, position: targetPosition));
    state = _toAsyncValue(result);
  }

  Future<void> delete(String taskId) async {
    state = const AsyncLoading();
    final result = await ref.read(deleteTaskProvider).call(taskId);
    state = _toAsyncValue(result);
  }

  Future<void> deleteWithChildren(String taskId) async {
    state = const AsyncLoading();
    final result = await ref.read(deleteTaskProvider).call(taskId);
    state = _toAsyncValue(result);
  }

  Future<void> deleteAndPromoteChildren(String taskId) async {
    state = const AsyncLoading();
    final result = await ref
        .read(deleteTaskProvider)
        .call(taskId, cascade: false);
    state = _toAsyncValue(result);
  }

  Future<void> addSubtask({
    required TaskEntity parent,
    required String title,
  }) async {
    state = const AsyncLoading();
    final result = await ref
        .read(addSubtaskProvider)
        .call(
          parent: parent,
          title: title,
        );
    state = _toAsyncValue(result);
  }

  Future<void> toggleSubtask(TaskEntity subtask) async {
    state = const AsyncLoading();
    final result = await ref.read(toggleSubtaskProvider).call(subtask);
    state = _toAsyncValue(result);
  }

  AsyncValue<void> _toAsyncValue<T>(Result<T> result) {
    return switch (result) {
      Success<T>() => const AsyncData(null),
      Error<T>(:final failure) => AsyncError(failure, StackTrace.current),
    };
  }
}
