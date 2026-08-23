import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/task_comment_entity.dart';
import '../dto/task_comment_dto.dart';

extension TaskCommentRowMapper on TaskCommentsTableData {
  TaskCommentEntity toEntity() => TaskCommentEntity(
    id: id,
    taskId: taskId,
    authorId: authorId,
    content: content,
    createdAt: createdAt,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
    isSynced: isSynced,
  );
}

extension TaskCommentEntityMapper on TaskCommentEntity {
  TaskCommentsTableCompanion toCompanion({String? syncAction}) =>
      TaskCommentsTableCompanion.insert(
        id: id,
        taskId: taskId,
        authorId: authorId,
        content: content,
        createdAt: createdAt,
        updatedAt: updatedAt,
        deletedAt: Value(deletedAt),
        isSynced: Value(isSynced),
        syncAction: Value(syncAction),
      );

  TaskCommentDto toDto() => TaskCommentDto(
    id: id,
    taskId: taskId,
    authorId: authorId,
    content: content,
    createdAt: createdAt,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
  );
}

extension TaskCommentDtoMapper on TaskCommentDto {
  TaskCommentEntity toEntity({bool isSynced = true}) => TaskCommentEntity(
    id: id,
    taskId: taskId,
    authorId: authorId,
    content: content,
    createdAt: createdAt,
    updatedAt: updatedAt,
    deletedAt: deletedAt,
    isSynced: isSynced,
  );
}
