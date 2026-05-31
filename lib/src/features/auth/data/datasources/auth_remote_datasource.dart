import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/error/app_exception.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/storage/secure_storage.dart';
import '../../../users/data/datasources/user_local_datasource.dart';
import '../../../users/data/mappers/user_mapper.dart';
import '../../../users/domain/entities/user_entity.dart';
import '../dto/auth_credentials_dto.dart';
import '../dto/registration_dto.dart';
import '../dto/auth_session_dto.dart';

abstract interface class AuthRemoteDataSource {
  Future<AuthSessionDto> signIn(AuthCredentialsDto credentials);

  Future<AuthSessionDto> register(RegistrationDto data);

  Future<AuthSessionDto> refresh(String refreshToken);

  Future<void> signOut(String refreshToken);
}

final class ApiAuthRemoteDataSource implements AuthRemoteDataSource {
  const ApiAuthRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<AuthSessionDto> signIn(AuthCredentialsDto credentials) async {
    final response = await _apiClient.postJson(
      '/auth/login',
      body: credentials.toJson(),
    );
    return AuthSessionDto.fromJson(response);
  }

  @override
  Future<AuthSessionDto> register(RegistrationDto data) async {
    final response = await _apiClient.postJson(
      '/auth/register',
      body: data.toJson(),
    );
    return AuthSessionDto.fromJson(response);
  }

  @override
  Future<AuthSessionDto> refresh(String refreshToken) async {
    final response = await _apiClient.postJson(
      '/auth/refresh',
      body: {'refreshToken': refreshToken},
    );
    return AuthSessionDto.fromJson(response);
  }

  @override
  Future<void> signOut(String refreshToken) {
    return _apiClient.postJson(
      '/auth/logout',
      body: {'refreshToken': refreshToken},
    );
  }
}

final class LocalAuthRemoteDataSource implements AuthRemoteDataSource {
  const LocalAuthRemoteDataSource({
    required SecureStorage storage,
    required UserLocalDataSource userLocalDataSource,
    required Uuid uuid,
  }) : _storage = storage,
       _userLocalDataSource = userLocalDataSource,
       _uuid = uuid;

  static const _refreshTokensKey = 'auth.local.refresh_tokens.v1';

  final SecureStorage _storage;
  final UserLocalDataSource _userLocalDataSource;
  final Uuid _uuid;

  @override
  Future<AuthSessionDto> register(RegistrationDto data) async {
    final email = data.email.trim().toLowerCase();
    final existing = await _userLocalDataSource.getByEmail(email);
    if (existing != null) {
      throw const ValidationException(
        'Пользователь с такой почтой уже существует',
      );
    }

    final now = DateTime.now().toUtc();
    final salt = _uuid.v7();
    final user = UserEntity(
      id: _uuid.v7(),
      email: email,
      fullName: _displayName(data, email),
      position: null,
      createdAt: now,
      updatedAt: now,
    );
    await _userLocalDataSource.upsert(
      user.toCompanion(
        passwordHash: _hashPassword(data.password, salt),
        passwordSalt: salt,
      ),
    );

    final stored = await _userLocalDataSource.getByEmail(email);
    if (stored == null) {
      throw const LocalStorageException('Пользователь не сохранен');
    }
    return _createSession(stored);
  }

  @override
  Future<AuthSessionDto> signIn(AuthCredentialsDto credentials) async {
    final email = credentials.email.trim().toLowerCase();
    final user = await _userLocalDataSource.getByEmail(email);
    if (user == null ||
        user.passwordHash == null ||
        user.passwordSalt == null ||
        user.passwordHash !=
            _hashPassword(credentials.password, user.passwordSalt!)) {
      throw const ValidationException('Неверная почта или пароль');
    }

    return _createSession(user);
  }

  @override
  Future<AuthSessionDto> refresh(String refreshToken) async {
    final refreshTokens = await _readRefreshTokens();
    final email = refreshTokens[refreshToken];
    if (email == null) {
      throw const ValidationException('Сессия не найдена');
    }

    final user = await _userLocalDataSource.getByEmail(email);
    if (user == null) {
      throw const ValidationException('Пользователь не найден');
    }

    return _createSession(user);
  }

  @override
  Future<void> signOut(String refreshToken) async {
    final refreshTokens = await _readRefreshTokens();
    refreshTokens.remove(refreshToken);
    await _writeRefreshTokens(refreshTokens);
  }

  Future<Map<String, String>> _readRefreshTokens() async {
    final rawTokens = await _storage.read(_refreshTokensKey);
    if (rawTokens == null) {
      return {};
    }

    final decoded = jsonDecode(rawTokens);
    if (decoded is! Map<String, dynamic>) {
      return {};
    }

    return decoded.map((key, value) => MapEntry(key, value as String));
  }

  Future<void> _writeRefreshTokens(Map<String, String> refreshTokens) {
    return _storage.write(
      key: _refreshTokensKey,
      value: jsonEncode(refreshTokens),
    );
  }

  Future<AuthSessionDto> _createSession(UsersTableData user) async {
    final refreshToken = 'local-refresh-${_uuid.v7()}';
    final refreshTokens = await _readRefreshTokens();
    refreshTokens[refreshToken] = user.email;
    await _writeRefreshTokens(refreshTokens);

    return AuthSessionDto(
      userId: user.id,
      email: user.email,
      accessToken: 'local-access-${_uuid.v7()}',
      refreshToken: refreshToken,
      expiresAt: DateTime.now().toUtc().add(const Duration(days: 30)),
    );
  }

  String _displayName(RegistrationDto data, String email) {
    final displayName = data.displayName?.trim();
    if (displayName != null && displayName.isNotEmpty) return displayName;
    return email.split('@').first;
  }

  String _hashPassword(String password, String salt) {
    return sha256.convert(utf8.encode('$salt:$password')).toString();
  }
}
