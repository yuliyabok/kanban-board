import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_local_datasource.dart';
import '../mappers/user_mapper.dart';

final class DefaultUserRepository implements UserRepository {
  const DefaultUserRepository({required UserLocalDataSource localDataSource})
    : _localDataSource = localDataSource;

  final UserLocalDataSource _localDataSource;

  @override
  Future<Result<UserEntity?>> getById(String id) async {
    try {
      return Success((await _localDataSource.getById(id))?.toEntity());
    } on Exception catch (error) {
      return Error(StorageFailure(error.toString()));
    }
  }

  @override
  Future<Result<List<UserEntity>>> search(String query) async {
    try {
      final rows = await _localDataSource.search(query);
      return Success(rows.map((row) => row.toEntity()).toList(growable: false));
    } on Exception catch (error) {
      return Error(StorageFailure(error.toString()));
    }
  }

  @override
  Future<Result<UserEntity>> updateMe(UserEntity user) async {
    final fullName = user.fullName.trim();
    if (fullName.isEmpty) {
      return const Error(ValidationFailure('Имя пользователя не пустое'));
    }

    try {
      final existing = await _localDataSource.getById(user.id);
      final updated = user.copyWith(
        fullName: fullName,
        position: _normalizeOptional(user.position),
        avatarUrl: _normalizeOptional(user.avatarUrl),
        updatedAt: DateTime.now().toUtc(),
      );
      await _localDataSource.upsert(
        updated.toCompanion(
          passwordHash: existing?.passwordHash,
          passwordSalt: existing?.passwordSalt,
        ),
      );
      return Success(updated);
    } on Exception catch (error) {
      return Error(StorageFailure(error.toString()));
    }
  }

  String? _normalizeOptional(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }
}
