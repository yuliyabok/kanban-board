import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/task_type_entity.dart';
import '../dto/task_type_dto.dart';

extension TaskTypeRowMapper on TaskTypesTableData {
  TaskTypeEntity toEntity() {
    return TaskTypeEntity(
      id: id,
      boardId: boardId,
      name: name,
      color: color,
      icon: icon,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
      isSynced: isSynced,
    );
  }
}

extension TaskTypeEntityMapper on TaskTypeEntity {
  TaskTypesTableCompanion toCompanion({String? syncAction}) {
    return TaskTypesTableCompanion.insert(
      id: id,
      boardId: Value(boardId),
      name: name,
      color: color,
      icon: icon,
      description: Value(description),
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: Value(deletedAt),
      isSynced: Value(isSynced),
      syncAction: Value(syncAction),
    );
  }

  TaskTypeDto toDto() {
    return TaskTypeDto(
      id: id,
      boardId: boardId,
      name: name,
      color: color,
      icon: icon,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
    );
  }
}

extension TaskTypeDtoMapper on TaskTypeDto {
  TaskTypeEntity toEntity({bool isSynced = true}) {
    return TaskTypeEntity(
      id: id,
      boardId: boardId,
      name: name,
      color: color,
      icon: icon,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
      isSynced: isSynced,
    );
  }
}
