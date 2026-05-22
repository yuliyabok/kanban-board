import '../entities/board_column_entity.dart';
import '../repositories/column_repository.dart';

final class WatchBoardColumns {
  const WatchBoardColumns(this._repository);

  final ColumnRepository _repository;

  Stream<List<BoardColumnEntity>> call(String boardId) {
    return _repository.watchByBoard(boardId);
  }
}
