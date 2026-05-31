final class CreateTaskCommand {
  const CreateTaskCommand({
    required this.boardId,
    required this.title,
    this.columnId,
    this.parentTaskId,
    this.taskTypeId,
    this.description,
  });

  final String boardId;
  final String title;
  final String? columnId;
  final String? parentTaskId;
  final String? taskTypeId;
  final String? description;
}
