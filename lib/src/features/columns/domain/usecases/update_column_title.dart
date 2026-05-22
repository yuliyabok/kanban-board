import '../../../../core/error/result.dart';
import '../entities/board_column_entity.dart';
import '../repositories/column_repository.dart';

final class UpdateColumnTitleUseCase {
  const UpdateColumnTitleUseCase(this._repository);

  final ColumnRepository _repository;

  Future<Result<BoardColumnEntity>> call({
    required String columnId,
    required String title,
  }) {
    return _repository.updateTitle(columnId: columnId, title: title);
  }
}
