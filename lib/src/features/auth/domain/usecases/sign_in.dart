import '../../../../core/error/result.dart';
import '../entities/auth_credentials.dart';
import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

final class SignIn {
  const SignIn(this._repository);

  final AuthRepository _repository;

  Future<Result<AuthSession>> call(AuthCredentials credentials) {
    return _repository.signIn(credentials);
  }
}
