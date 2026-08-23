import '../../../permissions/domain/entities/permission.dart';

final class BoardMemberDto {
  const BoardMemberDto({
    required this.id,
    required this.boardId,
    required this.userId,
    required this.role,
    required this.joinedAt,
  });

  factory BoardMemberDto.fromJson(Map<String, dynamic> json) => BoardMemberDto(
    id: json['id'] as String,
    boardId: json['boardId'] as String,
    userId: json['userId'] as String,
    role: BoardRole.parse(json['role'] as String),
    joinedAt: DateTime.parse(json['joinedAt'] as String),
  );

  final String id;
  final String boardId;
  final String userId;
  final BoardRole role;
  final DateTime joinedAt;

  Map<String, Object?> toJson() => {
    'id': id,
    'boardId': boardId,
    'userId': userId,
    'role': role.name,
    'joinedAt': joinedAt.toIso8601String(),
  };
}
