import 'dart:convert';

import '../../../../core/storage/secure_storage.dart';
import '../dto/auth_session_dto.dart';

abstract interface class AuthLocalDataSource {
  Future<AuthSessionDto?> readSession();

  Future<void> saveSession(AuthSessionDto session);

  Future<void> clearSession();
}

final class SecureAuthLocalDataSource implements AuthLocalDataSource {
  const SecureAuthLocalDataSource(this._storage);

  static const _sessionKey = 'auth.session.v1';
  static const _trustedDeviceSessionKey = 'auth.trusted_device.session.v1';

  final SecureStorage _storage;

  @override
  Future<AuthSessionDto?> readSession() async {
    final activeSession = await _readSession(_sessionKey);
    if (activeSession != null) {
      return activeSession;
    }

    return _readSession(_trustedDeviceSessionKey);
  }

  @override
  Future<void> saveSession(AuthSessionDto session) async {
    final value = jsonEncode(session.toJson());
    await _storage.write(
      key: _sessionKey,
      value: value,
    );
    await _storage.write(
      key: _trustedDeviceSessionKey,
      value: value,
    );
  }

  @override
  Future<void> clearSession() async {
    await _storage.delete(_sessionKey);
    await _storage.delete(_trustedDeviceSessionKey);
  }

  Future<AuthSessionDto?> _readSession(String key) async {
    final rawSession = await _storage.read(key);
    if (rawSession == null) {
      return null;
    }

    final json = jsonDecode(rawSession);
    if (json is! Map<String, dynamic>) {
      await _storage.delete(key);
      return null;
    }

    return AuthSessionDto.fromJson(json);
  }
}
