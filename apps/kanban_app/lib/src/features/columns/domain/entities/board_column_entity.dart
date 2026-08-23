import 'package:freezed_annotation/freezed_annotation.dart';

part 'board_column_entity.freezed.dart';

@freezed
abstract class BoardColumnEntity with _$BoardColumnEntity {
  const factory BoardColumnEntity({
    required String id,
    required String boardId,
    required String title,
    required int position,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
    @Default(false) bool isSynced,
  }) = _BoardColumnEntity;
}
