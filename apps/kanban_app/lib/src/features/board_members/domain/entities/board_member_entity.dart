import '../../../permissions/domain/entities/permission.dart';

final class BoardMemberEntity {
  const BoardMemberEntity({
    required this.id,
    required this.boardId,
    required this.userId,
    required this.role,
    required this.joinedAt,
    this.isSynced = false,
  });

  final String id;
  final String boardId;
  final String userId;
  final BoardRole role;
  final DateTime joinedAt;
  final bool isSynced;

  BoardMemberEntity copyWith({
    String? id,
    String? boardId,
    String? userId,
    BoardRole? role,
    DateTime? joinedAt,
    bool? isSynced,
  }) {
    return BoardMemberEntity(
      id: id ?? this.id,
      boardId: boardId ?? this.boardId,
      userId: userId ?? this.userId,
      role: role ?? this.role,
      joinedAt: joinedAt ?? this.joinedAt,
      isSynced: isSynced ?? this.isSynced,
    );
  }
}
