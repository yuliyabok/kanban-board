import '../../../core/error/failure.dart';
import '../../../core/error/result.dart';
import '../../columns/domain/entities/board_column_entity.dart';
import '../../columns/domain/policies/column_policy.dart';
import '../../columns/domain/repositories/column_repository.dart';
import '../../tasks/domain/repositories/task_repository.dart';
import 'deleted_column_task_plan.dart';

abstract interface class BoardConstructorService {
  Future<Result<List<BoardColumnEntity>>> saveDraft({
    required String boardId,
    required List<BoardColumnEntity> originalColumns,
    required List<BoardColumnEntity> draftColumns,
    required Map<String, DeletedColumnTaskPlan> deletedColumnTaskPlans,
  });
}

final class DefaultBoardConstructorService implements BoardConstructorService {
  const DefaultBoardConstructorService({
    required ColumnRepository columnRepository,
    required TaskRepository taskRepository,
  }) : _columnRepository = columnRepository,
       _taskRepository = taskRepository;

  final ColumnRepository _columnRepository;
  final TaskRepository _taskRepository;

  @override
  Future<Result<List<BoardColumnEntity>>> saveDraft({
    required String boardId,
    required List<BoardColumnEntity> originalColumns,
    required List<BoardColumnEntity> draftColumns,
    required Map<String, DeletedColumnTaskPlan> deletedColumnTaskPlans,
  }) async {
    for (final column in draftColumns) {
      final validation = ColumnPolicy.validateTitle(column.title);
      if (validation != null) {
        return Error(validation);
      }
    }

    final originalById = {
      for (final column in originalColumns) column.id: column,
    };
    final draftById = {for (final column in draftColumns) column.id: column};
    final tasks = await _taskRepository.getByBoard(boardId);

    for (final deletedColumnId in originalById.keys) {
      if (draftById.containsKey(deletedColumnId)) continue;

      final plan = deletedColumnTaskPlans[deletedColumnId];
      final affectedTasks = tasks
          .where((task) => task.columnId == deletedColumnId)
          .toList(growable: false);
      if (affectedTasks.isNotEmpty && plan == null) {
        return const Error(
          ValidationFailure('Выберите, что сделать с задачами столбца'),
        );
      }

      for (final task in affectedTasks) {
        final result = plan?.action == ColumnTaskDeleteAction.transferTasks
            ? await _taskRepository.update(
                task.copyWith(columnId: plan?.transferTargetColumnId),
              )
            : await _taskRepository.delete(task.id);
        if (result case Error(:final failure)) {
          return Error(failure);
        }
      }

      final deleteResult = await _columnRepository.delete(deletedColumnId);
      if (deleteResult case Error(:final failure)) {
        return Error(failure);
      }
    }

    for (final column in draftColumns) {
      if (!originalById.containsKey(column.id)) {
        final result = await _columnRepository.create(
          boardId: boardId,
          title: column.title,
          position: column.position,
          id: column.id,
        );
        if (result case Error(:final failure)) {
          return Error(failure);
        }
        continue;
      }

      final original = originalById[column.id]!;
      if (original.title != column.title) {
        final result = await _columnRepository.updateTitle(
          columnId: column.id,
          title: column.title,
        );
        if (result case Error(:final failure)) {
          return Error(failure);
        }
      }
    }

    final reorderResult = await _columnRepository.reorder(draftColumns);
    if (reorderResult case Error(:final failure)) {
      return Error(failure);
    }

    final savedColumns = await _columnRepository.getByBoard(boardId);
    return Success(savedColumns);
  }
}
