import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/task_assignee_entity.dart';

extension TaskAssigneeRowMapper on TaskAssigneesTableData {
  TaskAssigneeEntity toEntity() => TaskAssigneeEntity(
    id: id,
    taskId: taskId,
    userId: userId,
    assignedBy: assignedBy,
    assignedAt: assignedAt,
    isSynced: isSynced,
  );
}

extension TaskAssigneeEntityMapper on TaskAssigneeEntity {
  TaskAssigneesTableCompanion toCompanion({String? syncAction}) =>
      TaskAssigneesTableCompanion.insert(
        id: id,
        taskId: taskId,
        userId: userId,
        assignedBy: assignedBy,
        assignedAt: assignedAt,
        isSynced: Value(isSynced),
        syncAction: Value(syncAction),
      );
}
