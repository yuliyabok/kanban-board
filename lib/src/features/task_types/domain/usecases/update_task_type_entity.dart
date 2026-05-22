import '../../../../core/error/result.dart';
import '../entities/task_type_entity.dart';
import '../repositories/task_type_repository.dart';

final class UpdateTaskTypeEntityUseCase {
  const UpdateTaskTypeEntityUseCase(this._repository);

  final TaskTypeRepository _repository;

  Future<Result<TaskTypeEntity>> call(TaskTypeEntity type) {
    return _repository.update(type);
  }
}
