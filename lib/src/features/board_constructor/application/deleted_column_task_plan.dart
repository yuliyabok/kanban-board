enum ColumnTaskDeleteAction {
  deleteTasks,
  transferTasks,
}

final class DeletedColumnTaskPlan {
  const DeletedColumnTaskPlan.deleteTasks() : transferTargetColumnId = null;

  const DeletedColumnTaskPlan.transferTasks(this.transferTargetColumnId);

  final String? transferTargetColumnId;

  ColumnTaskDeleteAction get action => transferTargetColumnId == null
      ? ColumnTaskDeleteAction.deleteTasks
      : ColumnTaskDeleteAction.transferTasks;
}
