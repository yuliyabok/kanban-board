import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/task_assignee_entity.dart';
import '../dto/task_assignee_dto.dart';

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

  TaskAssigneeDto toDto() => TaskAssigneeDto(
    id: id,
    taskId: taskId,
    userId: userId,
    assignedBy: assignedBy,
    assignedAt: assignedAt,
  );
}

extension TaskAssigneeDtoMapper on TaskAssigneeDto {
  TaskAssigneeEntity toEntity({bool isSynced = true}) => TaskAssigneeEntity(
    id: id,
    taskId: taskId,
    userId: userId,
    assignedBy: assignedBy,
    assignedAt: assignedAt,
    isSynced: isSynced,
  );
}
