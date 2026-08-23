import '../device_storage.dart';

DeviceStorage createDeviceStorage() => const UnsupportedDeviceStorage();

final class UnsupportedDeviceStorage implements DeviceStorage {
  const UnsupportedDeviceStorage();

  @override
  Future<String?> read(String key) async => null;

  @override
  Future<void> write({
    required String key,
    required String value,
  }) async {}

  @override
  Future<void> delete(String key) async {}
}
