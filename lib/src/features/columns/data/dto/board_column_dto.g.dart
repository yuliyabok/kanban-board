// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_column_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BoardColumnDto _$BoardColumnDtoFromJson(Map<String, dynamic> json) =>
    _BoardColumnDto(
      id: json['id'] as String,
      boardId: json['boardId'] as String,
      title: json['title'] as String,
      position: (json['position'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
    );

Map<String, dynamic> _$BoardColumnDtoToJson(_BoardColumnDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'boardId': instance.boardId,
      'title': instance.title,
      'position': instance.position,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
    };
