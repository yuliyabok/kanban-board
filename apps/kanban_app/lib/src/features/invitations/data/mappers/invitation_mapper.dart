import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/invitation_entity.dart';

extension InvitationRowMapper on InvitationsTableData {
  InvitationEntity toEntity() => InvitationEntity(
    id: id,
    email: email,
    workspaceId: workspaceId,
    boardId: boardId,
    role: role,
    token: token,
    invitedBy: invitedBy,
    expiresAt: expiresAt,
    acceptedAt: acceptedAt,
    declinedAt: declinedAt,
    createdAt: createdAt,
    isSynced: isSynced,
  );
}

extension InvitationEntityMapper on InvitationEntity {
  InvitationsTableCompanion toCompanion({String? syncAction}) =>
      InvitationsTableCompanion.insert(
        id: id,
        email: email,
        workspaceId: Value(workspaceId),
        boardId: Value(boardId),
        role: role,
        token: token,
        invitedBy: invitedBy,
        expiresAt: expiresAt,
        acceptedAt: Value(acceptedAt),
        declinedAt: Value(declinedAt),
        createdAt: createdAt,
        isSynced: Value(isSynced),
        syncAction: Value(syncAction),
      );
}
