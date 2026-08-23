// In-memory AuthRepository для быстрых server tests без живого PostgreSQL.
import 'package:kanban_server/src/auth/auth_models.dart';
import 'package:kanban_server/src/auth/auth_repository.dart';

final class InMemoryAuthRepository implements AuthRepository {
  final _usersById = <String, AuthUser>{};
  final _refreshSessionsByHash = <String, RefreshSession>{};

  @override
  Future<AuthUser> createUser(AuthUser user) async {
    if (_usersById.values.any((item) => item.email == user.email)) {
      throw const DuplicateUserException();
    }
    _usersById[user.id] = user;
    return user;
  }

  @override
  Future<RefreshSession> createRefreshSession(RefreshSession session) async {
    _refreshSessionsByHash[session.refreshTokenHash] = session;
    return session;
  }

  @override
  Future<AuthUser?> findUserByEmail(String email) async {
    return _usersById.values.where((item) => item.email == email).firstOrNull;
  }

  @override
  Future<AuthUser?> findUserById(String id) async {
    return _usersById[id];
  }

  @override
  Future<RefreshSession?> findRefreshSessionByHash(
    String refreshTokenHash,
  ) async {
    return _refreshSessionsByHash[refreshTokenHash];
  }

  @override
  Future<void> revokeRefreshSession(
    String refreshTokenHash,
    DateTime revokedAt,
  ) async {
    final session = _refreshSessionsByHash[refreshTokenHash];
    if (session == null) return;
    _refreshSessionsByHash[refreshTokenHash] = RefreshSession(
      id: session.id,
      userId: session.userId,
      refreshTokenHash: session.refreshTokenHash,
      expiresAt: session.expiresAt,
      createdAt: session.createdAt,
      revokedAt: revokedAt,
    );
  }
}

final class DuplicateUserException implements Exception {
  const DuplicateUserException();
}
