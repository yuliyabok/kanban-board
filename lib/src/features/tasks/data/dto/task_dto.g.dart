// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TaskDto _$TaskDtoFromJson(Map<String, dynamic> json) => _TaskDto(
  id: json['id'] as String,
  boardId: json['boardId'] as String,
  title: json['title'] as String,
  position: (json['position'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  columnId: json['columnId'] as String?,
  parentTaskId: json['parentTaskId'] as String?,
  taskTypeId: json['taskTypeId'] as String?,
  description: json['description'] as String?,
  cardBackgroundColor: json['cardBackgroundColor'] as String?,
  cardTextColor: json['cardTextColor'] as String?,
  depth: (json['depth'] as num?)?.toInt() ?? 0,
  status: json['status'] as String? ?? 'todo',
  priority: json['priority'] as String? ?? 'medium',
  assigneeName: json['assigneeName'] as String?,
  labels:
      (json['labels'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  startDate: json['startDate'] == null
      ? null
      : DateTime.parse(json['startDate'] as String),
  dueDate: json['dueDate'] == null
      ? null
      : DateTime.parse(json['dueDate'] as String),
  completedAt: json['completedAt'] == null
      ? null
      : DateTime.parse(json['completedAt'] as String),
  estimatedDurationMinutes: (json['estimatedDurationMinutes'] as num?)?.toInt(),
  actualDurationMinutes: (json['actualDurationMinutes'] as num?)?.toInt(),
  periodType: json['periodType'] as String? ?? 'custom',
  isCompleted: json['isCompleted'] as bool? ?? false,
  deletedAt: json['deletedAt'] == null
      ? null
      : DateTime.parse(json['deletedAt'] as String),
);

Map<String, dynamic> _$TaskDtoToJson(_TaskDto instance) => <String, dynamic>{
  'id': instance.id,
  'boardId': instance.boardId,
  'title': instance.title,
  'position': instance.position,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'columnId': instance.columnId,
  'parentTaskId': instance.parentTaskId,
  'taskTypeId': instance.taskTypeId,
  'description': instance.description,
  'cardBackgroundColor': instance.cardBackgroundColor,
  'cardTextColor': instance.cardTextColor,
  'depth': instance.depth,
  'status': instance.status,
  'priority': instance.priority,
  'assigneeName': instance.assigneeName,
  'labels': instance.labels,
  'startDate': instance.startDate?.toIso8601String(),
  'dueDate': instance.dueDate?.toIso8601String(),
  'completedAt': instance.completedAt?.toIso8601String(),
  'estimatedDurationMinutes': instance.estimatedDurationMinutes,
  'actualDurationMinutes': instance.actualDurationMinutes,
  'periodType': instance.periodType,
  'isCompleted': instance.isCompleted,
  'deletedAt': instance.deletedAt?.toIso8601String(),
};
