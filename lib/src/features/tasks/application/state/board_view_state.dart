import '../../../board_settings/domain/entities/board_card_settings.dart';
import '../../../columns/domain/entities/board_column_entity.dart';
import '../../../task_types/domain/entities/task_type_entity.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/value_objects/task_filter.dart';
import 'board_column_view_model.dart';
import 'task_view_model.dart';

final class BoardViewState {
  const BoardViewState({
    required this.boardId,
    required this.title,
    required this.columns,
    required this.unassignedTasks,
    required this.allTasks,
    required this.filteredTasks,
    required this.rawColumns,
    required this.taskTypes,
    required this.settings,
    required this.filters,
    this.isConstructorMode = false,
  });

  final String boardId;
  final String title;
  final List<BoardColumnViewModel> columns;
  final List<TaskViewModel> unassignedTasks;
  final List<TaskEntity> allTasks;
  final List<TaskEntity> filteredTasks;
  final List<BoardColumnEntity> rawColumns;
  final List<TaskTypeEntity> taskTypes;
  final BoardCardSettings settings;
  final TaskFilter filters;
  final bool isConstructorMode;

  bool get hasActiveSearch => filters.hasActiveSearch;

  bool get hasActiveFilters => filters.hasActiveFilters;

  bool get isEmpty => filteredTasks.isEmpty && rawColumns.isEmpty;
}
