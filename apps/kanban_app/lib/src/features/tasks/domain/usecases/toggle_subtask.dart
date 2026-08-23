import '../../../../core/error/result.dart';
import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

final class ToggleSubtaskUseCase {
  const ToggleSubtaskUseCase(this._repository);

  final TaskRepository _repository;

  Future<Result<TaskEntity>> call(TaskEntity subtask, {String? actorUserId}) {
    return _repository.update(
      subtask.copyWith(
        isCompleted: !subtask.isCompleted,
        completedAt: subtask.isCompleted ? null : DateTime.now().toUtc(),
      ),
      actorUserId: actorUserId,
    );
  }
}
