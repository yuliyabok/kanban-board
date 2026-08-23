import '../../../../core/error/result.dart';
import '../../../permissions/domain/entities/permission.dart';
import '../../../permissions/domain/repositories/permission_repository.dart';
import '../entities/board_member_entity.dart';
import '../repositories/board_member_repository.dart';

final class GetBoardMembersUseCase {
  const GetBoardMembersUseCase(this._repository);

  final BoardMemberRepository _repository;

  Future<Result<List<BoardMemberEntity>>> call(String boardId) =>
      _repository.getByBoard(boardId);
}

final class InviteBoardMemberUseCase {
  const InviteBoardMemberUseCase();
}

final class UpdateBoardMemberRoleUseCase {
  const UpdateBoardMemberRoleUseCase(this._repository);

  final BoardMemberRepository _repository;

  Future<Result<BoardMemberEntity>> call({
    required String boardId,
    required String userId,
    required BoardRole role,
    required String actorUserId,
  }) {
    return _repository.updateRole(
      boardId: boardId,
      userId: userId,
      actorUserId: actorUserId,
      member: BoardMemberEntity(
        id: '$boardId:$userId',
        boardId: boardId,
        userId: userId,
        role: role,
        joinedAt: DateTime.now().toUtc(),
      ),
    );
  }
}

final class RemoveBoardMemberUseCase {
  const RemoveBoardMemberUseCase(this._repository);

  final BoardMemberRepository _repository;

  Future<Result<void>> call({
    required String boardId,
    required String userId,
    required String actorUserId,
  }) => _repository.remove(
    boardId: boardId,
    userId: userId,
    actorUserId: actorUserId,
  );
}

final class CheckBoardPermissionUseCase {
  const CheckBoardPermissionUseCase(this._repository);

  final PermissionRepository _repository;

  Future<bool> call({
    required String userId,
    required String boardId,
    required Permission permission,
  }) => _repository.hasBoardPermission(
    userId: userId,
    boardId: boardId,
    permission: permission,
  );
}
