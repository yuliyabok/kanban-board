import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/permission.dart';
import '../../domain/repositories/permission_repository.dart';

final class DefaultPermissionRepository implements PermissionRepository {
  const DefaultPermissionRepository(this._database);

  final AppDatabase _database;

  @override
  Future<bool> hasBoardPermission({
    required String userId,
    required String boardId,
    required Permission permission,
  }) async {
    final boardMember =
        await (_database.select(_database.boardMembersTable)..where(
              (table) =>
                  table.boardId.equals(boardId) & table.userId.equals(userId),
            ))
            .getSingleOrNull();
    if (boardMember != null &&
        _boardPermissions(
          BoardRole.parse(boardMember.role),
        ).contains(permission)) {
      return true;
    }

    final board = await (_database.select(
      _database.boardsTable,
    )..where((table) => table.id.equals(boardId))).getSingleOrNull();
    final workspaceId = board?.workspaceId;
    if (workspaceId == null) return board?.ownerId == userId;
    return hasWorkspacePermission(
      userId: userId,
      workspaceId: workspaceId,
      permission: permission,
    );
  }

  @override
  Future<bool> hasWorkspacePermission({
    required String userId,
    required String workspaceId,
    required Permission permission,
  }) async {
    final member =
        await (_database.select(_database.workspaceMembersTable)..where(
              (table) =>
                  table.workspaceId.equals(workspaceId) &
                  table.userId.equals(userId),
            ))
            .getSingleOrNull();
    if (member == null) return false;
    return _workspacePermissions(
      WorkspaceRole.parse(member.role),
    ).contains(permission);
  }

  Set<Permission> _workspacePermissions(WorkspaceRole role) {
    return switch (role) {
      WorkspaceRole.owner => Permission.values.toSet(),
      WorkspaceRole.admin => {
        Permission.viewBoard,
        Permission.editBoard,
        Permission.manageBoard,
        Permission.inviteMembers,
        Permission.removeMembers,
        Permission.createTask,
        Permission.editTask,
        Permission.deleteTask,
        Permission.moveTask,
        Permission.assignTask,
        Permission.commentTask,
        Permission.deleteComment,
        Permission.manageWorkspace,
      },
      WorkspaceRole.member => {
        Permission.viewBoard,
        Permission.createTask,
        Permission.editTask,
        Permission.moveTask,
        Permission.assignTask,
        Permission.commentTask,
      },
      WorkspaceRole.viewer => {Permission.viewBoard},
    };
  }

  Set<Permission> _boardPermissions(BoardRole role) {
    return switch (role) {
      BoardRole.admin => {
        Permission.viewBoard,
        Permission.editBoard,
        Permission.manageBoard,
        Permission.inviteMembers,
        Permission.removeMembers,
        Permission.createTask,
        Permission.editTask,
        Permission.deleteTask,
        Permission.moveTask,
        Permission.assignTask,
        Permission.commentTask,
        Permission.deleteComment,
      },
      BoardRole.editor => {
        Permission.viewBoard,
        Permission.editBoard,
        Permission.createTask,
        Permission.editTask,
        Permission.moveTask,
        Permission.assignTask,
        Permission.commentTask,
      },
      BoardRole.commenter => {
        Permission.viewBoard,
        Permission.commentTask,
      },
      BoardRole.viewer => {Permission.viewBoard},
    };
  }
}
