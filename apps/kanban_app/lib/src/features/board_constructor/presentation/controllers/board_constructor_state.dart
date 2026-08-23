import '../../application/deleted_column_task_plan.dart';
import '../../../columns/domain/entities/board_column_entity.dart';

final class BoardConstructorState {
  const BoardConstructorState({
    required this.isConstructorMode,
    required this.originalColumns,
    required this.draftColumns,
    required this.validationErrors,
    required this.deletedColumnTaskPlans,
    this.selectedColumnId,
    this.editingColumnId,
    this.isSaving = false,
  });

  factory BoardConstructorState.empty() {
    return const BoardConstructorState(
      isConstructorMode: false,
      originalColumns: [],
      draftColumns: [],
      validationErrors: {},
      deletedColumnTaskPlans: {},
    );
  }

  final bool isConstructorMode;
  final List<BoardColumnEntity> originalColumns;
  final List<BoardColumnEntity> draftColumns;
  final String? selectedColumnId;
  final String? editingColumnId;
  final bool isSaving;
  final Map<String, String> validationErrors;
  final Map<String, DeletedColumnTaskPlan> deletedColumnTaskPlans;

  bool get hasUnsavedChanges {
    if (originalColumns.length != draftColumns.length) {
      return true;
    }

    for (var index = 0; index < originalColumns.length; index++) {
      final original = originalColumns[index];
      final draft = draftColumns[index];
      if (original.id != draft.id ||
          original.title != draft.title ||
          original.position != draft.position) {
        return true;
      }
    }

    return deletedColumnTaskPlans.isNotEmpty;
  }

  BoardConstructorState copyWith({
    bool? isConstructorMode,
    List<BoardColumnEntity>? originalColumns,
    List<BoardColumnEntity>? draftColumns,
    String? selectedColumnId,
    String? editingColumnId,
    bool clearSelectedColumnId = false,
    bool clearEditingColumnId = false,
    bool? isSaving,
    Map<String, String>? validationErrors,
    Map<String, DeletedColumnTaskPlan>? deletedColumnTaskPlans,
  }) {
    return BoardConstructorState(
      isConstructorMode: isConstructorMode ?? this.isConstructorMode,
      originalColumns: originalColumns ?? this.originalColumns,
      draftColumns: draftColumns ?? this.draftColumns,
      selectedColumnId: clearSelectedColumnId
          ? null
          : selectedColumnId ?? this.selectedColumnId,
      editingColumnId: clearEditingColumnId
          ? null
          : editingColumnId ?? this.editingColumnId,
      isSaving: isSaving ?? this.isSaving,
      validationErrors: validationErrors ?? this.validationErrors,
      deletedColumnTaskPlans:
          deletedColumnTaskPlans ?? this.deletedColumnTaskPlans,
    );
  }
}
