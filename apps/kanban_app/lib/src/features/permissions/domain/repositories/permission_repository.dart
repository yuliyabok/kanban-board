import '../entities/permission.dart';

abstract interface class PermissionRepository {
  Future<bool> hasBoardPermission({
    required String userId,
    required String boardId,
    required Permission permission,
  });

  Future<bool> hasWorkspacePermission({
    required String userId,
    required String workspaceId,
    required Permission permission,
  });
}
