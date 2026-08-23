import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../../permissions/domain/entities/permission.dart';
import '../../domain/entities/board_member_entity.dart';
import '../../domain/repositories/board_member_repository.dart';
import '../datasources/board_member_local_datasource.dart';
import '../mappers/board_member_mapper.dart';

final class DefaultBoardMemberRepository implements BoardMemberRepository {
  const DefaultBoardMemberRepository(this._localDataSource);

  final BoardMemberLocalDataSource _localDataSource;

  @override
  Stream<List<BoardMemberEntity>> watchByBoard(String boardId) {
    return _localDataSource
        .watchByBoard(boardId)
        .map(
          (rows) => rows.map((row) => row.toEntity()).toList(growable: false),
        );
  }

  @override
  Future<Result<List<BoardMemberEntity>>> getByBoard(String boardId) async {
    try {
      final rows = await _localDataSource.getByBoard(boardId);
      return Success(rows.map((row) => row.toEntity()).toList(growable: false));
    } on Exception catch (error) {
      return Error(StorageFailure(error.toString()));
    }
  }

  @override
  Future<Result<BoardMemberEntity>> add(BoardMemberEntity member) async {
    try {
      await _localDataSource.upsert(member.toCompanion(syncAction: 'create'));
      return Success(member);
    } on Exception catch (error) {
      return Error(StorageFailure(error.toString()));
    }
  }

  @override
  Future<Result<void>> remove({
    required String boardId,
    required String userId,
    required String actorUserId,
  }) async {
    try {
      final members = (await _localDataSource.getByBoard(
        boardId,
      )).map((row) => row.toEntity()).toList(growable: false);
      if (!_isBoardAdmin(actorUserId, members)) {
        return const Error(ValidationFailure('Недостаточно прав'));
      }
      final target = members
          .where((member) => member.userId == userId)
          .firstOrNull;
      if (target == null) return const Success(null);
      if (_isLastBoardAdmin(target, members)) {
        return const Error(
          ValidationFailure('Нельзя удалить последнего admin'),
        );
      }
      await _localDataSource.delete(boardId: boardId, userId: userId);
      return const Success(null);
    } on Exception catch (error) {
      return Error(StorageFailure(error.toString()));
    }
  }

  @override
  Future<Result<BoardMemberEntity>> updateRole({
    required String boardId,
    required String userId,
    required BoardMemberEntity member,
    required String actorUserId,
  }) async {
    try {
      final members = (await _localDataSource.getByBoard(
        boardId,
      )).map((row) => row.toEntity()).toList(growable: false);
      if (!_isBoardAdmin(actorUserId, members)) {
        return const Error(ValidationFailure('Недостаточно прав'));
      }
      final existing = members
          .where((item) => item.userId == userId)
          .firstOrNull;
      if (existing != null && _isLastBoardAdmin(existing, members)) {
        return const Error(
          ValidationFailure('Нельзя изменить последнего admin'),
        );
      }
      final updated = member.copyWith(joinedAt: existing?.joinedAt);
      await _localDataSource.upsert(updated.toCompanion(syncAction: 'update'));
      return Success(updated);
    } on Exception catch (error) {
      return Error(StorageFailure(error.toString()));
    }
  }

  bool _isBoardAdmin(String userId, List<BoardMemberEntity> members) {
    return members.any(
      (member) => member.userId == userId && member.role == BoardRole.admin,
    );
  }

  bool _isLastBoardAdmin(
    BoardMemberEntity target,
    List<BoardMemberEntity> members,
  ) {
    if (target.role != BoardRole.admin) return false;
    return members.where((member) => member.role == BoardRole.admin).length <=
        1;
  }
}
