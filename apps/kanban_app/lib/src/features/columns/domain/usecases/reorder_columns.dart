import '../../../../core/error/result.dart';
import '../entities/board_column_entity.dart';
import '../repositories/column_repository.dart';

final class ReorderColumnsUseCase {
  const ReorderColumnsUseCase(this._repository);

  final ColumnRepository _repository;

  Future<Result<void>> call(List<BoardColumnEntity> columns) {
    return _repository.reorder(columns);
  }
}
