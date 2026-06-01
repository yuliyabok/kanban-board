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
  });

  Future<Result<TaskEntity>> update(TaskEntity task);

  Future<Result<void>> delete(String taskId, {bool cascade = true});
}
