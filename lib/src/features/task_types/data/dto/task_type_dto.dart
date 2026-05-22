import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_type_dto.freezed.dart';
part 'task_type_dto.g.dart';

@freezed
abstract class TaskTypeDto with _$TaskTypeDto {
  const factory TaskTypeDto({
    required String id,
    required String boardId,
    required String name,
    required String color,
    required String icon,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? description,
    DateTime? deletedAt,
  }) = _TaskTypeDto;

  factory TaskTypeDto.fromJson(Map<String, dynamic> json) =>
      _$TaskTypeDtoFromJson(json);
}
