import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../../columns/domain/entities/board_column_entity.dart';
import '../../../columns/domain/policies/column_policy.dart';
import '../../../columns/presentation/providers/column_providers.dart';
import '../../../tasks/presentation/providers/task_providers.dart';
import '../../application/board_constructor_service.dart';
import '../../application/deleted_column_task_plan.dart';
import 'board_constructor_state.dart';

final boardConstructorServiceProvider = Provider<BoardConstructorService>((
  ref,
) {
  return DefaultBoardConstructorService(
    columnRepository: ref.watch(columnRepositoryProvider),
    taskRepository: ref.watch(taskRepositoryProvider),
  );
});

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

    final result = await ref
        .read(boardConstructorServiceProvider)
        .saveDraft(
          boardId: _boardId,
          originalColumns: latest.originalColumns,
          draftColumns: latest.draftColumns,
          deletedColumnTaskPlans: latest.deletedColumnTaskPlans,
        );

    switch (result) {
      case Success(:final value):
        state = AsyncData(
          BoardConstructorState.empty().copyWith(
            originalColumns: value,
            draftColumns: value,
          ),
        );
        return const Success(null);
      case Error(:final failure):
        state = AsyncData(latest.copyWith(isSaving: false));
        return Error(failure);
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
    return ColumnPolicy.validateTitle(title)?.message;
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
    return ColumnPolicy.normalizePositions(
      columns,
      (column, position) => column.copyWith(position: position),
    );
  }
}
