// PostgreSQL-реализация досок, колонок и типов задач.
import 'package:kanban_contracts/kanban_contracts.dart';
import 'package:kanban_server/src/boards/board_data_repository.dart';
import 'package:kanban_server/src/database/postgres_database.dart';
import 'package:kanban_server/src/http/api_exception.dart';
import 'package:uuid/uuid.dart';

final class PostgresBoardDataRepository implements BoardDataRepository {
  const PostgresBoardDataRepository(
    this._database, {
    Uuid uuid = const Uuid(),
  }) : _uuid = uuid;

  final PostgresDatabase _database;
  final Uuid _uuid;

  @override
  Future<BoardDto> createBoard({
    required String ownerId,
    required String title,
    String? workspaceId,
    String? description,
  }) async {
    final trimmedTitle = _required(title, 'Название доски не пустое');
    if (workspaceId != null) {
      await _ensureWorkspaceAccess(workspaceId: workspaceId, userId: ownerId);
    }
    final now = DateTime.now().toUtc();
    final board = BoardDto(
      id: _uuid.v7(),
      ownerId: ownerId,
      workspaceId: workspaceId,
      title: trimmedTitle,
      description: _optional(description),
      createdAt: now,
      updatedAt: now,
    );
    final member = BoardMemberDto(
      id: '${board.id}:$ownerId',
      boardId: board.id,
      userId: ownerId,
      role: 'admin',
      joinedAt: now,
    );

    await _database.execute(
      '''
      INSERT INTO boards (
        id, owner_id, workspace_id, title, description, created_at, updated_at
      ) VALUES (
        @id:uuid, @ownerId:uuid, @workspaceId:uuid, @title, @description,
        @createdAt, @updatedAt
      )
      ''',
      parameters: {
        'id': board.id,
        'ownerId': board.ownerId,
        'workspaceId': board.workspaceId,
        'title': board.title,
        'description': board.description,
        'createdAt': board.createdAt,
        'updatedAt': board.updatedAt,
      },
      ignoreRows: true,
    );
    await _database.execute(
      '''
      INSERT INTO board_members (id, board_id, user_id, role, joined_at)
      VALUES (@id, @boardId:uuid, @userId:uuid, @role, @joinedAt)
      ''',
      parameters: {
        'id': member.id,
        'boardId': member.boardId,
        'userId': member.userId,
        'role': member.role,
        'joinedAt': member.joinedAt,
      },
      ignoreRows: true,
    );
    return board;
  }

  @override
  Future<void> deleteBoard({
    required String boardId,
    required String actorUserId,
  }) async {
    await _ensureBoardAccess(boardId: boardId, userId: actorUserId);
    await _database.execute(
      '''
      UPDATE boards
      SET deleted_at = @deletedAt, updated_at = @deletedAt
      WHERE id = @boardId:uuid
      ''',
      parameters: {
        'boardId': boardId,
        'deletedAt': DateTime.now().toUtc(),
      },
      ignoreRows: true,
    );
  }

  @override
  Future<List<BoardDto>> listBoards(String userId) async {
    final result = await _database.execute(
      '''
      SELECT DISTINCT b.*
      FROM boards b
      LEFT JOIN board_members bm ON bm.board_id = b.id
      LEFT JOIN workspace_members wm ON wm.workspace_id = b.workspace_id
      WHERE b.deleted_at IS NULL
        AND (b.owner_id = @userId:uuid OR bm.user_id = @userId:uuid OR wm.user_id = @userId:uuid)
      ORDER BY b.created_at DESC
      ''',
      parameters: {'userId': userId},
    );
    return result
        .map((row) => _boardFromRow(row.toColumnMap()))
        .toList(growable: false);
  }

  @override
  Future<List<BoardMemberDto>> listBoardMembers({
    required String boardId,
    required String actorUserId,
  }) async {
    await _ensureBoardAccess(boardId: boardId, userId: actorUserId);
    final result = await _database.execute(
      '''
      SELECT *
      FROM board_members
      WHERE board_id = @boardId:uuid
      ORDER BY joined_at ASC
      ''',
      parameters: {'boardId': boardId},
    );
    return result
        .map((row) => _memberFromRow(row.toColumnMap()))
        .toList(growable: false);
  }

  @override
  Future<BoardDto> updateBoard({
    required String boardId,
    required String actorUserId,
    String? title,
    String? description,
  }) async {
    await _ensureBoardAccess(boardId: boardId, userId: actorUserId);
    final current = await _board(boardId);
    final updated = BoardDto(
      id: current.id,
      ownerId: current.ownerId,
      workspaceId: current.workspaceId,
      title: title == null
          ? current.title
          : _required(title, 'Название доски не пустое'),
      description: description == null
          ? current.description
          : _optional(description),
      createdAt: current.createdAt,
      updatedAt: DateTime.now().toUtc(),
      deletedAt: current.deletedAt,
    );
    await _database.execute(
      '''
      UPDATE boards
      SET title = @title, description = @description, updated_at = @updatedAt
      WHERE id = @boardId:uuid
      ''',
      parameters: {
        'boardId': boardId,
        'title': updated.title,
        'description': updated.description,
        'updatedAt': updated.updatedAt,
      },
      ignoreRows: true,
    );
    return updated;
  }

  @override
  Future<BoardColumnDto> createColumn({
    required String actorUserId,
    required String boardId,
    required String title,
    required int position,
  }) async {
    await _ensureBoardAccess(boardId: boardId, userId: actorUserId);
    final now = DateTime.now().toUtc();
    final column = BoardColumnDto(
      id: _uuid.v7(),
      boardId: boardId,
      title: _required(title, 'Название колонки не пустое'),
      position: position,
      createdAt: now,
      updatedAt: now,
    );
    await _database.execute(
      '''
      INSERT INTO board_columns (
        id, board_id, title, position, created_at, updated_at
      ) VALUES (
        @id:uuid, @boardId:uuid, @title, @position, @createdAt, @updatedAt
      )
      ''',
      parameters: {
        'id': column.id,
        'boardId': column.boardId,
        'title': column.title,
        'position': column.position,
        'createdAt': column.createdAt,
        'updatedAt': column.updatedAt,
      },
      ignoreRows: true,
    );
    return column;
  }

  @override
  Future<void> deleteColumn({
    required String actorUserId,
    required String columnId,
  }) async {
    final column = await _column(columnId);
    await _ensureBoardAccess(boardId: column.boardId, userId: actorUserId);
    await _database.execute(
      '''
      UPDATE board_columns
      SET deleted_at = @deletedAt, updated_at = @deletedAt
      WHERE id = @columnId:uuid
      ''',
      parameters: {
        'columnId': columnId,
        'deletedAt': DateTime.now().toUtc(),
      },
      ignoreRows: true,
    );
  }

  @override
  Future<BoardColumnDto> updateColumn({
    required String actorUserId,
    required String columnId,
    String? title,
    int? position,
  }) async {
    final current = await _column(columnId);
    await _ensureBoardAccess(boardId: current.boardId, userId: actorUserId);
    final updated = BoardColumnDto(
      id: current.id,
      boardId: current.boardId,
      title: title == null
          ? current.title
          : _required(title, 'Название колонки не пустое'),
      position: position ?? current.position,
      createdAt: current.createdAt,
      updatedAt: DateTime.now().toUtc(),
      deletedAt: current.deletedAt,
    );
    await _database.execute(
      '''
      UPDATE board_columns
      SET title = @title, position = @position, updated_at = @updatedAt
      WHERE id = @columnId:uuid
      ''',
      parameters: {
        'columnId': columnId,
        'title': updated.title,
        'position': updated.position,
        'updatedAt': updated.updatedAt,
      },
      ignoreRows: true,
    );
    return updated;
  }

  @override
  Future<TaskTypeDto> createTaskType({
    required String actorUserId,
    required String boardId,
    required String name,
    required String color,
    required String icon,
    String? description,
  }) async {
    await _ensureBoardAccess(boardId: boardId, userId: actorUserId);
    final now = DateTime.now().toUtc();
    final type = TaskTypeDto(
      id: _uuid.v7(),
      boardId: boardId,
      name: _required(name, 'Название типа не пустое'),
      color: _required(color, 'Цвет типа не пустой'),
      icon: _required(icon, 'Иконка типа не пустая'),
      description: _optional(description),
      createdAt: now,
      updatedAt: now,
    );
    await _database.execute(
      '''
      INSERT INTO task_types (
        id, board_id, name, color, icon, description, created_at, updated_at
      ) VALUES (
        @id:uuid, @boardId:uuid, @name, @color, @icon, @description,
        @createdAt, @updatedAt
      )
      ''',
      parameters: {
        'id': type.id,
        'boardId': type.boardId,
        'name': type.name,
        'color': type.color,
        'icon': type.icon,
        'description': type.description,
        'createdAt': type.createdAt,
        'updatedAt': type.updatedAt,
      },
      ignoreRows: true,
    );
    return type;
  }

  @override
  Future<void> deleteTaskType({
    required String actorUserId,
    required String id,
  }) async {
    final type = await _taskType(id);
    await _ensureBoardAccess(boardId: type.boardId, userId: actorUserId);
    await _database.execute(
      '''
      UPDATE task_types
      SET deleted_at = @deletedAt, updated_at = @deletedAt
      WHERE id = @id:uuid
      ''',
      parameters: {
        'id': id,
        'deletedAt': DateTime.now().toUtc(),
      },
      ignoreRows: true,
    );
  }

  @override
  Future<List<TaskTypeDto>> listTaskTypes({
    required String actorUserId,
    required String boardId,
  }) async {
    await _ensureBoardAccess(boardId: boardId, userId: actorUserId);
    final result = await _database.execute(
      '''
      SELECT *
      FROM task_types
      WHERE board_id = @boardId:uuid AND deleted_at IS NULL
      ORDER BY created_at ASC
      ''',
      parameters: {'boardId': boardId},
    );
    return result
        .map((row) => _taskTypeFromRow(row.toColumnMap()))
        .toList(growable: false);
  }

  @override
  Future<TaskTypeDto> updateTaskType({
    required String actorUserId,
    required String id,
    String? name,
    String? color,
    String? icon,
    String? description,
  }) async {
    final current = await _taskType(id);
    await _ensureBoardAccess(boardId: current.boardId, userId: actorUserId);
    final updated = TaskTypeDto(
      id: current.id,
      boardId: current.boardId,
      name: name == null
          ? current.name
          : _required(name, 'Название типа не пустое'),
      color: color == null
          ? current.color
          : _required(color, 'Цвет типа не пустой'),
      icon: icon == null
          ? current.icon
          : _required(icon, 'Иконка типа не пустая'),
      description: description == null
          ? current.description
          : _optional(description),
      createdAt: current.createdAt,
      updatedAt: DateTime.now().toUtc(),
      deletedAt: current.deletedAt,
    );
    await _database.execute(
      '''
      UPDATE task_types
      SET name = @name, color = @color, icon = @icon,
        description = @description, updated_at = @updatedAt
      WHERE id = @id:uuid
      ''',
      parameters: {
        'id': id,
        'name': updated.name,
        'color': updated.color,
        'icon': updated.icon,
        'description': updated.description,
        'updatedAt': updated.updatedAt,
      },
      ignoreRows: true,
    );
    return updated;
  }

  Future<void> _ensureWorkspaceAccess({
    required String workspaceId,
    required String userId,
  }) async {
    final result = await _database.execute(
      '''
      SELECT 1
      FROM workspace_members
      WHERE workspace_id = @workspaceId:uuid AND user_id = @userId:uuid
      LIMIT 1
      ''',
      parameters: {'workspaceId': workspaceId, 'userId': userId},
    );
    if (result.isEmpty) {
      throw const ApiException(
        statusCode: 403,
        code: 'workspace_forbidden',
        message: 'Нет доступа к workspace',
      );
    }
  }

  Future<void> _ensureBoardAccess({
    required String boardId,
    required String userId,
  }) async {
    final result = await _database.execute(
      '''
      SELECT 1
      FROM boards b
      LEFT JOIN board_members bm ON bm.board_id = b.id
      LEFT JOIN workspace_members wm ON wm.workspace_id = b.workspace_id
      WHERE b.id = @boardId:uuid
        AND b.deleted_at IS NULL
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

  Future<BoardDto> _board(String boardId) async {
    final result = await _database.execute(
      'SELECT * FROM boards WHERE id = @boardId:uuid AND deleted_at IS NULL',
      parameters: {'boardId': boardId},
    );
    if (result.isEmpty) {
      throw const ApiException(
        statusCode: 404,
        code: 'board_not_found',
        message: 'Доска не найдена',
      );
    }
    return _boardFromRow(result.single.toColumnMap());
  }

  Future<BoardColumnDto> _column(String columnId) async {
    final result = await _database.execute(
      '''
      SELECT * FROM board_columns
      WHERE id = @columnId:uuid AND deleted_at IS NULL
      ''',
      parameters: {'columnId': columnId},
    );
    if (result.isEmpty) {
      throw const ApiException(
        statusCode: 404,
        code: 'column_not_found',
        message: 'Колонка не найдена',
      );
    }
    return _columnFromRow(result.single.toColumnMap());
  }

  Future<TaskTypeDto> _taskType(String id) async {
    final result = await _database.execute(
      'SELECT * FROM task_types WHERE id = @id:uuid AND deleted_at IS NULL',
      parameters: {'id': id},
    );
    if (result.isEmpty) {
      throw const ApiException(
        statusCode: 404,
        code: 'task_type_not_found',
        message: 'Тип задачи не найден',
      );
    }
    return _taskTypeFromRow(result.single.toColumnMap());
  }

  BoardDto _boardFromRow(Map<String, dynamic> row) {
    return BoardDto(
      id: row['id'].toString(),
      ownerId: row['owner_id'].toString(),
      workspaceId: row['workspace_id']?.toString(),
      title: row['title'] as String,
      description: row['description'] as String?,
      createdAt: (row['created_at'] as DateTime).toUtc(),
      updatedAt: (row['updated_at'] as DateTime).toUtc(),
      deletedAt: (row['deleted_at'] as DateTime?)?.toUtc(),
    );
  }

  BoardMemberDto _memberFromRow(Map<String, dynamic> row) {
    return BoardMemberDto(
      id: row['id'] as String,
      boardId: row['board_id'].toString(),
      userId: row['user_id'].toString(),
      role: row['role'] as String,
      joinedAt: (row['joined_at'] as DateTime).toUtc(),
    );
  }

  BoardColumnDto _columnFromRow(Map<String, dynamic> row) {
    return BoardColumnDto(
      id: row['id'].toString(),
      boardId: row['board_id'].toString(),
      title: row['title'] as String,
      position: row['position'] as int,
      createdAt: (row['created_at'] as DateTime).toUtc(),
      updatedAt: (row['updated_at'] as DateTime).toUtc(),
      deletedAt: (row['deleted_at'] as DateTime?)?.toUtc(),
    );
  }

  TaskTypeDto _taskTypeFromRow(Map<String, dynamic> row) {
    return TaskTypeDto(
      id: row['id'].toString(),
      boardId: row['board_id'].toString(),
      name: row['name'] as String,
      color: row['color'] as String,
      icon: row['icon'] as String,
      description: row['description'] as String?,
      createdAt: (row['created_at'] as DateTime).toUtc(),
      updatedAt: (row['updated_at'] as DateTime).toUtc(),
      deletedAt: (row['deleted_at'] as DateTime?)?.toUtc(),
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
