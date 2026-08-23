final class TaskHistoryEntry {
  const TaskHistoryEntry({
    required this.id,
    required this.taskId,
    required this.boardId,
    required this.action,
    required this.summary,
    required this.changedAt,
    this.detailsJson,
    this.actorUserId,
  });

  final String id;
  final String taskId;
  final String boardId;
  final String action;
  final String summary;
  final String? detailsJson;
  final String? actorUserId;
  final DateTime changedAt;
}
