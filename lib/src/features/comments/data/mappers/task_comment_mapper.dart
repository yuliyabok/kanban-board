import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/task_comment_entity.dart';

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
}
