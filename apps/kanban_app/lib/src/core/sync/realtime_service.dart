// Удобный слой realtime-событий поверх WebSocket. Фичи работают с событиями,
// а не с сырыми сообщениями канала.
import 'dart:async';

import 'realtime_connection.dart';

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
  static const taskCreated = 'task.created';
  static const taskUpdated = 'task.updated';
  static const taskDeleted = 'task.deleted';
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

final class WebSocketRealtimeService implements RealtimeService {
  WebSocketRealtimeService(this._connection);

  final RealtimeConnection _connection;
  final _controller = StreamController<RealtimeEvent>.broadcast();

  StreamSubscription<Map<String, dynamic>>? _subscription;

  @override
  Stream<RealtimeEvent> get events => _controller.stream;

  @override
  Future<void> connect() async {
    await _connection.connect();
    _subscription ??= _connection.messages.listen(
      (message) {
        final event = _eventFromJson(message);
        if (event != null && !_controller.isClosed) {
          _controller.add(event);
        }
      },
      onError: _controller.addError,
    );
  }

  @override
  Future<void> disconnect() async {
    await _subscription?.cancel();
    _subscription = null;
    await _connection.close();
  }

  @override
  void publish(RealtimeEvent event) {
    unawaited(
      _connection.send({
        'type': event.type,
        'payload': event.payload,
        'occurredAt': event.occurredAt.toIso8601String(),
      }),
    );
  }

  Future<void> dispose() async {
    await disconnect();
    await _controller.close();
  }

  RealtimeEvent? _eventFromJson(Map<String, dynamic> json) {
    final type = json['type'];
    final payload = json['payload'];
    final occurredAt = json['occurredAt'];
    if (type is! String || payload is! Map<String, dynamic>) {
      return null;
    }
    return RealtimeEvent(
      type: type,
      payload: payload.cast<String, Object?>(),
      occurredAt: occurredAt is String
          ? DateTime.parse(occurredAt).toUtc()
          : DateTime.now().toUtc(),
    );
  }
}
