import '../../../../core/error/result.dart';
import '../entities/user_entity.dart';

abstract interface class UserRepository {
  Future<Result<UserEntity?>> getById(String id);

  Future<Result<List<UserEntity>>> search(String query);

  Future<Result<UserEntity>> updateMe(UserEntity user);
}
