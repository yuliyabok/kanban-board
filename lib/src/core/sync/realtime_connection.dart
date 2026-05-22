import 'dart:async';

import 'package:web_socket_channel/web_socket_channel.dart';

import '../config/app_config.dart';
import '../error/app_exception.dart';

abstract interface class RealtimeConnection {
  Stream<Map<String, dynamic>> get messages;

  Future<void> connect();

  Future<void> send(Map<String, dynamic> message);

  Future<void> close();
}

final class WebSocketRealtimeConnection implements RealtimeConnection {
  WebSocketRealtimeConnection(this._config);

  final AppConfig _config;
  final _controller = StreamController<Map<String, dynamic>>.broadcast();

  WebSocketChannel? _channel;
  StreamSubscription<dynamic>? _subscription;

  @override
  Stream<Map<String, dynamic>> get messages => _controller.stream;

  @override
  Future<void> connect() async {
    if (_channel != null) {
      return;
    }

    final channel = WebSocketChannel.connect(Uri.parse(_config.webSocketUrl));
    _channel = channel;
    _subscription = channel.stream.listen(
      (event) {
        if (event is Map<String, dynamic>) {
          _controller.add(event);
        }
      },
      onError: _controller.addError,
      onDone: () => _channel = null,
    );
  }

  @override
  Future<void> send(Map<String, dynamic> message) async {
    final channel = _channel;
    if (channel == null) {
      throw const NetworkException('Realtime connection is not open');
    }
    channel.sink.add(message);
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    await _channel?.sink.close();
    await _controller.close();
  }
}
