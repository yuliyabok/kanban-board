// PostgreSQL-реализация задач, комментариев, исполнителей и истории.
import 'dart:convert';

import 'package:kanban_contracts/kanban_contracts.dart';
import 'package:kanban_server/src/database/postgres_database.dart';
import 'package:kanban_server/src/http/api_exception.dart';
import 'package:kanban_server/src/tasks/task_data_repository.dart';
import 'package:uuid/uuid.dart';

final class PostgresTaskDataRepository implements TaskDataRepository {
  const PostgresTaskDataRepository(
    this._database, {
    Uuid uuid = const Uuid(),
  }) : _uuid = uuid;

  final PostgresDatabase _database;
  final Uuid _uuid;

  @override
  Future<TaskDto> createTask({
    required TaskDto task,
    required String actorUserId,
  }) async {
    await _ensureBoardAccess(boardId: task.boardId, userId: actorUserId);
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
    await _database.execute(
      _insertTaskSql,
      parameters: _taskParams(created),
      ignoreRows: true,
    );
    await _record(created, 'create', 'Задача создана', actorUserId);
    return created;
  }

  @override
  Future<void> deleteTask({
    required String taskId,
    required String actorUserId,
  }) async {
    final task = await _task(taskId);
    await _ensureBoardAccess(boardId: task.boardId, userId: actorUserId);
    final now = DateTime.now().toUtc();
    await _database.execute(
      'UPDATE tasks SET deleted_at = @now, updated_at = @now WHERE id = @id:uuid',
      parameters: {'id': taskId, 'now': now},
      ignoreRows: true,
    );
    await _record(task, 'delete', 'Задача удалена', actorUserId);
  }

  @override
  Future<List<TaskDto>> listTasks({
    required String boardId,
    required String actorUserId,
  }) async {
    await _ensureBoardAccess(boardId: boardId, userId: actorUserId);
    final result = await _database.execute(
      'SELECT * FROM tasks WHERE board_id = @boardId:uuid AND deleted_at IS NULL ORDER BY position ASC',
      parameters: {'boardId': boardId},
    );
    return result
        .map((row) => _taskFromRow(row.toColumnMap()))
        .toList(growable: false);
  }

  @override
  Future<TaskDto> updateTask({
    required String taskId,
    required String actorUserId,
    required Map<String, dynamic> patch,
  }) async {
    final current = await _task(taskId);
    await _ensureBoardAccess(boardId: current.boardId, userId: actorUserId);
    final updated = TaskDto.fromJson({
      ...current.toJson(),
      ...patch,
      'updatedAt': DateTime.now().toUtc().toIso8601String(),
    });
    await _database.execute(
      _updateTaskSql,
      parameters: _taskParams(updated),
      ignoreRows: true,
    );
    await _record(updated, 'update', 'Задача обновлена', actorUserId);
    return updated;
  }

  @override
  Future<TaskCommentDto> createComment({
    required String taskId,
    required String actorUserId,
    required String content,
    String? id,
  }) async {
    final task = await _task(taskId);
    await _ensureBoardAccess(boardId: task.boardId, userId: actorUserId);
    final now = DateTime.now().toUtc();
    final comment = TaskCommentDto(
      id: id ?? _uuid.v7(),
      taskId: taskId,
      authorId: actorUserId,
      content: _required(content, 'Комментарий не пустой'),
      createdAt: now,
      updatedAt: now,
    );
    await _database.execute(
      '''
      INSERT INTO task_comments (id, task_id, author_id, content, created_at, updated_at)
      VALUES (@id:uuid, @taskId:uuid, @authorId:uuid, @content, @createdAt, @updatedAt)
      ''',
      parameters: _commentParams(comment),
      ignoreRows: true,
    );
    await _record(task, 'comment_create', 'добавлен комментарий', actorUserId);
    return comment;
  }

  @override
  Future<void> deleteComment({
    required String commentId,
    required String actorUserId,
  }) async {
    final comment = await _comment(commentId);
    final task = await _task(comment.taskId);
    await _ensureBoardAccess(boardId: task.boardId, userId: actorUserId);
    final now = DateTime.now().toUtc();
    await _database.execute(
      'UPDATE task_comments SET deleted_at = @now, updated_at = @now WHERE id = @id:uuid',
      parameters: {'id': commentId, 'now': now},
      ignoreRows: true,
    );
    await _record(task, 'comment_delete', 'комментарий удален', actorUserId);
  }

  @override
  Future<List<TaskCommentDto>> listComments({
    required String taskId,
    required String actorUserId,
  }) async {
    final task = await _task(taskId);
    await _ensureBoardAccess(boardId: task.boardId, userId: actorUserId);
    final result = await _database.execute(
      'SELECT * FROM task_comments WHERE task_id = @taskId:uuid AND deleted_at IS NULL ORDER BY created_at ASC',
      parameters: {'taskId': taskId},
    );
    return result
        .map((row) => _commentFromRow(row.toColumnMap()))
        .toList(growable: false);
  }

  @override
  Future<TaskCommentDto> updateComment({
    required String commentId,
    required String actorUserId,
    required String content,
  }) async {
    final comment = await _comment(commentId);
    final task = await _task(comment.taskId);
    await _ensureBoardAccess(boardId: task.boardId, userId: actorUserId);
    final updated = TaskCommentDto(
      id: comment.id,
      taskId: comment.taskId,
      authorId: comment.authorId,
      content: _required(content, 'Комментарий не пустой'),
      createdAt: comment.createdAt,
      updatedAt: DateTime.now().toUtc(),
      deletedAt: comment.deletedAt,
    );
    await _database.execute(
      'UPDATE task_comments SET content = @content, updated_at = @updatedAt WHERE id = @id:uuid',
      parameters: _commentParams(updated),
      ignoreRows: true,
    );
    await _record(task, 'comment_update', 'комментарий изменен', actorUserId);
    return updated;
  }

  @override
  Future<TaskAssigneeDto> assign({
    required String taskId,
    required String userId,
    required String actorUserId,
    String? id,
  }) async {
    final task = await _task(taskId);
    await _ensureBoardAccess(boardId: task.boardId, userId: actorUserId);
    final assignee = TaskAssigneeDto(
      id: id ?? _uuid.v7(),
      taskId: taskId,
      userId: userId,
      assignedBy: actorUserId,
      assignedAt: DateTime.now().toUtc(),
    );
    await _database.execute(
      '''
      INSERT INTO task_assignees (id, task_id, user_id, assigned_by, assigned_at)
      VALUES (@id:uuid, @taskId:uuid, @userId:uuid, @assignedBy:uuid, @assignedAt)
      ON CONFLICT (task_id, user_id) DO NOTHING
      ''',
      parameters: _assigneeParams(assignee),
      ignoreRows: true,
    );
    await _record(task, 'assign', 'назначен исполнитель', actorUserId);
    return assignee;
  }

  @override
  Future<List<TaskAssigneeDto>> listAssignees({
    required String taskId,
    required String actorUserId,
  }) async {
    final task = await _task(taskId);
    await _ensureBoardAccess(boardId: task.boardId, userId: actorUserId);
    final result = await _database.execute(
      'SELECT * FROM task_assignees WHERE task_id = @taskId:uuid ORDER BY assigned_at ASC',
      parameters: {'taskId': taskId},
    );
    return result
        .map((row) => _assigneeFromRow(row.toColumnMap()))
        .toList(growable: false);
  }

  @override
  Future<void> unassign({
    required String taskId,
    required String userId,
    required String actorUserId,
  }) async {
    final task = await _task(taskId);
    await _ensureBoardAccess(boardId: task.boardId, userId: actorUserId);
    await _database.execute(
      'DELETE FROM task_assignees WHERE task_id = @taskId:uuid AND user_id = @userId:uuid',
      parameters: {'taskId': taskId, 'userId': userId},
      ignoreRows: true,
    );
    await _record(task, 'unassign', 'исполнитель снят', actorUserId);
  }

  @override
  Future<List<TaskHistoryEntryDto>> listHistory({
    required String taskId,
    required String actorUserId,
  }) async {
    final task = await _task(taskId);
    await _ensureBoardAccess(boardId: task.boardId, userId: actorUserId);
    final result = await _database.execute(
      'SELECT * FROM task_history WHERE task_id = @taskId:uuid ORDER BY changed_at DESC',
      parameters: {'taskId': taskId},
    );
    return result
        .map((row) => _historyFromRow(row.toColumnMap()))
        .toList(growable: false);
  }

  Future<void> _ensureBoardAccess({
    required String boardId,
    required String userId,
  }) async {
    final result = await _database.execute(
      '''
      SELECT 1 FROM boards b
      LEFT JOIN board_members bm ON bm.board_id = b.id
      LEFT JOIN workspace_members wm ON wm.workspace_id = b.workspace_id
      WHERE b.id = @boardId:uuid AND b.deleted_at IS NULL
        AND (b.owner_id = @userId:uuid OR bm.user_id = @userId:uuid OR wm.user_id = @userId:uuid)
      LIMIT 1
      ''',
      parameters: {'boardId': boardId, 'userId': userId},
    );
    if (result.isEmpty) {
      throw const ApiException(
        statusCode: 403,
        code: 'board_forbidden',
        message: 'Нет доступа к доске',
      );
    }
  }

  Future<TaskDto> _task(String taskId) async {
    final result = await _database.execute(
      'SELECT * FROM tasks WHERE id = @id:uuid AND deleted_at IS NULL LIMIT 1',
      parameters: {'id': taskId},
    );
    if (result.isEmpty) {
      throw const ApiException(
        statusCode: 404,
        code: 'task_not_found',
        message: 'Задача не найдена',
      );
    }
    return _taskFromRow(result.single.toColumnMap());
  }

  Future<TaskCommentDto> _comment(String id) async {
    final result = await _database.execute(
      'SELECT * FROM task_comments WHERE id = @id:uuid AND deleted_at IS NULL LIMIT 1',
      parameters: {'id': id},
    );
    if (result.isEmpty) {
      throw const ApiException(
        statusCode: 404,
        code: 'comment_not_found',
        message: 'Комментарий не найден',
      );
    }
    return _commentFromRow(result.single.toColumnMap());
  }

  Future<void> _record(
    TaskDto task,
    String action,
    String summary,
    String actorUserId,
  ) {
    return _database.execute(
      '''
      INSERT INTO task_history (
        id, task_id, board_id, action, summary, details_json, actor_user_id, changed_at
      ) VALUES (
        @id:uuid, @taskId:uuid, @boardId:uuid, @action, @summary, @detailsJson,
        @actorUserId:uuid, @changedAt
      )
      ''',
      parameters: {
        'id': _uuid.v7(),
        'taskId': task.id,
        'boardId': task.boardId,
        'action': action,
        'summary': summary,
        'detailsJson': jsonEncode({'source': 'server'}),
        'actorUserId': actorUserId,
        'changedAt': DateTime.now().toUtc(),
      },
      ignoreRows: true,
    );
  }

  TaskDto _taskFromRow(Map<String, dynamic> row) => TaskDto(
    id: row['id'].toString(),
    boardId: row['board_id'].toString(),
    columnId: row['column_id']?.toString(),
    parentTaskId: row['parent_task_id']?.toString(),
    taskTypeId: row['task_type_id']?.toString(),
    title: row['title'] as String,
    description: row['description'] as String?,
    cardBackgroundColor: row['card_background_color'] as String?,
    cardTextColor: row['card_text_color'] as String?,
    position: row['position'] as int,
    depth: row['depth'] as int,
    status: row['status'] as String,
    priority: row['priority'] as String,
    assigneeName: row['assignee_name'] as String?,
    labels: (jsonDecode(row['labels_json'] as String) as List<dynamic>)
        .cast<String>(),
    startDate: (row['start_date'] as DateTime?)?.toUtc(),
    dueDate: (row['due_date'] as DateTime?)?.toUtc(),
    completedAt: (row['completed_at'] as DateTime?)?.toUtc(),
    estimatedDurationMinutes: row['estimated_duration_minutes'] as int?,
    actualDurationMinutes: row['actual_duration_minutes'] as int?,
    periodType: row['period_type'] as String,
    isCompleted: row['is_completed'] as bool,
    createdAt: (row['created_at'] as DateTime).toUtc(),
    updatedAt: (row['updated_at'] as DateTime).toUtc(),
    deletedAt: (row['deleted_at'] as DateTime?)?.toUtc(),
  );

  TaskCommentDto _commentFromRow(Map<String, dynamic> row) => TaskCommentDto(
    id: row['id'].toString(),
    taskId: row['task_id'].toString(),
    authorId: row['author_id'].toString(),
    content: row['content'] as String,
    createdAt: (row['created_at'] as DateTime).toUtc(),
    updatedAt: (row['updated_at'] as DateTime).toUtc(),
    deletedAt: (row['deleted_at'] as DateTime?)?.toUtc(),
  );

  TaskAssigneeDto _assigneeFromRow(Map<String, dynamic> row) => TaskAssigneeDto(
    id: row['id'].toString(),
    taskId: row['task_id'].toString(),
    userId: row['user_id'].toString(),
    assignedBy: row['assigned_by'].toString(),
    assignedAt: (row['assigned_at'] as DateTime).toUtc(),
  );

  TaskHistoryEntryDto _historyFromRow(Map<String, dynamic> row) =>
      TaskHistoryEntryDto(
        id: row['id'].toString(),
        taskId: row['task_id'].toString(),
        boardId: row['board_id'].toString(),
        action: row['action'] as String,
        summary: row['summary'] as String,
        details: row['details_json'] == null
            ? null
            : (jsonDecode(row['details_json'] as String)
                      as Map<String, dynamic>)
                  .cast<String, Object?>(),
        actorUserId: row['actor_user_id']?.toString(),
        changedAt: (row['changed_at'] as DateTime).toUtc(),
      );

  Map<String, Object?> _taskParams(TaskDto task) => {
    'id': task.id,
    'boardId': task.boardId,
    'columnId': task.columnId,
    'parentTaskId': task.parentTaskId,
    'taskTypeId': task.taskTypeId,
    'title': task.title,
    'description': task.description,
    'cardBackgroundColor': task.cardBackgroundColor,
    'cardTextColor': task.cardTextColor,
    'position': task.position,
    'depth': task.depth,
    'status': task.status,
    'priority': task.priority,
    'assigneeName': task.assigneeName,
    'labelsJson': jsonEncode(task.labels),
    'startDate': task.startDate,
    'dueDate': task.dueDate,
    'completedAt': task.completedAt,
    'estimatedDurationMinutes': task.estimatedDurationMinutes,
    'actualDurationMinutes': task.actualDurationMinutes,
    'periodType': task.periodType,
    'isCompleted': task.isCompleted,
    'createdAt': task.createdAt,
    'updatedAt': task.updatedAt,
    'deletedAt': task.deletedAt,
  };

  Map<String, Object?> _commentParams(TaskCommentDto comment) => {
    'id': comment.id,
    'taskId': comment.taskId,
    'authorId': comment.authorId,
    'content': comment.content,
    'createdAt': comment.createdAt,
    'updatedAt': comment.updatedAt,
    'deletedAt': comment.deletedAt,
  };

  Map<String, Object?> _assigneeParams(TaskAssigneeDto assignee) => {
    'id': assignee.id,
    'taskId': assignee.taskId,
    'userId': assignee.userId,
    'assignedBy': assignee.assignedBy,
    'assignedAt': assignee.assignedAt,
  };

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

const _insertTaskSql = '''
INSERT INTO tasks (
  id, board_id, column_id, parent_task_id, task_type_id, title, description,
  card_background_color, card_text_color, position, depth, status, priority,
  assignee_name, labels_json, start_date, due_date, completed_at,
  estimated_duration_minutes, actual_duration_minutes, period_type,
  is_completed, created_at, updated_at, deleted_at
) VALUES (
  @id:uuid, @boardId:uuid, @columnId:uuid, @parentTaskId:uuid, @taskTypeId:uuid,
  @title, @description, @cardBackgroundColor, @cardTextColor, @position, @depth,
  @status, @priority, @assigneeName, @labelsJson, @startDate, @dueDate,
  @completedAt, @estimatedDurationMinutes, @actualDurationMinutes, @periodType,
  @isCompleted, @createdAt, @updatedAt, @deletedAt
)
''';

const _updateTaskSql = '''
UPDATE tasks SET
  column_id = @columnId:uuid, parent_task_id = @parentTaskId:uuid,
  task_type_id = @taskTypeId:uuid, title = @title, description = @description,
  card_background_color = @cardBackgroundColor, card_text_color = @cardTextColor,
  position = @position, depth = @depth, status = @status, priority = @priority,
  assignee_name = @assigneeName, labels_json = @labelsJson, start_date = @startDate,
  due_date = @dueDate, completed_at = @completedAt,
  estimated_duration_minutes = @estimatedDurationMinutes,
  actual_duration_minutes = @actualDurationMinutes, period_type = @periodType,
  is_completed = @isCompleted, updated_at = @updatedAt, deleted_at = @deletedAt
WHERE id = @id:uuid
''';
