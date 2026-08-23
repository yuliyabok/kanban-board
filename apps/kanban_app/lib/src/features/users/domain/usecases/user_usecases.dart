import '../../../../core/error/result.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

final class SearchUsersUseCase {
  const SearchUsersUseCase(this._repository);

  final UserRepository _repository;

  Future<Result<List<UserEntity>>> call(String query) =>
      _repository.search(query);
}

final class GetUserUseCase {
  const GetUserUseCase(this._repository);

  final UserRepository _repository;

  Future<Result<UserEntity?>> call(String id) => _repository.getById(id);
}

final class UpdateCurrentUserUseCase {
  const UpdateCurrentUserUseCase(this._repository);

  final UserRepository _repository;

  Future<Result<UserEntity>> call(UserEntity user) =>
      _repository.updateMe(user);
}
