// Интерфейс хранения auth-данных. Handlers/AuthService не знают, PostgreSQL
// это или in-memory реализация для тестов.
import 'package:kanban_server/src/auth/auth_models.dart';

abstract interface class AuthRepository {
  Future<AuthUser?> findUserByEmail(String email);

  Future<AuthUser?> findUserById(String id);

  Future<AuthUser> createUser(AuthUser user);

  Future<RefreshSession> createRefreshSession(RefreshSession session);

  Future<RefreshSession?> findRefreshSessionByHash(String refreshTokenHash);

  Future<void> revokeRefreshSession(
    String refreshTokenHash,
    DateTime revokedAt,
  );
}
