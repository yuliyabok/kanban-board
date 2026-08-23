import '../entities/task_type_entity.dart';
import '../repositories/task_type_repository.dart';

final class WatchTaskTypesUseCase {
  const WatchTaskTypesUseCase(this._repository);

  final TaskTypeRepository _repository;

  Stream<List<TaskTypeEntity>> call(String boardId) {
    return _repository.watchByBoard(boardId);
  }
}
