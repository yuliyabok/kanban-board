import '../../../../core/error/result.dart';
import '../entities/board_entity.dart';
import '../repositories/board_repository.dart';

final class CreateBoard {
  const CreateBoard(this._repository);

  final BoardRepository _repository;

  Future<Result<BoardEntity>> call(BoardEntity board) =>
      _repository.create(board);
}
