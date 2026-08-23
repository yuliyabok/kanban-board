import '../../../../core/error/result.dart';
import '../entities/board_column_entity.dart';
import '../repositories/column_repository.dart';

final class CreateColumnUseCase {
  const CreateColumnUseCase(this._repository);

  final ColumnRepository _repository;

  Future<Result<BoardColumnEntity>> call({
    required String boardId,
    required String title,
    required int position,
    String? id,
  }) {
    return _repository.create(
      boardId: boardId,
      title: title,
      position: position,
      id: id,
    );
  }
}
