import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/board_entity.dart';

extension BoardRowMapper on BoardsTableData {
  BoardEntity toEntity() => BoardEntity(
    id: id,
    ownerId: ownerId,
    title: title,
    description: description,
    createdAt: createdAt,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
    isSynced: isSynced,
  );
}

extension BoardEntityMapper on BoardEntity {
  BoardsTableCompanion toCompanion({String? syncAction}) =>
      BoardsTableCompanion.insert(
        id: id,
        ownerId: ownerId,
        title: title,
        description: Value(description),
        createdAt: createdAt,
        updatedAt: updatedAt,
        deletedAt: Value(deletedAt),
        isSynced: Value(isSynced),
        syncAction: Value(syncAction),
      );

  Map<String, Object?> toApiJson() => {
    'id': id,
    'ownerId': ownerId,
    'title': title,
    'description': description,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    'deletedAt': deletedAt?.toIso8601String(),
  };
}

BoardEntity boardFromApiJson(Map<String, dynamic> json) => BoardEntity(
  id: json['id'] as String,
  ownerId: json['ownerId'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  deletedAt: json['deletedAt'] == null
      ? null
      : DateTime.parse(json['deletedAt'] as String),
  isSynced: true,
);
