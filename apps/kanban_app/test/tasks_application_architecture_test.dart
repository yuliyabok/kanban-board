import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board/src/core/error/result.dart';
import 'package:kanban_board/src/features/board_settings/domain/entities/board_card_settings.dart';
import 'package:kanban_board/src/features/columns/domain/entities/board_column_entity.dart';
import 'package:kanban_board/src/features/task_types/domain/entities/task_type_entity.dart';
import 'package:kanban_board/src/features/tasks/application/commands/move_task_command.dart';
import 'package:kanban_board/src/features/tasks/application/services/board_task_projection_service.dart';
import 'package:kanban_board/src/features/tasks/application/services/task_command_service.dart';
import 'package:kanban_board/src/features/tasks/domain/entities/task_entity.dart';
import 'package:kanban_board/src/features/tasks/domain/policies/task_ordering_policy.dart';
import 'package:kanban_board/src/features/tasks/domain/repositories/task_repository.dart';
import 'package:kanban_board/src/features/tasks/domain/value_objects/task_enums.dart';
import 'package:kanban_board/src/features/tasks/domain/value_objects/task_filter.dart';

void main() {
  test('task filter applies search, ownership, progress, and priority', () {
    final tasks = [
      _task('a', title: 'API contract', priority: TaskPriority.high),
      _task('b', title: 'UI polish', isCompleted: true),
      _task('c', title: 'Backend sync', priority: TaskPriority.high),
    ];

    final filtered = const TaskFilter(
      query: 'sync',
      myTaskIds: {'c'},
      myTasksOnly: true,
      inProgressOnly: true,
      priority: TaskPriority.high,
    ).apply(tasks);

    expect(filtered.map((task) => task.id), ['c']);
  });

  test('task ordering policy reorders and normalizes positions', () {
    final reordered = TaskOrderingPolicy.reorder(
      tasks: [
        _task('a', position: 0),
        _task('b', position: 1),
        _task('c', position: 2),
      ],
      oldIndex: 0,
      newIndex: 3,
    );

    expect(reordered.map((task) => task.id), ['b', 'c', 'a']);
    expect(reordered.map((task) => task.position), [0, 1, 2]);
  });

  test('task command service moves task to end of target column', () async {
    final repository = _MemoryTaskRepository([
      _task('a', columnId: 'todo', position: 0),
      _task('b', columnId: 'done', position: 0),
      _task('c', columnId: 'done', position: 1),
    ]);
    final service = DefaultTaskCommandService(repository);

    final result = await service.moveTask(
      MoveTaskCommand(
        boardId: 'board-1',
        task: repository.tasks.first,
        columnId: 'done',
      ),
    );

    expect(result, isA<Success<void>>());
    expect(repository.tasks.first.columnId, 'done');
    expect(repository.tasks.first.position, 2);
  });

  test('projection builds board view models outside presentation', () {
    final now = DateTime.utc(2026);
    final taskType = TaskTypeEntity(
      id: 'type-1',
      boardId: 'board-1',
      name: 'Bug',
      color: 'red',
      icon: 'bug',
      createdAt: now,
      updatedAt: now,
    );
    final parent = _task('parent', columnId: 'todo');
    final child = _task('child', columnId: 'todo', parentTaskId: 'parent');

    final state = const BoardTaskProjectionService().build(
      boardId: 'board-1',
      tasks: [
        parent.copyWith(taskTypeId: 'type-1'),
        child,
      ],
      columns: [
        BoardColumnEntity(
          id: 'todo',
          boardId: 'board-1',
          title: 'Todo',
          position: 0,
          createdAt: now,
          updatedAt: now,
        ),
      ],
      settings: BoardCardSettings.defaults('board-1'),
      taskTypes: [taskType],
      filters: const TaskFilter(),
    );

    final projectedParent = state.columns.single.tasks.first;
    expect(projectedParent.task.id, 'parent');
    expect(projectedParent.subtasks.map((task) => task.id), ['child']);
    expect(projectedParent.taskType?.id, 'type-1');
  });
}

TaskEntity _task(
  String id, {
  String title = 'Task',
  String boardId = 'board-1',
  String? columnId,
  String? parentTaskId,
  int position = 0,
  bool isCompleted = false,
  TaskPriority priority = TaskPriority.medium,
}) {
  final now = DateTime.utc(2026);
  return TaskEntity(
    id: id,
    boardId: boardId,
    columnId: columnId,
    parentTaskId: parentTaskId,
    title: title,
    position: position,
    priority: priority,
    isCompleted: isCompleted,
    createdAt: now,
    updatedAt: now,
  );
}

final class _MemoryTaskRepository implements TaskRepository {
  _MemoryTaskRepository(this.tasks);

  final List<TaskEntity> tasks;

  @override
  Future<Result<TaskEntity>> create({
    required String boardId,
    required String title,
    String? columnId,
    String? parentTaskId,
    String? taskTypeId,
    String? description,
    String? actorUserId,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> delete(
    String taskId, {
    bool cascade = true,
    String? actorUserId,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<List<TaskEntity>> getByBoard(String boardId) async {
    return tasks.where((task) => task.boardId == boardId).toList();
  }

  @override
  Future<Result<TaskEntity>> update(
    TaskEntity task, {
    String? actorUserId,
  }) async {
    final index = tasks.indexWhere((item) => item.id == task.id);
    if (index != -1) {
      tasks[index] = task;
    }
    return Success(task);
  }

  @override
  Stream<List<TaskEntity>> watchByBoard(String boardId) {
    return Stream.value(
      tasks.where((task) => task.boardId == boardId).toList(),
    );
  }
}
