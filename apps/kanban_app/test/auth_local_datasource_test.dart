import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board/src/core/storage/secure_storage.dart';
import 'package:kanban_board/src/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:kanban_board/src/features/auth/data/dto/auth_session_dto.dart';

void main() {
  test('stores and restores session', () async {
    final storage = _MemorySecureStorage();
    final dataSource = SecureAuthLocalDataSource(storage);
    final session = _session();

    await dataSource.saveSession(session);

    expect(await dataSource.readSession(), session);
  });

  test('clears stored session', () async {
    final storage = _MemorySecureStorage();
    final dataSource = SecureAuthLocalDataSource(storage);

    await dataSource.saveSession(_session());
    await dataSource.clearSession();

    expect(await dataSource.readSession(), isNull);
  });
}

AuthSessionDto _session() {
  return AuthSessionDto(
    userId: 'user-1',
    email: 'user@example.com',
    accessToken: 'access-token',
    refreshToken: 'refresh-token',
    expiresAt: DateTime.utc(2026, 5, 22, 12),
  );
}

final class _MemorySecureStorage implements SecureStorage {
  final _values = <String, String>{};

  @override
  Future<String?> read(String key) async => _values[key];

  @override
  Future<void> write({
    required String key,
    required String value,
  }) async {
    _values[key] = value;
  }

  @override
  Future<void> delete(String key) async {
    _values.remove(key);
  }
}
