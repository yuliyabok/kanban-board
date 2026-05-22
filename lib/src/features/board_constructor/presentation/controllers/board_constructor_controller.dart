import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../../columns/domain/entities/board_column_entity.dart';
import '../../../columns/presentation/providers/column_providers.dart';
import '../../../tasks/presentation/providers/task_providers.dart';
import 'board_constructor_state.dart';

final boardConstructorControllerProvider = AsyncNotifierProvider.autoDispose
    .family<BoardConstructorController, BoardConstructorState, String>(
      BoardConstructorController.new,
    );

class BoardConstructorController extends AsyncNotifier<BoardConstructorState> {
  BoardConstructorController(this._boardId);

  final String _boardId;

  @override
  Future<BoardConstructorState> build() async {
    final columns = await ref.watch(boardColumnsProvider(_boardId).future);
    return BoardConstructorState.empty().copyWith(
      originalColumns: columns,
      draftColumns: columns,
    );
  }

  Future<void> enterConstructorMode() async {
    final currentColumns = await ref.read(
      boardColumnsProvider(_boardId).future,
    );
    state = AsyncData(
      BoardConstructorState.empty().copyWith(
        isConstructorMode: true,
        originalColumns: currentColumns,
        draftColumns: currentColumns,
      ),
    );
  }

  void exitWithoutChanges() {
    final value = state.asData?.value;
    if (value == null) return;

    state = AsyncData(
      value.copyWith(
        isConstructorMode: false,
        draftColumns: value.originalColumns,
        validationErrors: const <String, String>{},
        deletedColumnTaskPlans: const <String, DeletedColumnTaskPlan>{},
        clearEditingColumnId: true,
        clearSelectedColumnId: true,
      ),
    );
  }

  void addColumn() {
    final value = state.requireValue;
    final now = DateTime.now().toUtc();
    final column = BoardColumnEntity(
      id: ref.read(uuidProvider).v7(),
      boardId: _boardId,
      title: 'Новый столбец',
      position: value.draftColumns.length,
      createdAt: now,
      updatedAt: now,
    );

    state = AsyncData(
      value.copyWith(
        draftColumns: [...value.draftColumns, column],
        selectedColumnId: column.id,
        editingColumnId: column.id,
      ),
    );
  }

  void selectColumn(String columnId) {
    final value = state.requireValue;
    state = AsyncData(value.copyWith(selectedColumnId: columnId));
  }

  void startEditing(String columnId) {
    final value = state.requireValue;
    state = AsyncData(
      value.copyWith(
        selectedColumnId: columnId,
        editingColumnId: columnId,
      ),
    );
  }

  void cancelEditing() {
    final value = state.requireValue;
    final editingColumnId = value.editingColumnId;
    if (editingColumnId == null) return;

    final original = value.originalColumns
        .where((column) => column.id == editingColumnId)
        .firstOrNull;
    if (original == null) {
      state = AsyncData(value.copyWith(clearEditingColumnId: true));
      return;
    }

    final draftColumns = [
      for (final column in value.draftColumns)
        if (column.id == editingColumnId) original else column,
    ];

    state = AsyncData(
      value.copyWith(
        draftColumns: draftColumns,
        validationErrors: _withoutError(value, editingColumnId),
        clearEditingColumnId: true,
      ),
    );
  }

  bool updateTitle({
    required String columnId,
    required String title,
  }) {
    final value = state.requireValue;
    final error = _validateTitle(title);
    final errors = Map<String, String>.of(value.validationErrors);
    if (error == null) {
      errors.remove(columnId);
    } else {
      errors[columnId] = error;
    }

    final draftColumns = [
      for (final column in value.draftColumns)
        if (column.id == columnId)
          column.copyWith(title: title, updatedAt: DateTime.now().toUtc())
        else
          column,
    ];

    state = AsyncData(
      value.copyWith(
        draftColumns: draftColumns,
        validationErrors: errors,
      ),
    );
    return error == null;
  }

  bool finishEditing(String columnId) {
    final value = state.requireValue;
    final column = value.draftColumns
        .where((draftColumn) => draftColumn.id == columnId)
        .firstOrNull;
    if (column == null || _validateTitle(column.title) != null) {
      return false;
    }

    state = AsyncData(value.copyWith(clearEditingColumnId: true));
    return true;
  }

  void reorder({
    required int oldIndex,
    required int newIndex,
  }) {
    final value = state.requireValue;
    final targetIndex = oldIndex < newIndex ? newIndex - 1 : newIndex;
    final draftColumns = [...value.draftColumns];
    final column = draftColumns.removeAt(oldIndex);
    draftColumns.insert(targetIndex, column);

    state = AsyncData(
      value.copyWith(
        draftColumns: _normalizePositions(draftColumns),
      ),
    );
  }

  void removeColumn({
    required String columnId,
    DeletedColumnTaskPlan? taskPlan,
  }) {
    final value = state.requireValue;
    final draftColumns = value.draftColumns
        .where((column) => column.id != columnId)
        .toList(growable: false);
    final plans = Map<String, DeletedColumnTaskPlan>.of(
      value.deletedColumnTaskPlans,
    );
    if (taskPlan != null) {
      plans[columnId] = taskPlan;
    } else {
      plans.remove(columnId);
    }

    state = AsyncData(
      value.copyWith(
        draftColumns: _normalizePositions(draftColumns),
        validationErrors: _withoutError(value, columnId),
        deletedColumnTaskPlans: plans,
        clearEditingColumnId: value.editingColumnId == columnId,
        clearSelectedColumnId: value.selectedColumnId == columnId,
      ),
    );
  }

  Future<Result<void>> save() async {
    final value = state.requireValue;
    if (!_validateAll(value)) {
      return const Error(ValidationFailure('Проверьте названия столбцов'));
    }

    state = AsyncData(value.copyWith(isSaving: true));

    final latest = state.requireValue;
    final originalById = {
      for (final column in latest.originalColumns) column.id: column,
    };
    final draftById = {
      for (final column in latest.draftColumns) column.id: column,
    };

    try {
      final tasks = await ref.read(boardTasksProvider(_boardId).future);
      for (final deletedColumnId in originalById.keys) {
        if (draftById.containsKey(deletedColumnId)) continue;

        final plan = latest.deletedColumnTaskPlans[deletedColumnId];
        final affectedTasks = tasks
            .where((task) => task.columnId == deletedColumnId)
            .toList(growable: false);
        if (affectedTasks.isNotEmpty && plan == null) {
          state = AsyncData(latest.copyWith(isSaving: false));
          return const Error(
            ValidationFailure('Выберите, что сделать с задачами столбца'),
          );
        }

        for (final task in affectedTasks) {
          final result = plan?.action == ColumnTaskDeleteAction.transferTasks
              ? await ref
                    .read(updateTaskProvider)
                    .call(
                      task.copyWith(columnId: plan?.transferTargetColumnId),
                    )
              : await ref.read(deleteTaskProvider).call(task.id);
          if (result case Error(:final failure)) {
            state = AsyncData(latest.copyWith(isSaving: false));
            return Error(failure);
          }
        }

        final deleteResult = await ref
            .read(deleteColumnProvider)
            .call(deletedColumnId);
        if (deleteResult case Error(:final failure)) {
          state = AsyncData(latest.copyWith(isSaving: false));
          return Error(failure);
        }
      }

      for (final column in latest.draftColumns) {
        if (!originalById.containsKey(column.id)) {
          final result = await ref
              .read(createColumnProvider)
              .call(
                boardId: _boardId,
                title: column.title,
                position: column.position,
                id: column.id,
              );
          if (result case Error(:final failure)) {
            state = AsyncData(latest.copyWith(isSaving: false));
            return Error(failure);
          }
          continue;
        }

        final original = originalById[column.id]!;
        if (original.title != column.title) {
          final result = await ref
              .read(updateColumnTitleProvider)
              .call(
                columnId: column.id,
                title: column.title,
              );
          if (result case Error(:final failure)) {
            state = AsyncData(latest.copyWith(isSaving: false));
            return Error(failure);
          }
        }
      }

      final reorderResult = await ref
          .read(reorderColumnsProvider)
          .call(latest.draftColumns);
      if (reorderResult case Error(:final failure)) {
        state = AsyncData(latest.copyWith(isSaving: false));
        return Error(failure);
      }

      final savedColumns = await ref.read(
        boardColumnsProvider(_boardId).future,
      );
      state = AsyncData(
        BoardConstructorState.empty().copyWith(
          originalColumns: savedColumns,
          draftColumns: savedColumns,
        ),
      );
      return const Success(null);
    } on Exception catch (error) {
      state = AsyncData(latest.copyWith(isSaving: false));
      return Error(UnexpectedFailure(error.toString()));
    }
  }

  bool _validateAll(BoardConstructorState value) {
    final errors = <String, String>{};
    for (final column in value.draftColumns) {
      final error = _validateTitle(column.title);
      if (error != null) {
        errors[column.id] = error;
      }
    }
    state = AsyncData(value.copyWith(validationErrors: errors));
    return errors.isEmpty;
  }

  String? _validateTitle(String title) {
    final trimmed = title.trim();
    if (trimmed.isEmpty) {
      return 'Название не может быть пустым';
    }
    if (trimmed.length > 50) {
      return 'Максимум 50 символов';
    }
    return null;
  }

  Map<String, String> _withoutError(
    BoardConstructorState value,
    String columnId,
  ) {
    final errors = Map<String, String>.of(value.validationErrors);
    return errors..remove(columnId);
  }

  List<BoardColumnEntity> _normalizePositions(
    List<BoardColumnEntity> columns,
  ) {
    return [
      for (var index = 0; index < columns.length; index++)
        columns[index].copyWith(position: index),
    ];
  }
}
