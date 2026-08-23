final class DeleteTaskCommand {
  const DeleteTaskCommand({
    required this.taskId,
    this.cascade = true,
    this.actorUserId,
  });

  final String taskId;
  final bool cascade;
  final String? actorUserId;
}
