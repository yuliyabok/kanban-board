// Контракт записи истории задачи: что изменилось, когда и какой пользователь
// сделал изменение.
final class TaskHistoryEntryDto {
  const TaskHistoryEntryDto({
    required this.id,
    required this.taskId,
    required this.boardId,
    required this.action,
    required this.summary,
    required this.changedAt,
    this.details,
    this.actorUserId,
  });

  factory TaskHistoryEntryDto.fromJson(Map<String, dynamic> json) {
    return TaskHistoryEntryDto(
      id: json['id'] as String,
      taskId: json['taskId'] as String,
      boardId: json['boardId'] as String,
      action: json['action'] as String,
      summary: json['summary'] as String,
      details: (json['details'] as Map<String, dynamic>?)?.cast(),
      actorUserId: json['actorUserId'] as String?,
      changedAt: DateTime.parse(json['changedAt'] as String).toUtc(),
    );
  }

  final String id;
  final String taskId;
  final String boardId;
  final String action;
  final String summary;
  final Map<String, Object?>? details;
  final String? actorUserId;
  final DateTime changedAt;

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'taskId': taskId,
      'boardId': boardId,
      'action': action,
      'summary': summary,
      if (details != null) 'details': details,
      if (actorUserId != null) 'actorUserId': actorUserId,
      'changedAt': changedAt.toUtc().toIso8601String(),
    };
  }
}
