import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/board_column_entity.dart';
import '../dto/board_column_dto.dart';

extension BoardColumnRowMapper on BoardColumnsTableData {
  BoardColumnEntity toEntity() {
    return BoardColumnEntity(
      id: id,
      boardId: boardId,
      title: title,
      position: position,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
      isSynced: isSynced,
    );
  }
}

extension BoardColumnEntityMapper on BoardColumnEntity {
  BoardColumnsTableCompanion toCompanion({String? syncAction}) {
    return BoardColumnsTableCompanion.insert(
      id: id,
      boardId: boardId,
      title: title,
      position: position,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: Value(deletedAt),
      isSynced: Value(isSynced),
      syncAction: Value(syncAction),
    );
  }

  BoardColumnDto toDto() {
    return BoardColumnDto(
      id: id,
      boardId: boardId,
      title: title,
      position: position,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
    );
  }
}

extension BoardColumnDtoMapper on BoardColumnDto {
  BoardColumnEntity toEntity({bool isSynced = true}) {
    return BoardColumnEntity(
      id: id,
      boardId: boardId,
      title: title,
      position: position,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
      isSynced: isSynced,
    );
  }
}
