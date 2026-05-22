import '../../../../core/error/result.dart';
import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

final class RefreshSession {
  const RefreshSession(this._repository);

  final AuthRepository _repository;

  Future<Result<AuthSession>> call(AuthSession session) {
    return _repository.refreshSession(session);
  }
}
