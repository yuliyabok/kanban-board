// Бизнес-логика авторизации: регистрация, логин, refresh/logout и текущий
// пользователь по Bearer token.
import 'package:kanban_contracts/kanban_contracts.dart';
import 'package:kanban_server/src/auth/auth_models.dart';
import 'package:kanban_server/src/auth/auth_repository.dart';
import 'package:kanban_server/src/auth/in_memory_auth_repository.dart';
import 'package:kanban_server/src/auth/jwt_service.dart';
import 'package:kanban_server/src/auth/password_hasher.dart';
import 'package:kanban_server/src/http/api_exception.dart';
import 'package:uuid/uuid.dart';

final class AuthService {
  const AuthService({
    required AuthRepository repository,
    required PasswordHasher passwordHasher,
    required JwtService jwtService,
    required Duration refreshTokenTtl,
    Uuid uuid = const Uuid(),
  }) : _repository = repository,
       _passwordHasher = passwordHasher,
       _jwtService = jwtService,
       _refreshTokenTtl = refreshTokenTtl,
       _uuid = uuid;

  final AuthRepository _repository;
  final PasswordHasher _passwordHasher;
  final JwtService _jwtService;
  final Duration _refreshTokenTtl;
  final Uuid _uuid;

  Future<AuthSessionDto> register(RegistrationDto data) async {
    final email = _normalizeEmail(data.email);
    _validateEmail(email);
    _validatePassword(data.password);

    final now = DateTime.now().toUtc();
    final salt = _passwordHasher.createSalt();
    final user = AuthUser(
      id: _uuid.v7(),
      email: email,
      fullName: _displayName(data, email),
      passwordHash: _passwordHasher.hashPassword(data.password, salt),
      passwordSalt: salt,
      createdAt: now,
      updatedAt: now,
    );

    try {
      final created = await _repository.createUser(user);
      return _createSession(created);
    } on DuplicateUserException {
      throw const ApiException(
        statusCode: 409,
        code: 'email_already_exists',
        message: 'Пользователь с такой почтой уже существует',
      );
    }
  }

  Future<AuthSessionDto> login(AuthCredentialsDto credentials) async {
    final email = _normalizeEmail(credentials.email);
    final user = await _repository.findUserByEmail(email);
    if (user == null ||
        !_passwordHasher.verifyPassword(
          password: credentials.password,
          salt: user.passwordSalt,
          expectedHash: user.passwordHash,
        )) {
      throw const ApiException(
        statusCode: 401,
        code: 'invalid_credentials',
        message: 'Неверная почта или пароль',
      );
    }

    return _createSession(user);
  }

  Future<AuthSessionDto> refresh(String refreshToken) async {
    final tokenHash = _passwordHasher.hashToken(refreshToken);
    final session = await _repository.findRefreshSessionByHash(tokenHash);
    if (session == null || !session.isActive) {
      throw const ApiException(
        statusCode: 401,
        code: 'invalid_refresh_token',
        message: 'Сессия не найдена или истекла',
      );
    }

    final user = await _repository.findUserById(session.userId);
    if (user == null) {
      throw const ApiException(
        statusCode: 401,
        code: 'user_not_found',
        message: 'Пользователь не найден',
      );
    }

    await _repository.revokeRefreshSession(tokenHash, DateTime.now().toUtc());
    return _createSession(user);
  }

  Future<void> logout(String refreshToken) async {
    final tokenHash = _passwordHasher.hashToken(refreshToken);
    await _repository.revokeRefreshSession(tokenHash, DateTime.now().toUtc());
  }

  Future<UserDto> me(String? authorizationHeader) async {
    final user = await currentUser(authorizationHeader);
    return user.toPublicDto();
  }

  Future<AuthUser> currentUser(String? authorizationHeader) async {
    final token = _bearerToken(authorizationHeader);
    final verified = token == null ? null : _jwtService.verify(token);
    if (verified == null) {
      throw const ApiException(
        statusCode: 401,
        code: 'unauthorized',
        message: 'Нужен Bearer token',
      );
    }

    final user = await _repository.findUserById(verified.userId);
    if (user == null) {
      throw const ApiException(
        statusCode: 401,
        code: 'user_not_found',
        message: 'Пользователь не найден',
      );
    }

    return user;
  }

  Future<AuthSessionDto> _createSession(AuthUser user) async {
    final refreshToken = _uuid.v7();
    final now = DateTime.now().toUtc();
    await _repository.createRefreshSession(
      RefreshSession(
        id: _uuid.v7(),
        userId: user.id,
        refreshTokenHash: _passwordHasher.hashToken(refreshToken),
        expiresAt: now.add(_refreshTokenTtl),
        createdAt: now,
      ),
    );

    return AuthSessionDto(
      userId: user.id,
      email: user.email,
      accessToken: _jwtService.createAccessToken(
        userId: user.id,
        email: user.email,
      ),
      refreshToken: refreshToken,
      expiresAt: _jwtService.accessTokenExpiresAt,
    );
  }

  String _normalizeEmail(String email) => email.trim().toLowerCase();

  void _validateEmail(String email) {
    if (!email.contains('@') || !email.contains('.')) {
      throw const ApiException(
        statusCode: 400,
        code: 'invalid_email',
        message: 'Некорректный email',
      );
    }
  }

  void _validatePassword(String password) {
    if (password.length < 6) {
      throw const ApiException(
        statusCode: 400,
        code: 'weak_password',
        message: 'Пароль должен быть не короче 6 символов',
      );
    }
  }

  String _displayName(RegistrationDto data, String email) {
    final displayName = data.displayName?.trim();
    if (displayName != null && displayName.isNotEmpty) return displayName;
    return email.split('@').first;
  }

  String? _bearerToken(String? header) {
    if (header == null) return null;
    const prefix = 'Bearer ';
    if (!header.startsWith(prefix)) return null;
    final token = header.substring(prefix.length).trim();
    return token.isEmpty ? null : token;
  }
}
