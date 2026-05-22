import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/value_objects/task_enums.dart';
import '../dto/task_dto.dart';

extension TaskRowMapper on TasksTableData {
  TaskEntity toEntity() {
    return TaskEntity(
      id: id,
      boardId: boardId,
      columnId: columnId,
      parentTaskId: parentTaskId,
      taskTypeId: taskTypeId,
      title: title,
      description: description,
      cardBackgroundColor: cardBackgroundColor,
      cardTextColor: cardTextColor,
      position: position,
      depth: depth,
      status: enumByNameOrDefault(TaskStatus.values, status, TaskStatus.todo),
      priority: enumByNameOrDefault(
        TaskPriority.values,
        priority,
        TaskPriority.medium,
      ),
      assigneeName: assigneeName,
      labels: _decodeLabels(labelsJson),
      startDate: startDate,
      dueDate: dueDate,
      completedAt: completedAt,
      estimatedDurationMinutes: estimatedDurationMinutes,
      actualDurationMinutes: actualDurationMinutes,
      periodType: enumByNameOrDefault(
        TaskPeriodType.values,
        periodType,
        TaskPeriodType.custom,
      ),
      isCompleted: isCompleted,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
      isSynced: isSynced,
    );
  }
}

extension TaskEntityMapper on TaskEntity {
  TasksTableCompanion toCompanion({String? syncAction}) {
    return TasksTableCompanion.insert(
      id: id,
      boardId: boardId,
      columnId: Value(columnId),
      parentTaskId: Value(parentTaskId),
      taskTypeId: Value(taskTypeId),
      title: title,
      description: Value(description),
      cardBackgroundColor: Value(cardBackgroundColor),
      cardTextColor: Value(cardTextColor),
      position: position,
      depth: Value(depth),
      status: Value(status.storageName),
      priority: Value(priority.storageName),
      assigneeName: Value(assigneeName),
      labelsJson: Value(jsonEncode(labels)),
      startDate: Value(startDate),
      dueDate: Value(dueDate),
      completedAt: Value(completedAt),
      estimatedDurationMinutes: Value(estimatedDurationMinutes),
      actualDurationMinutes: Value(actualDurationMinutes),
      periodType: Value(periodType.storageName),
      isCompleted: Value(isCompleted),
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: Value(deletedAt),
      isSynced: Value(isSynced),
      syncAction: Value(syncAction),
    );
  }

  TaskDto toDto() {
    return TaskDto(
      id: id,
      boardId: boardId,
      columnId: columnId,
      parentTaskId: parentTaskId,
      taskTypeId: taskTypeId,
      title: title,
      description: description,
      cardBackgroundColor: cardBackgroundColor,
      cardTextColor: cardTextColor,
      position: position,
      depth: depth,
      status: status.storageName,
      priority: priority.storageName,
      assigneeName: assigneeName,
      labels: labels,
      startDate: startDate,
      dueDate: dueDate,
      completedAt: completedAt,
      estimatedDurationMinutes: estimatedDurationMinutes,
      actualDurationMinutes: actualDurationMinutes,
      periodType: periodType.storageName,
      isCompleted: isCompleted,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
    );
  }
}

extension TaskDtoMapper on TaskDto {
  TaskEntity toEntity({bool isSynced = true}) {
    return TaskEntity(
      id: id,
      boardId: boardId,
      columnId: columnId,
      parentTaskId: parentTaskId,
      taskTypeId: taskTypeId,
      title: title,
      description: description,
      cardBackgroundColor: cardBackgroundColor,
      cardTextColor: cardTextColor,
      position: position,
      depth: depth,
      status: enumByNameOrDefault(TaskStatus.values, status, TaskStatus.todo),
      priority: enumByNameOrDefault(
        TaskPriority.values,
        priority,
        TaskPriority.medium,
      ),
      assigneeName: assigneeName,
      labels: labels,
      startDate: startDate,
      dueDate: dueDate,
      completedAt: completedAt,
      estimatedDurationMinutes: estimatedDurationMinutes,
      actualDurationMinutes: actualDurationMinutes,
      periodType: enumByNameOrDefault(
        TaskPeriodType.values,
        periodType,
        TaskPeriodType.custom,
      ),
      isCompleted: isCompleted,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
      isSynced: isSynced,
    );
  }
}

List<String> _decodeLabels(String raw) {
  try {
    final decoded = jsonDecode(raw);
    if (decoded is List) {
      return decoded.whereType<String>().toList(growable: false);
    }
  } on FormatException {
    return const [];
  }
  return const [];
}
