import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/task_history_entry.dart';

extension TaskHistoryRowMapper on TaskHistoryTableData {
  TaskHistoryEntry toEntity() {
    return TaskHistoryEntry(
      id: id,
      taskId: taskId,
      boardId: boardId,
      action: action,
      summary: summary,
      detailsJson: detailsJson,
      actorUserId: actorUserId,
      changedAt: changedAt,
    );
  }
}

extension TaskHistoryEntityMapper on TaskHistoryEntry {
  TaskHistoryTableCompanion toCompanion() {
    return TaskHistoryTableCompanion.insert(
      id: id,
      taskId: taskId,
      boardId: boardId,
      action: action,
      summary: summary,
      detailsJson: Value(detailsJson),
      actorUserId: Value(actorUserId),
      changedAt: changedAt,
    );
  }
}
