import '../../../../core/error/result.dart';
import '../entities/board_entity.dart';

abstract interface class BoardRepository {
  Stream<List<BoardEntity>> watchAll();

  Future<Result<BoardEntity>> create(BoardEntity board);

  Future<Result<BoardEntity>> update(BoardEntity board);

  Future<Result<void>> delete(String boardId);
}
