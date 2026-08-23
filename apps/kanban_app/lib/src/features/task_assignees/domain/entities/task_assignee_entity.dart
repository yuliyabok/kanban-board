final class TaskAssigneeEntity {
  const TaskAssigneeEntity({
    required this.id,
    required this.taskId,
    required this.userId,
    required this.assignedBy,
    required this.assignedAt,
    this.isSynced = false,
  });

  final String id;
  final String taskId;
  final String userId;
  final String assignedBy;
  final DateTime assignedAt;
  final bool isSynced;
}
