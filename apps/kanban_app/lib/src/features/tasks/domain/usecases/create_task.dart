import '../../../../core/error/result.dart';
import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

final class CreateTask {
  const CreateTask(this._repository);

  final TaskRepository _repository;

  Future<Result<TaskEntity>> call({
    required String boardId,
    required String title,
    String? columnId,
    String? parentTaskId,
    String? taskTypeId,
    String? description,
    String? actorUserId,
  }) {
    return _repository.create(
      boardId: boardId,
      title: title,
      columnId: columnId,
      parentTaskId: parentTaskId,
      taskTypeId: taskTypeId,
      description: description,
      actorUserId: actorUserId,
    );
  }
}
