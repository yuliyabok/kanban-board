// Хранение задач, комментариев, исполнителей и истории изменений.
import 'package:kanban_contracts/kanban_contracts.dart';

abstract interface class TaskDataRepository {
  Future<List<TaskDto>> listTasks({
    required String boardId,
    required String actorUserId,
  });

  Future<TaskDto> createTask({
    required TaskDto task,
    required String actorUserId,
  });

  Future<TaskDto> updateTask({
    required String taskId,
    required String actorUserId,
    required Map<String, dynamic> patch,
  });

  Future<void> deleteTask({
    required String taskId,
    required String actorUserId,
  });

  Future<List<TaskCommentDto>> listComments({
    required String taskId,
    required String actorUserId,
  });

  Future<TaskCommentDto> createComment({
    required String taskId,
    required String actorUserId,
    required String content,
    String? id,
  });

  Future<TaskCommentDto> updateComment({
    required String commentId,
    required String actorUserId,
    required String content,
  });

  Future<void> deleteComment({
    required String commentId,
    required String actorUserId,
  });

  Future<List<TaskAssigneeDto>> listAssignees({
    required String taskId,
    required String actorUserId,
  });

  Future<TaskAssigneeDto> assign({
    required String taskId,
    required String userId,
    required String actorUserId,
    String? id,
  });

  Future<void> unassign({
    required String taskId,
    required String userId,
    required String actorUserId,
  });

  Future<List<TaskHistoryEntryDto>> listHistory({
    required String taskId,
    required String actorUserId,
  });
}
