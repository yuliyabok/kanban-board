import 'package:freezed_annotation/freezed_annotation.dart';

part 'board_entity.freezed.dart';

@freezed
abstract class BoardEntity with _$BoardEntity {
  const factory BoardEntity({
    required String id,
    required String ownerId,
    required String title,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? workspaceId,
    String? description,
    DateTime? deletedAt,
    @Default(false) bool isSynced,
  }) = _BoardEntity;
}
