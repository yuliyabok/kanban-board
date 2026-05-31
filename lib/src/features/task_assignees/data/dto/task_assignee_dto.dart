final class TaskAssigneeDto {
  const TaskAssigneeDto({
    required this.id,
    required this.taskId,
    required this.userId,
    required this.assignedBy,
    required this.assignedAt,
  });

  factory TaskAssigneeDto.fromJson(Map<String, dynamic> json) =>
      TaskAssigneeDto(
        id: json['id'] as String,
        taskId: json['taskId'] as String,
        userId: json['userId'] as String,
        assignedBy: json['assignedBy'] as String,
        assignedAt: DateTime.parse(json['assignedAt'] as String),
      );

  final String id;
  final String taskId;
  final String userId;
  final String assignedBy;
  final DateTime assignedAt;

  Map<String, Object?> toJson() => {
    'id': id,
    'taskId': taskId,
    'userId': userId,
    'assignedBy': assignedBy,
    'assignedAt': assignedAt.toIso8601String(),
  };
}
