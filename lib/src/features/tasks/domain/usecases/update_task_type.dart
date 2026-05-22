import '../../../../core/error/result.dart';
import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

final class UpdateTaskTypeUseCase {
  const UpdateTaskTypeUseCase(this._repository);

  final TaskRepository _repository;

  Future<Result<TaskEntity>> call({
    required TaskEntity task,
    required String? taskTypeId,
  }) {
    return _repository.update(task.copyWith(taskTypeId: taskTypeId));
  }
}
