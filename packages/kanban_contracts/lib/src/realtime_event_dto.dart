// Контракт realtime-событий: сервер отправляет такие события по WebSocket,
// приложение применяет их к локальному состоянию или показывает уведомления.
final class RealtimeEventDto {
  const RealtimeEventDto({
    required this.type,
    required this.payload,
    required this.occurredAt,
  });

  factory RealtimeEventDto.fromJson(Map<String, dynamic> json) {
    return RealtimeEventDto(
      type: json['type'] as String,
      payload: (json['payload'] as Map<String, dynamic>? ?? const {})
          .cast<String, Object?>(),
      occurredAt: DateTime.parse(json['occurredAt'] as String).toUtc(),
    );
  }

  final String type;
  final Map<String, Object?> payload;
  final DateTime occurredAt;

  Map<String, Object?> toJson() {
    return {
      'type': type,
      'payload': payload,
      'occurredAt': occurredAt.toUtc().toIso8601String(),
    };
  }
}

final class RealtimeEventTypes {
  const RealtimeEventTypes._();

  static const taskCreated = 'task.created';
  static const taskUpdated = 'task.updated';
  static const taskDeleted = 'task.deleted';
  static const taskAssigned = 'task.assigned';
  static const taskUnassigned = 'task.unassigned';
  static const commentCreated = 'comment.created';
  static const commentUpdated = 'comment.updated';
  static const commentDeleted = 'comment.deleted';
  static const historyAppended = 'task.history.appended';
  static const boardMemberChanged = 'board.member.changed';
  static const workspaceMemberChanged = 'workspace.member.changed';
}
