import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../domain/entities/auth_credentials.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/entities/registration_data.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';
import '../mappers/auth_mapper.dart';

final class DefaultAuthRepository implements AuthRepository {
  const DefaultAuthRepository({
    required AuthLocalDataSource localDataSource,
    required AuthRemoteDataSource remoteDataSource,
  }) : _localDataSource = localDataSource,
       _remoteDataSource = remoteDataSource;

  final AuthLocalDataSource _localDataSource;
  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<Result<AuthSession?>> restoreSession() async {
    try {
      final session = await _localDataSource.readSession();
      if (session == null) {
        return const Success(null);
      }

      final entity = session.toEntity();
      if (_isExpired(entity)) {
        final refreshResult = await refreshSession(entity);
        return refreshResult.fold(
          onSuccess: Success.new,
          onFailure: (_) => Success(entity),
        );
      }

      return Success(entity);
    } on Exception catch (error) {
      return Error(StorageFailure(error.toString()));
    }
  }

  @override
  Future<Result<AuthSession>> signIn(AuthCredentials credentials) async {
    final email = credentials.email.trim().toLowerCase();
    if (email.isEmpty || credentials.password.isEmpty) {
      return const Error(
        ValidationFailure('Укажите почту и пароль'),
      );
    }

    try {
      final session = await _remoteDataSource.signIn(
        credentials.copyWith(email: email).toDto(),
      );
      await _localDataSource.saveSession(session);
      return Success(session.toEntity());
    } on Exception catch (error) {
      return Error(NetworkFailure(error.toString()));
    }
  }

  @override
  Future<Result<AuthSession>> register(RegistrationData data) async {
    final email = data.email.trim().toLowerCase();
    final displayName = data.displayName?.trim();
    if (email.isEmpty || data.password.isEmpty) {
      return const Error(
        ValidationFailure('Укажите почту и пароль'),
      );
    }
    if (data.password.length < 8) {
      return const Error(
        ValidationFailure('Пароль должен содержать минимум 8 символов'),
      );
    }

    try {
      final session = await _remoteDataSource.register(
        data
            .copyWith(
              email: email,
              displayName: displayName?.isEmpty ?? true ? null : displayName,
            )
            .toDto(),
      );
      await _localDataSource.saveSession(session);
      return Success(session.toEntity());
    } on Exception catch (error) {
      return Error(NetworkFailure(error.toString()));
    }
  }

  @override
  Future<Result<AuthSession>> refreshSession(AuthSession session) async {
    try {
      final refreshed = await _remoteDataSource.refresh(session.refreshToken);
      await _localDataSource.saveSession(refreshed);
      return Success(refreshed.toEntity());
    } on Exception catch (error) {
      return Error(NetworkFailure(error.toString()));
    }
  }

  @override
  Future<Result<void>> signOut() async {
    try {
      final session = await _localDataSource.readSession();
      if (session != null) {
        await _remoteDataSource.signOut(session.refreshToken);
      }
    } on Exception {
      // Local sign-out must win even when the backend is unavailable.
    } finally {
      await _localDataSource.clearSession();
    }

    return const Success(null);
  }

  bool _isExpired(AuthSession session) {
    final refreshWindow = DateTime.now().toUtc().add(
      const Duration(minutes: 1),
    );
    return !session.expiresAt.toUtc().isAfter(refreshWindow);
  }
}
