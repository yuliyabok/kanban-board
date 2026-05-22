import 'device_storage/device_storage_stub.dart'
    if (dart.library.io) 'device_storage/device_storage_io.dart'
    if (dart.library.html) 'device_storage/device_storage_web.dart'
    as impl;

abstract interface class DeviceStorage {
  Future<String?> read(String key);

  Future<void> write({
    required String key,
    required String value,
  });

  Future<void> delete(String key);
}

DeviceStorage createDeviceStorage() => impl.createDeviceStorage();
