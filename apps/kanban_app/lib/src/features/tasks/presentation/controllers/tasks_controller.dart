import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/result.dart';
import '../../application/commands/create_task_command.dart';
import '../../application/commands/delete_task_command.dart';
import '../../application/commands/move_task_command.dart';
import '../../application/commands/reorder_task_command.dart';
import '../../application/commands/update_task_command.dart';
import '../../domain/entities/task_entity.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
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
        .read(taskCommandServiceProvider)
        .createTask(
          CreateTaskCommand(
            boardId: boardId,
            title: title,
            columnId: columnId,
            parentTaskId: parentTaskId,
            taskTypeId: taskTypeId,
            description: description,
            actorUserId: _currentUserId(),
          ),
        );
    state = _toAsyncValue(result);
  }

  Future<void> toggleComplete({
    required String boardId,
    required String taskId,
  }) async {
    state = const AsyncLoading();
    final result = await ref
        .read(taskCommandServiceProvider)
        .toggleComplete(
          boardId: boardId,
          taskId: taskId,
          actorUserId: _currentUserId(),
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
        .call(
          task: task,
          taskTypeId: taskTypeId,
          actorUserId: _currentUserId(),
        );
    state = _toAsyncValue(result);
  }

  Future<void> updateTask(TaskEntity task) async {
    state = const AsyncLoading();
    final result = await ref
        .read(taskCommandServiceProvider)
        .updateTask(UpdateTaskCommand(task, actorUserId: _currentUserId()));
    state = _toAsyncValue(result);
  }

  Future<void> reorder({
    required String boardId,
    required int oldIndex,
    required int newIndex,
  }) async {
    state = const AsyncLoading();
    final result = await ref
        .read(taskCommandServiceProvider)
        .reorderTasks(
          ReorderTaskCommand(
            boardId: boardId,
            oldIndex: oldIndex,
            newIndex: newIndex,
            actorUserId: _currentUserId(),
          ),
        );
    state = _toAsyncValue(result);
  }

  Future<void> reorderInColumn({
    required String boardId,
    required String? columnId,
    required int oldIndex,
    required int newIndex,
  }) async {
    state = const AsyncLoading();
    final result = await ref
        .read(taskCommandServiceProvider)
        .reorderTasks(
          ReorderTaskCommand(
            boardId: boardId,
            columnId: columnId,
            oldIndex: oldIndex,
            newIndex: newIndex,
            actorUserId: _currentUserId(),
          ),
        );
    state = _toAsyncValue(result);
  }

  Future<void> moveToColumn({
    required String boardId,
    required TaskEntity task,
    required String? columnId,
  }) async {
    state = const AsyncLoading();
    final result = await ref
        .read(taskCommandServiceProvider)
        .moveTask(
          MoveTaskCommand(
            boardId: boardId,
            task: task,
            columnId: columnId,
            actorUserId: _currentUserId(),
          ),
        );
    state = _toAsyncValue(result);
  }

  Future<void> delete(String taskId) async {
    state = const AsyncLoading();
    final result = await ref
        .read(taskCommandServiceProvider)
        .deleteTask(
          DeleteTaskCommand(taskId: taskId, actorUserId: _currentUserId()),
        );
    state = _toAsyncValue(result);
  }

  Future<void> deleteWithChildren(String taskId) async {
    state = const AsyncLoading();
    final result = await ref
        .read(taskCommandServiceProvider)
        .deleteTask(
          DeleteTaskCommand(taskId: taskId, actorUserId: _currentUserId()),
        );
    state = _toAsyncValue(result);
  }

  Future<void> deleteAndPromoteChildren(String taskId) async {
    state = const AsyncLoading();
    final result = await ref
        .read(taskCommandServiceProvider)
        .deleteTask(
          DeleteTaskCommand(
            taskId: taskId,
            cascade: false,
            actorUserId: _currentUserId(),
          ),
        );
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
          actorUserId: _currentUserId(),
        );
    state = _toAsyncValue(result);
  }

  Future<void> toggleSubtask(TaskEntity subtask) async {
    state = const AsyncLoading();
    final result = await ref
        .read(toggleSubtaskProvider)
        .call(subtask, actorUserId: _currentUserId());
    state = _toAsyncValue(result);
  }

  String? _currentUserId() {
    return ref
        .read(authControllerProvider)
        .maybeWhen(data: (session) => session?.userId, orElse: () => null);
  }

  AsyncValue<void> _toAsyncValue<T>(Result<T> result) {
    return switch (result) {
      Success<T>() => const AsyncData(null),
      Error<T>(:final failure) => AsyncError(failure, StackTrace.current),
    };
  }
}
