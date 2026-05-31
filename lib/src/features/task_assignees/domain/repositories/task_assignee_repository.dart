import '../../../../core/error/result.dart';
import '../entities/task_assignee_entity.dart';

abstract interface class TaskAssigneeRepository {
  Stream<List<TaskAssigneeEntity>> watchByTask(String taskId);

  Future<Result<List<TaskAssigneeEntity>>> getByTask(String taskId);

  Future<Result<TaskAssigneeEntity>> assign({
    required String taskId,
    required String userId,
    required String assignedBy,
  });

  Future<Result<void>> unassign({
    required String taskId,
    required String userId,
    required String actorUserId,
  });

  Future<Result<List<TaskAssigneeEntity>>> getMyTasks({
    required String boardId,
    required String userId,
  });
}
