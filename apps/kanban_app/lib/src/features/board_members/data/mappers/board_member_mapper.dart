import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../permissions/domain/entities/permission.dart';
import '../../domain/entities/board_member_entity.dart';
import '../dto/board_member_dto.dart';

extension BoardMemberRowMapper on BoardMembersTableData {
  BoardMemberEntity toEntity() => BoardMemberEntity(
    id: id,
    boardId: boardId,
    userId: userId,
    role: BoardRole.parse(role),
    joinedAt: joinedAt,
    isSynced: isSynced,
  );
}

extension BoardMemberEntityMapper on BoardMemberEntity {
  BoardMembersTableCompanion toCompanion({String? syncAction}) =>
      BoardMembersTableCompanion.insert(
        id: id,
        boardId: boardId,
        userId: userId,
        role: role.name,
        joinedAt: joinedAt,
        isSynced: Value(isSynced),
        syncAction: Value(syncAction),
      );
}

extension BoardMemberDtoMapper on BoardMemberDto {
  BoardMemberEntity toEntity() => BoardMemberEntity(
    id: id,
    boardId: boardId,
    userId: userId,
    role: role,
    joinedAt: joinedAt,
    isSynced: true,
  );
}
