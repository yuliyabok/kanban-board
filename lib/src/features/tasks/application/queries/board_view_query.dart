import 'dart:async';

import 'package:meta/meta.dart';

import '../../../board_settings/domain/entities/board_card_settings.dart';
import '../../../board_settings/domain/repositories/board_settings_repository.dart';
import '../../../columns/domain/entities/board_column_entity.dart';
import '../../../columns/domain/repositories/column_repository.dart';
import '../../../task_types/domain/entities/task_type_entity.dart';
import '../../../task_types/domain/repositories/task_type_repository.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/task_repository.dart';
import '../../domain/value_objects/task_filter.dart';
import '../services/board_task_projection_service.dart';
import '../state/board_view_state.dart';

@immutable
final class BoardViewArgs {
  const BoardViewArgs({
    required this.boardId,
    this.filters = const TaskFilter(),
  });

  final String boardId;
  final TaskFilter filters;

  @override
  bool operator ==(Object other) {
    return other is BoardViewArgs &&
        other.boardId == boardId &&
        other.filters == filters;
  }

  @override
  int get hashCode => Object.hash(boardId, filters);
}

abstract interface class BoardViewQuery {
  Stream<BoardViewState> watch(BoardViewArgs args);
}

final class DefaultBoardViewQuery implements BoardViewQuery {
  const DefaultBoardViewQuery({
    required TaskRepository taskRepository,
    required ColumnRepository columnRepository,
    required BoardSettingsRepository boardSettingsRepository,
    required TaskTypeRepository taskTypeRepository,
    required BoardTaskProjectionService projectionService,
  }) : _taskRepository = taskRepository,
       _columnRepository = columnRepository,
       _boardSettingsRepository = boardSettingsRepository,
       _taskTypeRepository = taskTypeRepository,
       _projectionService = projectionService;

  final TaskRepository _taskRepository;
  final ColumnRepository _columnRepository;
  final BoardSettingsRepository _boardSettingsRepository;
  final TaskTypeRepository _taskTypeRepository;
  final BoardTaskProjectionService _projectionService;

  @override
  Stream<BoardViewState> watch(BoardViewArgs args) {
    late StreamSubscription<void> tasksSubscription;
    late StreamSubscription<void> columnsSubscription;
    late StreamSubscription<void> settingsSubscription;
    late StreamSubscription<void> taskTypesSubscription;

    return Stream<BoardViewState>.multi((controller) {
      List<TaskEntity>? latestTasks;
      List<BoardColumnEntity>? latestColumns;
      BoardCardSettings? latestSettings;
      List<TaskTypeEntity>? latestTaskTypes;

      void emitIfReady() {
        final tasks = latestTasks;
        final columns = latestColumns;
        final settings = latestSettings;
        final taskTypes = latestTaskTypes;
        if (tasks == null ||
            columns == null ||
            settings == null ||
            taskTypes == null) {
          return;
        }

        controller.add(
          _projectionService.build(
            boardId: args.boardId,
            tasks: tasks,
            columns: columns,
            settings: settings,
            taskTypes: taskTypes,
            filters: args.filters,
          ),
        );
      }

      tasksSubscription = _taskRepository.watchByBoard(args.boardId).listen(
        (value) {
          latestTasks = value;
          emitIfReady();
        },
        onError: controller.addError,
      );
      columnsSubscription = _columnRepository.watchByBoard(args.boardId).listen(
        (value) {
          latestColumns = value;
          emitIfReady();
        },
        onError: controller.addError,
      );
      settingsSubscription = _boardSettingsRepository
          .watchCardSettings(args.boardId)
          .listen(
            (value) {
              latestSettings = value;
              emitIfReady();
            },
            onError: controller.addError,
          );
      taskTypesSubscription = _taskTypeRepository
          .watchByBoard(args.boardId)
          .listen(
            (value) {
              latestTaskTypes = value;
              emitIfReady();
            },
            onError: controller.addError,
          );

      controller.onCancel = () async {
        await Future.wait([
          tasksSubscription.cancel(),
          columnsSubscription.cancel(),
          settingsSubscription.cancel(),
          taskTypesSubscription.cancel(),
        ]);
      };
    });
  }
}
