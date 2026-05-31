import 'package:collection/collection.dart';

import '../../../../core/error/result.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/policies/task_ordering_policy.dart';
import '../../domain/repositories/task_repository.dart';
import '../commands/create_task_command.dart';
import '../commands/delete_task_command.dart';
import '../commands/move_task_command.dart';
import '../commands/reorder_task_command.dart';
import '../commands/update_task_command.dart';

abstract interface class TaskCommandService {
  Future<Result<TaskEntity>> createTask(CreateTaskCommand command);

  Future<Result<TaskEntity>> updateTask(UpdateTaskCommand command);

  Future<Result<void>> toggleComplete({
    required String boardId,
    required String taskId,
  });

  Future<Result<void>> moveTask(MoveTaskCommand command);

  Future<Result<void>> reorderTasks(ReorderTaskCommand command);

  Future<Result<void>> deleteTask(DeleteTaskCommand command);
}

final class DefaultTaskCommandService implements TaskCommandService {
  const DefaultTaskCommandService(this._repository);

  final TaskRepository _repository;

  @override
  Future<Result<TaskEntity>> createTask(CreateTaskCommand command) {
    return _repository.create(
      boardId: command.boardId,
      title: command.title,
      columnId: command.columnId,
      parentTaskId: command.parentTaskId,
      taskTypeId: command.taskTypeId,
      description: command.description,
    );
  }

  @override
  Future<Result<TaskEntity>> updateTask(UpdateTaskCommand command) {
    return _repository.update(command.task);
  }

  @override
  Future<Result<void>> toggleComplete({
    required String boardId,
    required String taskId,
  }) async {
    final tasks = await _repository.getByBoard(boardId);
    final task = tasks.where((item) => item.id == taskId).firstOrNull;
    if (task == null) {
      return const Success(null);
    }

    final result = await _repository.update(
      task.copyWith(isCompleted: !task.isCompleted),
    );
    return _discardValue(result);
  }

  @override
  Future<Result<void>> moveTask(MoveTaskCommand command) async {
    if (command.task.columnId == command.columnId) {
      return const Success(null);
    }

    final tasks = await _repository.getByBoard(command.boardId);
    final targetPosition = TaskOrderingPolicy.nextPositionInColumn(
      tasks: tasks,
      columnId: command.columnId,
      excludeTaskId: command.task.id,
    );
    final result = await _repository.update(
      command.task.copyWith(
        columnId: command.columnId,
        position: targetPosition,
      ),
    );
    return _discardValue(result);
  }

  @override
  Future<Result<void>> reorderTasks(ReorderTaskCommand command) async {
    final allTasks = await _repository.getByBoard(command.boardId);
    final scopedTasks = command.columnId == null
        ? allTasks
        : allTasks
              .where((task) => task.columnId == command.columnId)
              .toList(growable: false);
    final reordered = TaskOrderingPolicy.reorder(
      tasks: scopedTasks,
      oldIndex: command.oldIndex,
      newIndex: command.newIndex,
    );

    for (final task in reordered) {
      final result = await _repository.update(task);
      if (result case Error(:final failure)) {
        return Error(failure);
      }
    }
    return const Success(null);
  }

  @override
  Future<Result<void>> deleteTask(DeleteTaskCommand command) {
    return _repository.delete(command.taskId, cascade: command.cascade);
  }

  Result<void> _discardValue<T>(Result<T> result) {
    return switch (result) {
      Success<T>() => const Success(null),
      Error<T>(:final failure) => Error(failure),
    };
  }
}
