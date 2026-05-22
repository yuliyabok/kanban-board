import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_type_entity.freezed.dart';

@freezed
abstract class TaskTypeEntity with _$TaskTypeEntity {
  const factory TaskTypeEntity({
    required String id,
    required String boardId,
    required String name,
    required String color,
    required String icon,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? description,
    DateTime? deletedAt,
    @Default(false) bool isSynced,
  }) = _TaskTypeEntity;
}
