import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../error/app_exception.dart';
import 'device_storage.dart';

abstract interface class SecureStorage {
  Future<String?> read(String key);

  Future<void> write({
    required String key,
    required String value,
  });

  Future<void> delete(String key);
}

final class FlutterSecureStorageAdapter implements SecureStorage {
  FlutterSecureStorageAdapter({
    FlutterSecureStorage? storage,
    DeviceStorage? deviceStorage,
  }) : _storage = storage ?? const FlutterSecureStorage(),
       _deviceStorage = deviceStorage ?? createDeviceStorage();

  final FlutterSecureStorage _storage;
  final DeviceStorage _deviceStorage;

  @override
  Future<String?> read(String key) async {
    Object? secureStorageError;
    StackTrace? secureStorageStackTrace;

    try {
      final value = await _storage.read(key: key);
      if (value != null) {
        return value;
      }
    } on Exception catch (error, stackTrace) {
      secureStorageError = error;
      secureStorageStackTrace = stackTrace;
    }

    try {
      return await _deviceStorage.read(key);
    } on Exception catch (error, stackTrace) {
      throw LocalStorageException(
        'Failed to read secure storage value',
        cause: secureStorageError ?? error,
        stackTrace: secureStorageStackTrace ?? stackTrace,
      );
    }
  }

  @override
  Future<void> write({
    required String key,
    required String value,
  }) async {
    var didWriteSecureStorage = false;
    Object? secureStorageError;
    StackTrace? secureStorageStackTrace;

    try {
      await _storage.write(key: key, value: value);
      didWriteSecureStorage = true;
    } on Exception catch (error, stackTrace) {
      secureStorageError = error;
      secureStorageStackTrace = stackTrace;
    }

    try {
      await _deviceStorage.write(key: key, value: value);
    } on Exception catch (error, stackTrace) {
      if (didWriteSecureStorage) {
        return;
      }

      throw LocalStorageException(
        'Failed to write secure storage value',
        cause: secureStorageError ?? error,
        stackTrace: secureStorageStackTrace ?? stackTrace,
      );
    }
  }

  @override
  Future<void> delete(String key) async {
    var didDeleteSecureStorage = false;
    Object? secureStorageError;
    StackTrace? secureStorageStackTrace;

    try {
      await _storage.delete(key: key);
      didDeleteSecureStorage = true;
    } on Exception catch (error, stackTrace) {
      secureStorageError = error;
      secureStorageStackTrace = stackTrace;
    }

    try {
      await _deviceStorage.delete(key);
    } on Exception catch (error, stackTrace) {
      if (didDeleteSecureStorage) {
        return;
      }

      throw LocalStorageException(
        'Failed to delete secure storage value',
        cause: secureStorageError ?? error,
        stackTrace: secureStorageStackTrace ?? stackTrace,
      );
    }
  }
}
