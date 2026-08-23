// In-memory boards repository для server tests.
import 'package:kanban_contracts/kanban_contracts.dart';
import 'package:kanban_server/src/boards/board_data_repository.dart';
import 'package:kanban_server/src/http/api_exception.dart';
import 'package:uuid/uuid.dart';

final class InMemoryBoardDataRepository implements BoardDataRepository {
  InMemoryBoardDataRepository({Uuid uuid = const Uuid()}) : _uuid = uuid;

  final Uuid _uuid;
  final _boards = <String, BoardDto>{};
  final _members = <String, BoardMemberDto>{};
  final _columns = <String, BoardColumnDto>{};
  final _types = <String, TaskTypeDto>{};

  @override
  Future<BoardDto> createBoard({
    required String ownerId,
    required String title,
    String? workspaceId,
    String? description,
  }) async {
    final now = DateTime.now().toUtc();
    final board = BoardDto(
      id: _uuid.v7(),
      ownerId: ownerId,
      workspaceId: workspaceId,
      title: _required(title, 'Название доски не пустое'),
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
    _boards[board.id] = board;
    _members[member.id] = member;
    return board;
  }

  @override
  Future<void> deleteBoard({
    required String boardId,
    required String actorUserId,
  }) async {
    _ensureBoardAccess(boardId, actorUserId);
    final board = _boards[boardId];
    if (board == null) return;
    _boards[boardId] = BoardDto(
      id: board.id,
      ownerId: board.ownerId,
      workspaceId: board.workspaceId,
      title: board.title,
      description: board.description,
      createdAt: board.createdAt,
      updatedAt: DateTime.now().toUtc(),
      deletedAt: DateTime.now().toUtc(),
    );
  }

  @override
  Future<List<BoardDto>> listBoards(String userId) async {
    final ids = _members.values
        .where((member) => member.userId == userId)
        .map((member) => member.boardId)
        .toSet();
    return _boards.values
        .where((board) => board.deletedAt == null && ids.contains(board.id))
        .toList(growable: false);
  }

  @override
  Future<List<BoardMemberDto>> listBoardMembers({
    required String boardId,
    required String actorUserId,
  }) async {
    _ensureBoardAccess(boardId, actorUserId);
    return _members.values
        .where((member) => member.boardId == boardId)
        .toList(growable: false);
  }

  @override
  Future<BoardDto> updateBoard({
    required String boardId,
    required String actorUserId,
    String? title,
    String? description,
  }) async {
    _ensureBoardAccess(boardId, actorUserId);
    final board = _board(boardId);
    final updated = BoardDto(
      id: board.id,
      ownerId: board.ownerId,
      workspaceId: board.workspaceId,
      title: title == null
          ? board.title
          : _required(title, 'Название доски не пустое'),
      description: description == null
          ? board.description
          : _optional(description),
      createdAt: board.createdAt,
      updatedAt: DateTime.now().toUtc(),
      deletedAt: board.deletedAt,
    );
    _boards[boardId] = updated;
    return updated;
  }

  @override
  Future<BoardColumnDto> createColumn({
    required String actorUserId,
    required String boardId,
    required String title,
    required int position,
  }) async {
    _ensureBoardAccess(boardId, actorUserId);
    final now = DateTime.now().toUtc();
    final column = BoardColumnDto(
      id: _uuid.v7(),
      boardId: boardId,
      title: _required(title, 'Название колонки не пустое'),
      position: position,
      createdAt: now,
      updatedAt: now,
    );
    _columns[column.id] = column;
    return column;
  }

  @override
  Future<void> deleteColumn({
    required String actorUserId,
    required String columnId,
  }) async {
    final column = _column(columnId);
    _ensureBoardAccess(column.boardId, actorUserId);
    _columns[columnId] = BoardColumnDto(
      id: column.id,
      boardId: column.boardId,
      title: column.title,
      position: column.position,
      createdAt: column.createdAt,
      updatedAt: DateTime.now().toUtc(),
      deletedAt: DateTime.now().toUtc(),
    );
  }

  @override
  Future<BoardColumnDto> updateColumn({
    required String actorUserId,
    required String columnId,
    String? title,
    int? position,
  }) async {
    final column = _column(columnId);
    _ensureBoardAccess(column.boardId, actorUserId);
    final updated = BoardColumnDto(
      id: column.id,
      boardId: column.boardId,
      title: title == null
          ? column.title
          : _required(title, 'Название колонки не пустое'),
      position: position ?? column.position,
      createdAt: column.createdAt,
      updatedAt: DateTime.now().toUtc(),
      deletedAt: column.deletedAt,
    );
    _columns[columnId] = updated;
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
    _ensureBoardAccess(boardId, actorUserId);
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
    _types[type.id] = type;
    return type;
  }

  @override
  Future<void> deleteTaskType({
    required String actorUserId,
    required String id,
  }) async {
    final type = _type(id);
    _ensureBoardAccess(type.boardId, actorUserId);
    _types[id] = TaskTypeDto(
      id: type.id,
      boardId: type.boardId,
      name: type.name,
      color: type.color,
      icon: type.icon,
      description: type.description,
      createdAt: type.createdAt,
      updatedAt: DateTime.now().toUtc(),
      deletedAt: DateTime.now().toUtc(),
    );
  }

  @override
  Future<List<TaskTypeDto>> listTaskTypes({
    required String actorUserId,
    required String boardId,
  }) async {
    _ensureBoardAccess(boardId, actorUserId);
    return _types.values
        .where((type) => type.boardId == boardId && type.deletedAt == null)
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
    final type = _type(id);
    _ensureBoardAccess(type.boardId, actorUserId);
    final updated = TaskTypeDto(
      id: type.id,
      boardId: type.boardId,
      name: name == null
          ? type.name
          : _required(name, 'Название типа не пустое'),
      color: color == null
          ? type.color
          : _required(color, 'Цвет типа не пустой'),
      icon: icon == null ? type.icon : _required(icon, 'Иконка типа не пустая'),
      description: description == null
          ? type.description
          : _optional(description),
      createdAt: type.createdAt,
      updatedAt: DateTime.now().toUtc(),
      deletedAt: type.deletedAt,
    );
    _types[id] = updated;
    return updated;
  }

  BoardDto _board(String boardId) {
    final board = _boards[boardId];
    if (board == null || board.deletedAt != null) {
      throw const ApiException(
        statusCode: 404,
        code: 'board_not_found',
        message: 'Доска не найдена',
      );
    }
    return board;
  }

  BoardColumnDto _column(String columnId) {
    final column = _columns[columnId];
    if (column == null || column.deletedAt != null) {
      throw const ApiException(
        statusCode: 404,
        code: 'column_not_found',
        message: 'Колонка не найдена',
      );
    }
    return column;
  }

  TaskTypeDto _type(String id) {
    final type = _types[id];
    if (type == null || type.deletedAt != null) {
      throw const ApiException(
        statusCode: 404,
        code: 'task_type_not_found',
        message: 'Тип задачи не найден',
      );
    }
    return type;
  }

  void _ensureBoardAccess(String boardId, String userId) {
    _board(boardId);
    final hasAccess = _members.values.any(
      (member) => member.boardId == boardId && member.userId == userId,
    );
    if (!hasAccess) {
      throw const ApiException(
        statusCode: 403,
        code: 'board_forbidden',
        message: 'Нет доступа к доске',
      );
    }
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
