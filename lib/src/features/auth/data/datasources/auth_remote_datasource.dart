import 'dart:convert';

import 'package:uuid/uuid.dart';

import '../../../../core/error/app_exception.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/storage/secure_storage.dart';
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
    required Uuid uuid,
  }) : _storage = storage,
       _uuid = uuid;

  static const _usersKey = 'auth.local.users.v1';
  static const _refreshTokensKey = 'auth.local.refresh_tokens.v1';

  final SecureStorage _storage;
  final Uuid _uuid;

  @override
  Future<AuthSessionDto> register(RegistrationDto data) async {
    final email = data.email.trim().toLowerCase();
    final users = await _readUsers();
    if (users.containsKey(email)) {
      throw const ValidationException(
        'Пользователь с такой почтой уже существует',
      );
    }

    final user = <String, Object?>{
      'userId': _uuid.v7(),
      'email': email,
      'password': data.password,
      'displayName': data.displayName?.trim(),
    };
    users[email] = user;
    await _writeUsers(users);

    return _createSession(user);
  }

  @override
  Future<AuthSessionDto> signIn(AuthCredentialsDto credentials) async {
    final email = credentials.email.trim().toLowerCase();
    final user = (await _readUsers())[email];
    if (user == null || user['password'] != credentials.password) {
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

    final users = await _readUsers();
    final user = users[email];
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

  Future<Map<String, Map<String, Object?>>> _readUsers() async {
    final rawUsers = await _storage.read(_usersKey);
    if (rawUsers == null) {
      return {};
    }

    final decoded = jsonDecode(rawUsers);
    if (decoded is! Map<String, dynamic>) {
      return {};
    }

    return decoded.map(
      (key, value) => MapEntry(
        key,
        Map<String, Object?>.from(value as Map<String, dynamic>),
      ),
    );
  }

  Future<void> _writeUsers(Map<String, Map<String, Object?>> users) {
    return _storage.write(key: _usersKey, value: jsonEncode(users));
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

  Future<AuthSessionDto> _createSession(Map<String, Object?> user) async {
    final refreshToken = 'local-refresh-${_uuid.v7()}';
    final refreshTokens = await _readRefreshTokens();
    refreshTokens[refreshToken] = user['email']! as String;
    await _writeRefreshTokens(refreshTokens);

    return AuthSessionDto(
      userId: user['userId']! as String,
      email: user['email']! as String,
      accessToken: 'local-access-${_uuid.v7()}',
      refreshToken: refreshToken,
      expiresAt: DateTime.now().toUtc().add(const Duration(days: 30)),
    );
  }
}
