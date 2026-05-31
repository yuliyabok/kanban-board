import 'dart:async';

typedef RealtimeEventHandler = void Function(RealtimeEvent event);

final class RealtimeEvent {
  const RealtimeEvent({
    required this.type,
    required this.payload,
    required this.occurredAt,
  });

  final String type;
  final Map<String, Object?> payload;
  final DateTime occurredAt;
}

abstract interface class RealtimeService {
  Stream<RealtimeEvent> get events;

  Future<void> connect();

  Future<void> disconnect();

  void publish(RealtimeEvent event);
}

final class RealtimeEvents {
  const RealtimeEvents._();

  static const userJoinedBoard = 'user.joinedBoard';
  static const userLeftBoard = 'user.leftBoard';
  static const taskAssigned = 'task.assigned';
  static const taskUnassigned = 'task.unassigned';
  static const commentCreated = 'comment.created';
  static const commentUpdated = 'comment.updated';
  static const commentDeleted = 'comment.deleted';
  static const invitationCreated = 'invitation.created';
  static const invitationAccepted = 'invitation.accepted';
}

final class MockRealtimeService implements RealtimeService {
  final _controller = StreamController<RealtimeEvent>.broadcast();

  @override
  Stream<RealtimeEvent> get events => _controller.stream;

  @override
  Future<void> connect() async {}

  @override
  Future<void> disconnect() async {}

  @override
  void publish(RealtimeEvent event) {
    if (!_controller.isClosed) {
      _controller.add(event);
    }
  }

  Future<void> dispose() async {
    await _controller.close();
  }
}
