import '../../../../core/error/result.dart';
import '../entities/auth_credentials.dart';
import '../entities/auth_session.dart';
import '../entities/registration_data.dart';

abstract interface class AuthRepository {
  Future<Result<AuthSession?>> restoreSession();

  Future<Result<AuthSession>> signIn(AuthCredentials credentials);

  Future<Result<AuthSession>> register(RegistrationData data);

  Future<Result<AuthSession>> refreshSession(AuthSession session);

  Future<Result<void>> signOut();
}
