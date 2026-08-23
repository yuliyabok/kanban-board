import 'package:freezed_annotation/freezed_annotation.dart';

import '../value_objects/task_enums.dart';

part 'task_entity.freezed.dart';

@freezed
abstract class TaskEntity with _$TaskEntity {
  const factory TaskEntity({
    required String id,
    required String boardId,
    required String title,
    required int position,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? columnId,
    String? parentTaskId,
    String? taskTypeId,
    String? description,
    String? cardBackgroundColor,
    String? cardTextColor,
    @Default(0) int depth,
    @Default(TaskStatus.todo) TaskStatus status,
    @Default(TaskPriority.medium) TaskPriority priority,
    String? assigneeName,
    @Default([]) List<String> labels,
    DateTime? startDate,
    DateTime? dueDate,
    DateTime? completedAt,
    int? estimatedDurationMinutes,
    int? actualDurationMinutes,
    @Default(TaskPeriodType.custom) TaskPeriodType periodType,
    @Default(false) bool isCompleted,
    DateTime? deletedAt,
    @Default(false) bool isSynced,
  }) = _TaskEntity;
}
