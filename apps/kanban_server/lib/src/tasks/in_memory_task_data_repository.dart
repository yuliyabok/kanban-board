// In-memory tasks repository для server tests.
import 'package:kanban_contracts/kanban_contracts.dart';
import 'package:kanban_server/src/http/api_exception.dart';
import 'package:kanban_server/src/tasks/task_data_repository.dart';
import 'package:uuid/uuid.dart';

final class InMemoryTaskDataRepository implements TaskDataRepository {
  InMemoryTaskDataRepository({Uuid uuid = const Uuid()}) : _uuid = uuid;

  final Uuid _uuid;
  final _tasks = <String, TaskDto>{};
  final _comments = <String, TaskCommentDto>{};
  final _assignees = <String, TaskAssigneeDto>{};
  final _history = <TaskHistoryEntryDto>[];

  @override
  Future<TaskDto> createTask({
    required TaskDto task,
    required String actorUserId,
  }) async {
    final now = DateTime.now().toUtc();
    final created = TaskDto(
      id: task.id,
      boardId: task.boardId,
      columnId: task.columnId,
      parentTaskId: task.parentTaskId,
      taskTypeId: task.taskTypeId,
      title: _required(task.title, 'Название задачи не пустое'),
      description: _optional(task.description),
      cardBackgroundColor: task.cardBackgroundColor,
      cardTextColor: task.cardTextColor,
      position: task.position,
      depth: task.depth,
      status: task.status,
      priority: task.priority,
      assigneeName: task.assigneeName,
      labels: task.labels,
      startDate: task.startDate,
      dueDate: task.dueDate,
      completedAt: task.completedAt,
      estimatedDurationMinutes: task.estimatedDurationMinutes,
      actualDurationMinutes: task.actualDurationMinutes,
      periodType: task.periodType,
      isCompleted: task.isCompleted,
      createdAt: now,
      updatedAt: now,
      deletedAt: task.deletedAt,
    );
    _tasks[created.id] = created;
    _record(created, 'create', 'Задача создана', actorUserId);
    return created;
  }

  @override
  Future<void> deleteTask({
    required String taskId,
    required String actorUserId,
  }) async {
    final task = _task(taskId);
    final deleted = _copyTask(task, deletedAt: DateTime.now().toUtc());
    _tasks[taskId] = deleted;
    _record(deleted, 'delete', 'Задача удалена', actorUserId);
  }

  @override
  Future<List<TaskDto>> listTasks({
    required String boardId,
    required String actorUserId,
  }) async {
    return _tasks.values
        .where((task) => task.boardId == boardId && task.deletedAt == null)
        .toList(growable: false);
  }

  @override
  Future<TaskDto> updateTask({
    required String taskId,
    required String actorUserId,
    required Map<String, dynamic> patch,
  }) async {
    final task = _task(taskId);
    final updated = _copyTask(
      task,
      title: patch['title'] as String? ?? task.title,
      description: patch.containsKey('description')
          ? patch['description'] as String?
          : task.description,
      columnId: patch.containsKey('columnId')
          ? patch['columnId'] as String?
          : task.columnId,
      priority: patch['priority'] as String? ?? task.priority,
      status: patch['status'] as String? ?? task.status,
      isCompleted: patch['isCompleted'] as bool? ?? task.isCompleted,
    );
    _tasks[taskId] = updated;
    _record(updated, 'update', 'Задача обновлена', actorUserId);
    return updated;
  }

  @override
  Future<TaskCommentDto> createComment({
    required String taskId,
    required String actorUserId,
    required String content,
    String? id,
  }) async {
    final task = _task(taskId);
    final now = DateTime.now().toUtc();
    final comment = TaskCommentDto(
      id: id ?? _uuid.v7(),
      taskId: taskId,
      authorId: actorUserId,
      content: _required(content, 'Комментарий не пустой'),
      createdAt: now,
      updatedAt: now,
    );
    _comments[comment.id] = comment;
    _record(task, 'comment_create', 'добавлен комментарий', actorUserId);
    return comment;
  }

  @override
  Future<void> deleteComment({
    required String commentId,
    required String actorUserId,
  }) async {
    final comment = _comment(commentId);
    final task = _task(comment.taskId);
    _comments[commentId] = TaskCommentDto(
      id: comment.id,
      taskId: comment.taskId,
      authorId: comment.authorId,
      content: comment.content,
      createdAt: comment.createdAt,
      updatedAt: DateTime.now().toUtc(),
      deletedAt: DateTime.now().toUtc(),
    );
    _record(task, 'comment_delete', 'комментарий удален', actorUserId);
  }

  @override
  Future<List<TaskCommentDto>> listComments({
    required String taskId,
    required String actorUserId,
  }) async {
    _task(taskId);
    return _comments.values
        .where(
          (comment) => comment.taskId == taskId && comment.deletedAt == null,
        )
        .toList(growable: false);
  }

  @override
  Future<TaskCommentDto> updateComment({
    required String commentId,
    required String actorUserId,
    required String content,
  }) async {
    final comment = _comment(commentId);
    final task = _task(comment.taskId);
    final updated = TaskCommentDto(
      id: comment.id,
      taskId: comment.taskId,
      authorId: comment.authorId,
      content: _required(content, 'Комментарий не пустой'),
      createdAt: comment.createdAt,
      updatedAt: DateTime.now().toUtc(),
      deletedAt: comment.deletedAt,
    );
    _comments[commentId] = updated;
    _record(task, 'comment_update', 'комментарий изменен', actorUserId);
    return updated;
  }

  @override
  Future<TaskAssigneeDto> assign({
    required String taskId,
    required String userId,
    required String actorUserId,
    String? id,
  }) async {
    final task = _task(taskId);
    final existing = _assignees.values
        .where((item) => item.taskId == taskId && item.userId == userId)
        .firstOrNull;
    if (existing != null) return existing;
    final assignee = TaskAssigneeDto(
      id: id ?? _uuid.v7(),
      taskId: taskId,
      userId: userId,
      assignedBy: actorUserId,
      assignedAt: DateTime.now().toUtc(),
    );
    _assignees[assignee.id] = assignee;
    _record(task, 'assign', 'назначен исполнитель', actorUserId);
    return assignee;
  }

  @override
  Future<List<TaskAssigneeDto>> listAssignees({
    required String taskId,
    required String actorUserId,
  }) async {
    _task(taskId);
    return _assignees.values
        .where((assignee) => assignee.taskId == taskId)
        .toList(growable: false);
  }

  @override
  Future<void> unassign({
    required String taskId,
    required String userId,
    required String actorUserId,
  }) async {
    final task = _task(taskId);
    _assignees.removeWhere(
      (_, assignee) => assignee.taskId == taskId && assignee.userId == userId,
    );
    _record(task, 'unassign', 'исполнитель снят', actorUserId);
  }

  @override
  Future<List<TaskHistoryEntryDto>> listHistory({
    required String taskId,
    required String actorUserId,
  }) async {
    _task(taskId);
    return _history
        .where((entry) => entry.taskId == taskId)
        .toList(growable: false)
        .reversed
        .toList(growable: false);
  }

  TaskDto _task(String taskId) {
    final task = _tasks[taskId];
    if (task == null || task.deletedAt != null) {
      throw const ApiException(
        statusCode: 404,
        code: 'task_not_found',
        message: 'Задача не найдена',
      );
    }
    return task;
  }

  TaskCommentDto _comment(String commentId) {
    final comment = _comments[commentId];
    if (comment == null || comment.deletedAt != null) {
      throw const ApiException(
        statusCode: 404,
        code: 'comment_not_found',
        message: 'Комментарий не найден',
      );
    }
    return comment;
  }

  TaskDto _copyTask(
    TaskDto task, {
    String? title,
    String? description,
    String? columnId,
    String? priority,
    String? status,
    bool? isCompleted,
    DateTime? deletedAt,
  }) {
    return TaskDto(
      id: task.id,
      boardId: task.boardId,
      columnId: columnId ?? task.columnId,
      parentTaskId: task.parentTaskId,
      taskTypeId: task.taskTypeId,
      title: _required(title ?? task.title, 'Название задачи не пустое'),
      description: description,
      cardBackgroundColor: task.cardBackgroundColor,
      cardTextColor: task.cardTextColor,
      position: task.position,
      depth: task.depth,
      status: status ?? task.status,
      priority: priority ?? task.priority,
      assigneeName: task.assigneeName,
      labels: task.labels,
      startDate: task.startDate,
      dueDate: task.dueDate,
      completedAt: task.completedAt,
      estimatedDurationMinutes: task.estimatedDurationMinutes,
      actualDurationMinutes: task.actualDurationMinutes,
      periodType: task.periodType,
      isCompleted: isCompleted ?? task.isCompleted,
      createdAt: task.createdAt,
      updatedAt: DateTime.now().toUtc(),
      deletedAt: deletedAt ?? task.deletedAt,
    );
  }

  void _record(
    TaskDto task,
    String action,
    String summary,
    String actorUserId,
  ) {
    _history.add(
      TaskHistoryEntryDto(
        id: _uuid.v7(),
        taskId: task.id,
        boardId: task.boardId,
        action: action,
        summary: summary,
        details: {'source': 'server'},
        actorUserId: actorUserId,
        changedAt: DateTime.now().toUtc(),
      ),
    );
  }

  String _required(String value, String message) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      throw ApiException(
        statusCode: 400,
        code: 'invalid_input',
        message: message,
      );
    }
    return trimmed;
  }

  String? _optional(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }
}
