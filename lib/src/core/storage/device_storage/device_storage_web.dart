import 'package:web/web.dart' as web;

import '../device_storage.dart';

DeviceStorage createDeviceStorage() => const WebDeviceStorage();

final class WebDeviceStorage implements DeviceStorage {
  const WebDeviceStorage();

  static const _prefix = 'kanban_board.';

  @override
  Future<String?> read(String key) async {
    return web.window.localStorage.getItem(_prefixed(key));
  }

  @override
  Future<void> write({
    required String key,
    required String value,
  }) async {
    web.window.localStorage.setItem(_prefixed(key), value);
  }

  @override
  Future<void> delete(String key) async {
    web.window.localStorage.removeItem(_prefixed(key));
  }

  String _prefixed(String key) => '$_prefix$key';
}
