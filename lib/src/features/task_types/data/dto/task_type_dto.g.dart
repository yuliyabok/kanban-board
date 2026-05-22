// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_type_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TaskTypeDto _$TaskTypeDtoFromJson(Map<String, dynamic> json) => _TaskTypeDto(
  id: json['id'] as String,
  boardId: json['boardId'] as String,
  name: json['name'] as String,
  color: json['color'] as String,
  icon: json['icon'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  description: json['description'] as String?,
  deletedAt: json['deletedAt'] == null
      ? null
      : DateTime.parse(json['deletedAt'] as String),
);

Map<String, dynamic> _$TaskTypeDtoToJson(_TaskTypeDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'boardId': instance.boardId,
      'name': instance.name,
      'color': instance.color,
      'icon': instance.icon,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'description': instance.description,
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };
