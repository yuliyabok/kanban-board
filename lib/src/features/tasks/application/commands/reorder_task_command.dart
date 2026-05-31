final class ReorderTaskCommand {
  const ReorderTaskCommand({
    required this.boardId,
    required this.oldIndex,
    required this.newIndex,
    this.columnId,
  });

  final String boardId;
  final int oldIndex;
  final int newIndex;
  final String? columnId;
}
