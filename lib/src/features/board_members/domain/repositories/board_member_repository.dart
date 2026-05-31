import '../../../../core/error/result.dart';
import '../entities/board_member_entity.dart';

abstract interface class BoardMemberRepository {
  Stream<List<BoardMemberEntity>> watchByBoard(String boardId);

  Future<Result<List<BoardMemberEntity>>> getByBoard(String boardId);

  Future<Result<BoardMemberEntity>> add(BoardMemberEntity member);

  Future<Result<BoardMemberEntity>> updateRole({
    required String boardId,
    required String userId,
    required BoardMemberEntity member,
    required String actorUserId,
  });

  Future<Result<void>> remove({
    required String boardId,
    required String userId,
    required String actorUserId,
  });
}
