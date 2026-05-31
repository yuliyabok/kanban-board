final class DeleteTaskCommand {
  const DeleteTaskCommand({
    required this.taskId,
    this.cascade = true,
  });

  final String taskId;
  final bool cascade;
}
