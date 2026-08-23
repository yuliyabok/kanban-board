import 'package:freezed_annotation/freezed_annotation.dart';

part 'board_column_dto.freezed.dart';
part 'board_column_dto.g.dart';

@freezed
abstract class BoardColumnDto with _$BoardColumnDto {
  const factory BoardColumnDto({
    required String id,
    required String boardId,
    required String title,
    required int position,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) = _BoardColumnDto;

  factory BoardColumnDto.fromJson(Map<String, dynamic> json) =>
      _$BoardColumnDtoFromJson(json);
}
