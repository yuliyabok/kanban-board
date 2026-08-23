import '../../../../core/error/result.dart';
import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

final class UpdateTask {
  const UpdateTask(this._repository);

  final TaskRepository _repository;

  Future<Result<TaskEntity>> call(TaskEntity task, {String? actorUserId}) {
    return _repository.update(task, actorUserId: actorUserId);
  }
}
