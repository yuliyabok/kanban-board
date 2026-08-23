import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_dto.freezed.dart';
part 'task_dto.g.dart';

@freezed
abstract class TaskDto with _$TaskDto {
  const factory TaskDto({
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
    @Default('todo') String status,
    @Default('medium') String priority,
    String? assigneeName,
    @Default([]) List<String> labels,
    DateTime? startDate,
    DateTime? dueDate,
    DateTime? completedAt,
    int? estimatedDurationMinutes,
    int? actualDurationMinutes,
    @Default('custom') String periodType,
    @Default(false) bool isCompleted,
    DateTime? deletedAt,
  }) = _TaskDto;

  factory TaskDto.fromJson(Map<String, dynamic> json) =>
      _$TaskDtoFromJson(json);
}
