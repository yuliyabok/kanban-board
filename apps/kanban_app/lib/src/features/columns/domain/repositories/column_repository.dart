import '../../../../core/error/result.dart';
import '../entities/board_column_entity.dart';

abstract interface class ColumnRepository {
  Stream<List<BoardColumnEntity>> watchByBoard(String boardId);

  Future<List<BoardColumnEntity>> getByBoard(String boardId);

  Future<Result<BoardColumnEntity>> create({
    required String boardId,
    required String title,
    required int position,
    String? id,
  });

  Future<Result<BoardColumnEntity>> updateTitle({
    required String columnId,
    required String title,
  });

  Future<Result<void>> delete(String columnId);

  Future<Result<void>> reorder(List<BoardColumnEntity> columns);
}
