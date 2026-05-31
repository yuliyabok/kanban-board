import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../permissions/domain/entities/permission.dart';
import '../../domain/entities/workspace_entity.dart';

extension WorkspaceRowMapper on WorkspacesTableData {
  WorkspaceEntity toEntity() => WorkspaceEntity(
    id: id,
    name: name,
    ownerId: ownerId,
    createdAt: createdAt,
    updatedAt: updatedAt,
    isSynced: isSynced,
  );
}

extension WorkspaceEntityMapper on WorkspaceEntity {
  WorkspacesTableCompanion toCompanion({String? syncAction}) =>
      WorkspacesTableCompanion.insert(
        id: id,
        name: name,
        ownerId: ownerId,
        createdAt: createdAt,
        updatedAt: updatedAt,
        isSynced: Value(isSynced),
        syncAction: Value(syncAction),
      );
}

extension WorkspaceMemberRowMapper on WorkspaceMembersTableData {
  WorkspaceMemberEntity toEntity() => WorkspaceMemberEntity(
    id: id,
    workspaceId: workspaceId,
    userId: userId,
    role: WorkspaceRole.parse(role),
    joinedAt: joinedAt,
    isSynced: isSynced,
  );
}

extension WorkspaceMemberEntityMapper on WorkspaceMemberEntity {
  WorkspaceMembersTableCompanion toCompanion({String? syncAction}) =>
      WorkspaceMembersTableCompanion.insert(
        id: id,
        workspaceId: workspaceId,
        userId: userId,
        role: role.name,
        joinedAt: joinedAt,
        isSynced: Value(isSynced),
        syncAction: Value(syncAction),
      );
}
