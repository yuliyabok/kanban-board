import '../../../../core/error/result.dart';
import '../entities/task_assignee_entity.dart';
import '../repositories/task_assignee_repository.dart';

final class AssignTaskUserUseCase {
  const AssignTaskUserUseCase(this._repository);

  final TaskAssigneeRepository _repository;

  Future<Result<TaskAssigneeEntity>> call({
    required String taskId,
    required String userId,
    required String assignedBy,
  }) => _repository.assign(
    taskId: taskId,
    userId: userId,
    assignedBy: assignedBy,
  );
}

final class UnassignTaskUserUseCase {
  const UnassignTaskUserUseCase(this._repository);

  final TaskAssigneeRepository _repository;

  Future<Result<void>> call({
    required String taskId,
    required String userId,
    required String actorUserId,
  }) => _repository.unassign(
    taskId: taskId,
    userId: userId,
    actorUserId: actorUserId,
  );
}

final class GetTaskAssigneesUseCase {
  const GetTaskAssigneesUseCase(this._repository);

  final TaskAssigneeRepository _repository;

  Future<Result<List<TaskAssigneeEntity>>> call(String taskId) =>
      _repository.getByTask(taskId);
}

final class GetMyTasksUseCase {
  const GetMyTasksUseCase(this._repository);

  final TaskAssigneeRepository _repository;

  Future<Result<List<TaskAssigneeEntity>>> call({
    required String boardId,
    required String userId,
  }) => _repository.getMyTasks(boardId: boardId, userId: userId);
}
