import '../../../../core/error/result.dart';
import '../entities/auth_session.dart';
import '../entities/registration_data.dart';
import '../repositories/auth_repository.dart';

final class RegisterAccount {
  const RegisterAccount(this._repository);

  final AuthRepository _repository;

  Future<Result<AuthSession>> call(RegistrationData data) {
    return _repository.register(data);
  }
}
