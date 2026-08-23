// PostgreSQL-реализация AuthRepository для production server.
import 'package:kanban_server/src/auth/auth_models.dart';
import 'package:kanban_server/src/auth/auth_repository.dart';
import 'package:kanban_server/src/auth/in_memory_auth_repository.dart';
import 'package:kanban_server/src/database/postgres_database.dart';

final class PostgresAuthRepository implements AuthRepository {
  const PostgresAuthRepository(this._database);

  final PostgresDatabase _database;

  @override
  Future<AuthUser> createUser(AuthUser user) async {
    try {
      await _database.execute(
        '''
        INSERT INTO users (
          id, email, full_name, position, avatar_url, password_hash,
          password_salt, created_at, updated_at
        ) VALUES (
          @id:uuid, @email, @fullName, @position, @avatarUrl, @passwordHash,
          @passwordSalt, @createdAt, @updatedAt
        )
        ''',
        parameters: {
          'id': user.id,
          'email': user.email,
          'fullName': user.fullName,
          'position': user.position,
          'avatarUrl': user.avatarUrl,
          'passwordHash': user.passwordHash,
          'passwordSalt': user.passwordSalt,
          'createdAt': user.createdAt,
          'updatedAt': user.updatedAt,
        },
        ignoreRows: true,
      );
      return user;
    } on Object {
      throw const DuplicateUserException();
    }
  }

  @override
  Future<RefreshSession> createRefreshSession(RefreshSession session) async {
    await _database.execute(
      '''
      INSERT INTO refresh_sessions (
        id, user_id, refresh_token_hash, expires_at, revoked_at, created_at
      ) VALUES (
        @id:uuid, @userId:uuid, @refreshTokenHash, @expiresAt, @revokedAt,
        @createdAt
      )
      ''',
      parameters: {
        'id': session.id,
        'userId': session.userId,
        'refreshTokenHash': session.refreshTokenHash,
        'expiresAt': session.expiresAt,
        'revokedAt': session.revokedAt,
        'createdAt': session.createdAt,
      },
      ignoreRows: true,
    );
    return session;
  }

  @override
  Future<AuthUser?> findUserByEmail(String email) async {
    final result = await _database.execute(
      'SELECT * FROM users WHERE email = @email LIMIT 1',
      parameters: {'email': email},
    );
    return result.isEmpty ? null : _userFromRow(result.single.toColumnMap());
  }

  @override
  Future<AuthUser?> findUserById(String id) async {
    final result = await _database.execute(
      'SELECT * FROM users WHERE id = @id:uuid LIMIT 1',
      parameters: {'id': id},
    );
    return result.isEmpty ? null : _userFromRow(result.single.toColumnMap());
  }

  @override
  Future<RefreshSession?> findRefreshSessionByHash(
    String refreshTokenHash,
  ) async {
    final result = await _database.execute(
      'SELECT * FROM refresh_sessions WHERE refresh_token_hash = @hash LIMIT 1',
      parameters: {'hash': refreshTokenHash},
    );
    return result.isEmpty ? null : _sessionFromRow(result.single.toColumnMap());
  }

  @override
  Future<void> revokeRefreshSession(
    String refreshTokenHash,
    DateTime revokedAt,
  ) async {
    await _database.execute(
      '''
      UPDATE refresh_sessions
      SET revoked_at = @revokedAt
      WHERE refresh_token_hash = @hash
      ''',
      parameters: {
        'hash': refreshTokenHash,
        'revokedAt': revokedAt,
      },
      ignoreRows: true,
    );
  }

  AuthUser _userFromRow(Map<String, dynamic> row) {
    return AuthUser(
      id: row['id'].toString(),
      email: row['email'] as String,
      fullName: row['full_name'] as String,
      position: row['position'] as String?,
      avatarUrl: row['avatar_url'] as String?,
      passwordHash: row['password_hash'] as String,
      passwordSalt: row['password_salt'] as String,
      createdAt: (row['created_at'] as DateTime).toUtc(),
      updatedAt: (row['updated_at'] as DateTime).toUtc(),
    );
  }

  RefreshSession _sessionFromRow(Map<String, dynamic> row) {
    return RefreshSession(
      id: row['id'].toString(),
      userId: row['user_id'].toString(),
      refreshTokenHash: row['refresh_token_hash'] as String,
      expiresAt: (row['expires_at'] as DateTime).toUtc(),
      revokedAt: (row['revoked_at'] as DateTime?)?.toUtc(),
      createdAt: (row['created_at'] as DateTime).toUtc(),
    );
  }
}
