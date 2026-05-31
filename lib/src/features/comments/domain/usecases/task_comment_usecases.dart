import '../../../../core/error/result.dart';
import '../entities/task_comment_entity.dart';
import '../repositories/task_comment_repository.dart';

final class GetTaskCommentsUseCase {
  const GetTaskCommentsUseCase(this._repository);

  final TaskCommentRepository _repository;

  Future<Result<List<TaskCommentEntity>>> call(String taskId) =>
      _repository.getByTask(taskId);
}

final class CreateTaskCommentUseCase {
  const CreateTaskCommentUseCase(this._repository);

  final TaskCommentRepository _repository;

  Future<Result<TaskCommentEntity>> call({
    required String taskId,
    required String authorId,
    required String content,
  }) =>
      _repository.create(taskId: taskId, authorId: authorId, content: content);
}

final class UpdateTaskCommentUseCase {
  const UpdateTaskCommentUseCase(this._repository);

  final TaskCommentRepository _repository;

  Future<Result<TaskCommentEntity>> call({
    required String id,
    required String actorUserId,
    required String content,
  }) => _repository.update(id: id, actorUserId: actorUserId, content: content);
}

final class DeleteTaskCommentUseCase {
  const DeleteTaskCommentUseCase(this._repository);

  final TaskCommentRepository _repository;

  Future<Result<void>> call({
    required String id,
    required String actorUserId,
  }) => _repository.delete(id: id, actorUserId: actorUserId);
}
