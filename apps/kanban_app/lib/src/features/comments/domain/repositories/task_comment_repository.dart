import '../../../../core/error/result.dart';
import '../entities/task_comment_entity.dart';

abstract interface class TaskCommentRepository {
  Stream<List<TaskCommentEntity>> watchByTask(String taskId);

  Future<Result<List<TaskCommentEntity>>> getByTask(String taskId);

  Future<Result<TaskCommentEntity>> create({
    required String taskId,
    required String authorId,
    required String content,
  });

  Future<Result<TaskCommentEntity>> update({
    required String id,
    required String actorUserId,
    required String content,
  });

  Future<Result<void>> delete({
    required String id,
    required String actorUserId,
  });
}
