import '../../../board_settings/domain/entities/board_card_settings.dart';
import '../../../columns/domain/entities/board_column_entity.dart';
import '../../../task_types/domain/entities/task_type_entity.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/value_objects/task_filter.dart';
import '../state/board_column_view_model.dart';
import '../state/board_view_state.dart';
import '../state/task_view_model.dart';

final class BoardTaskProjectionService {
  const BoardTaskProjectionService();

  BoardViewState build({
    required String boardId,
    required List<TaskEntity> tasks,
    required List<BoardColumnEntity> columns,
    required BoardCardSettings settings,
    required List<TaskTypeEntity> taskTypes,
    required TaskFilter filters,
    String title = 'Планирование',
  }) {
    final filteredTasks = filters.apply(tasks);
    final taskViewModels = _buildTaskViewModels(
      tasks: filteredTasks,
      allTasks: tasks,
      taskTypes: taskTypes,
    );
    final byTaskId = {
      for (final viewModel in taskViewModels) viewModel.task.id: viewModel,
    };

    final boardColumns = [
      for (final column in columns)
        BoardColumnViewModel(
          title: column.title,
          position: column.position,
          columnId: column.id,
          tasks: filteredTasks
              .where((task) => task.columnId == column.id)
              .map((task) => byTaskId[task.id]!)
              .toList(growable: false),
        ),
    ];

    final unassigned = filteredTasks
        .where((task) => task.columnId == null)
        .map((task) => byTaskId[task.id]!)
        .toList(growable: false);

    return BoardViewState(
      boardId: boardId,
      title: title,
      columns: boardColumns,
      unassignedTasks: unassigned,
      allTasks: tasks,
      filteredTasks: filteredTasks,
      rawColumns: columns,
      taskTypes: taskTypes,
      settings: settings,
      filters: filters,
    );
  }

  List<TaskViewModel> _buildTaskViewModels({
    required List<TaskEntity> tasks,
    required List<TaskEntity> allTasks,
    required List<TaskTypeEntity> taskTypes,
  }) {
    final tasksById = {for (final task in allTasks) task.id: task};
    final typesById = {for (final type in taskTypes) type.id: type};

    return [
      for (final task in tasks)
        TaskViewModel(
          task: task,
          parentTask: task.parentTaskId == null
              ? null
              : tasksById[task.parentTaskId],
          subtasks: allTasks
              .where((item) => item.parentTaskId == task.id)
              .toList(growable: false),
          taskType: task.taskTypeId == null ? null : typesById[task.taskTypeId],
        ),
    ];
  }
}
