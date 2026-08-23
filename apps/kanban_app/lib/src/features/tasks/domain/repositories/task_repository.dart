import '../../../../core/error/result.dart';
import '../entities/task_entity.dart';

abstract interface class TaskRepository {
  Stream<List<TaskEntity>> watchByBoard(String boardId);

  Future<List<TaskEntity>> getByBoard(String boardId);

  Future<Result<TaskEntity>> create({
    required String boardId,
    required String title,
    String? columnId,
    String? parentTaskId,
    String? taskTypeId,
    String? description,
    String? actorUserId,
  });

  Future<Result<TaskEntity>> update(TaskEntity task, {String? actorUserId});

  Future<Result<void>> delete(
    String taskId, {
    bool cascade = true,
    String? actorUserId,
  });
}
