import '../entities/permission.dart';
import '../repositories/permission_repository.dart';

final class CheckPermissionUseCase {
  const CheckPermissionUseCase(this._repository);

  final PermissionRepository _repository;

  Future<bool> call({
    required String userId,
    required String boardId,
    required Permission permission,
  }) => _repository.hasBoardPermission(
    userId: userId,
    boardId: boardId,
    permission: permission,
  );
}
