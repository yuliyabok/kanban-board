import '../../../../core/error/result.dart';
import '../repositories/column_repository.dart';

final class DeleteColumnUseCase {
  const DeleteColumnUseCase(this._repository);

  final ColumnRepository _repository;

  Future<Result<void>> call(String columnId) {
    return _repository.delete(columnId);
  }
}
