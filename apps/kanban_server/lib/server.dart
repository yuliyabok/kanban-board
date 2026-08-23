// HTTP/WebSocket scaffold сервера: здесь собираются routes, middleware и
// первые endpoints, которые приложение сможет дергать в server-режиме.
import 'dart:convert';

import 'package:kanban_contracts/kanban_contracts.dart';
import 'package:kanban_server/src/auth/auth_service.dart';
import 'package:kanban_server/src/auth/in_memory_auth_repository.dart';
import 'package:kanban_server/src/auth/jwt_service.dart';
import 'package:kanban_server/src/auth/password_hasher.dart';
import 'package:kanban_server/src/boards/board_data_repository.dart';
import 'package:kanban_server/src/boards/in_memory_board_data_repository.dart';
import 'package:kanban_server/src/config/server_config.dart';
import 'package:kanban_server/src/http/api_exception.dart';
import 'package:kanban_server/src/tasks/in_memory_task_data_repository.dart';
import 'package:kanban_server/src/tasks/task_data_repository.dart';
import 'package:kanban_server/src/workspaces/in_memory_workspace_repository.dart';
import 'package:kanban_server/src/workspaces/workspace_repository.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

Handler createServerHandler({
  AuthService? authService,
  WorkspaceRepository? workspaceRepository,
  BoardDataRepository? boardDataRepository,
  TaskDataRepository? taskDataRepository,
}) {
  final auth = authService ?? _createInMemoryAuthService();
  final workspaces = workspaceRepository ?? InMemoryWorkspaceRepository();
  final boardData = boardDataRepository ?? InMemoryBoardDataRepository();
  final taskData = taskDataRepository ?? InMemoryTaskDataRepository();
  final realtimeHub = _RealtimeHub();
  final router = Router()
    ..get(KanbanApiRoutes.health, _health)
    ..post(KanbanApiRoutes.authRegister, _register(auth))
    ..post(KanbanApiRoutes.authLogin, _login(auth))
    ..post(KanbanApiRoutes.authRefresh, _refresh(auth))
    ..post(KanbanApiRoutes.authLogout, _logout(auth))
    ..get(KanbanApiRoutes.authMe, _me(auth))
    ..get(KanbanApiRoutes.usersSearch, _usersSearch(auth))
    ..get(KanbanApiRoutes.workspaces, _listWorkspaces(auth, workspaces))
    ..post(KanbanApiRoutes.workspaces, _createWorkspace(auth, workspaces))
    ..get(
      '/workspaces/<id>/members',
      _workspaceMembers(auth, workspaces),
    )
    ..get(KanbanApiRoutes.boards, _listBoards(auth, boardData))
    ..post(KanbanApiRoutes.boards, _createBoard(auth, boardData))
    ..patch('/boards/<id>', _updateBoard(auth, boardData))
    ..delete('/boards/<id>', _deleteBoard(auth, boardData))
    ..get('/boards/<id>/members', _boardMembers(auth, boardData))
    ..post(KanbanApiRoutes.columns, _createColumn(auth, boardData))
    ..patch('/columns/<id>', _updateColumn(auth, boardData))
    ..delete('/columns/<id>', _deleteColumn(auth, boardData))
    ..get(KanbanApiRoutes.taskTypes, _listTaskTypes(auth, boardData))
    ..post(KanbanApiRoutes.taskTypes, _createTaskType(auth, boardData))
    ..patch('/task-types/<id>', _updateTaskType(auth, boardData))
    ..delete('/task-types/<id>', _deleteTaskType(auth, boardData))
    ..get(KanbanApiRoutes.tasks, _listTasks(auth, taskData))
    ..post(KanbanApiRoutes.tasks, _createTask(auth, taskData, realtimeHub))
    ..patch('/tasks/<id>', _updateTask(auth, taskData, realtimeHub))
    ..delete('/tasks/<id>', _deleteTask(auth, taskData, realtimeHub))
    ..get('/tasks/<id>/comments', _listComments(auth, taskData))
    ..post('/tasks/<id>/comments', _createComment(auth, taskData, realtimeHub))
    ..patch('/comments/<id>', _updateComment(auth, taskData, realtimeHub))
    ..delete('/comments/<id>', _deleteComment(auth, taskData, realtimeHub))
    ..get('/tasks/<id>/assignees', _listAssignees(auth, taskData))
    ..post('/tasks/<id>/assignees', _assignTask(auth, taskData))
    ..delete('/tasks/<id>/assignees/<userId>', _unassignTask(auth, taskData))
    ..get('/tasks/<id>/history', _taskHistory(auth, taskData))
    ..get(
      KanbanApiRoutes.pendingInvitations,
      _notImplemented('invitations.pending'),
    )
    ..get(KanbanApiRoutes.changesSummary, _changesSummary)
    ..post(KanbanApiRoutes.syncPending, _notImplemented('sync.pending'))
    ..get(KanbanApiRoutes.syncDelta, _syncDelta(realtimeHub))
    ..get(
      '/realtime',
      webSocketHandler((channel, protocol) {
        realtimeHub.add(channel);
      }),
    );

  return const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(_jsonErrorMiddleware())
      .addHandler(router.call);
}

Response _health(Request request) {
  return _jsonResponse({
    'status': 'ok',
    'service': 'kanban_server',
    'serverTime': DateTime.now().toUtc().toIso8601String(),
  });
}

Response _changesSummary(Request request) {
  final since = request.url.queryParameters['since'];
  final now = DateTime.now().toUtc();
  return _jsonResponse(
    ChangesSummaryDto(
      changedTasks: 0,
      comments: 0,
      newTasks: 0,
      overdueTasks: 0,
      since: since == null ? now : DateTime.parse(since).toUtc(),
      generatedAt: now,
    ).toJson(),
  );
}

Handler _syncDelta(_RealtimeHub realtimeHub) {
  return (Request request) {
    final since = request.url.queryParameters['since'];
    final sinceAt = since == null ? null : DateTime.parse(since).toUtc();
    final now = DateTime.now().toUtc();
    return _jsonResponse(
      SyncDeltaDto(
        serverTime: now,
        changedEntities: const [],
        deletedEntityIds: const [],
        historyEntries: const [],
        realtimeEvents: realtimeHub.eventsSince(sinceAt),
      ).toJson(),
    );
  };
}

final class _RealtimeHub {
  final _channels = <WebSocketChannel>{};
  final _events = <RealtimeEventDto>[];

  void add(WebSocketChannel channel) {
    _channels.add(channel);
    channel.stream.listen(
      (_) {},
      onDone: () => _channels.remove(channel),
      onError: (_) => _channels.remove(channel),
      cancelOnError: true,
    );
  }

  void publish(RealtimeEventDto event) {
    _events.add(event);
    if (_events.length > 1000) {
      _events.removeRange(0, _events.length - 1000);
    }
    final encoded = jsonEncode(event.toJson());
    for (final channel in List<WebSocketChannel>.from(_channels)) {
      channel.sink.add(encoded);
    }
  }

  List<RealtimeEventDto> eventsSince(DateTime? since) {
    if (since == null) {
      return List<RealtimeEventDto>.from(_events);
    }
    return _events
        .where((event) => event.occurredAt.isAfter(since))
        .toList(growable: false);
  }
}

Handler _notImplemented(String code) {
  return (Request request) {
    return _jsonResponse(
      ApiErrorDto(
        code: 'not_implemented',
        message: '$code endpoint scaffold is ready but not implemented yet',
      ).toJson(),
      statusCode: 501,
    );
  };
}

Middleware _jsonErrorMiddleware() {
  return (Handler innerHandler) {
    return (Request request) async {
      try {
        return await innerHandler(request);
      } on ApiException catch (error) {
        return _jsonResponse(
          ApiErrorDto(code: error.code, message: error.message).toJson(),
          statusCode: error.statusCode,
        );
      } on FormatException catch (error) {
        return _jsonResponse(
          ApiErrorDto(code: 'bad_request', message: error.message).toJson(),
          statusCode: 400,
        );
      } on Object catch (error) {
        return _jsonResponse(
          ApiErrorDto(
            code: 'internal_error',
            message: error.toString(),
          ).toJson(),
          statusCode: 500,
        );
      }
    };
  };
}

Handler _register(AuthService auth) {
  return (request) async {
    final body = await _readJson(request);
    return _jsonResponse(
      (await auth.register(RegistrationDto.fromJson(body))).toJson(),
      statusCode: 201,
    );
  };
}

Handler _login(AuthService auth) {
  return (request) async {
    final body = await _readJson(request);
    return _jsonResponse(
      (await auth.login(AuthCredentialsDto.fromJson(body))).toJson(),
    );
  };
}

Handler _refresh(AuthService auth) {
  return (request) async {
    final body = await _readJson(request);
    final refreshToken = body['refreshToken'];
    if (refreshToken is! String || refreshToken.isEmpty) {
      throw const ApiException(
        statusCode: 400,
        code: 'missing_refresh_token',
        message: 'Нужен refreshToken',
      );
    }
    return _jsonResponse((await auth.refresh(refreshToken)).toJson());
  };
}

Handler _logout(AuthService auth) {
  return (request) async {
    final body = await _readJson(request);
    final refreshToken = body['refreshToken'];
    if (refreshToken is String && refreshToken.isNotEmpty) {
      await auth.logout(refreshToken);
    }
    return _jsonResponse({'ok': true});
  };
}

Handler _me(AuthService auth) {
  return (request) async {
    return _jsonResponse(
      (await auth.me(request.headers['authorization'])).toJson(),
    );
  };
}

Handler _usersSearch(AuthService auth) {
  return (request) async {
    final current = await auth.currentUser(request.headers['authorization']);
    final query = request.url.queryParameters['query']?.trim().toLowerCase();
    final users =
        query == null ||
            query.isEmpty ||
            current.email.toLowerCase().contains(query) ||
            current.fullName.toLowerCase().contains(query)
        ? [current.toPublicDto()]
        : <UserDto>[];
    return _jsonResponse({
      'users': users.map((user) => user.toJson()).toList(),
    });
  };
}

Handler _listWorkspaces(
  AuthService auth,
  WorkspaceRepository workspaces,
) {
  return (request) async {
    final current = await auth.currentUser(request.headers['authorization']);
    final items = await workspaces.listForUser(current.id);
    return _jsonResponse({
      'workspaces': items.map((workspace) => workspace.toJson()).toList(),
    });
  };
}

Handler _createWorkspace(
  AuthService auth,
  WorkspaceRepository workspaces,
) {
  return (request) async {
    final current = await auth.currentUser(request.headers['authorization']);
    final body = await _readJson(request);
    final name = body['name'];
    if (name is! String || name.trim().isEmpty) {
      throw const ApiException(
        statusCode: 400,
        code: 'invalid_workspace_name',
        message: 'Название workspace не пустое',
      );
    }
    final workspace = await workspaces.create(
      name: name,
      ownerId: current.id,
    );
    return _jsonResponse(workspace.toJson(), statusCode: 201);
  };
}

Handler _workspaceMembers(
  AuthService auth,
  WorkspaceRepository workspaces,
) {
  return (request) async {
    final current = await auth.currentUser(request.headers['authorization']);
    final workspaceId = request.params['id'];
    if (workspaceId == null || workspaceId.isEmpty) {
      throw const ApiException(
        statusCode: 400,
        code: 'missing_workspace_id',
        message: 'Нужен workspace id',
      );
    }
    final members = await workspaces.listMembers(
      workspaceId: workspaceId,
      actorUserId: current.id,
    );
    return _jsonResponse({
      'members': members.map((member) => member.toJson()).toList(),
    });
  };
}

Handler _listBoards(AuthService auth, BoardDataRepository boardData) {
  return (request) async {
    final current = await auth.currentUser(request.headers['authorization']);
    final boards = await boardData.listBoards(current.id);
    return _jsonResponse({
      'boards': boards.map((board) => board.toJson()).toList(),
    });
  };
}

Handler _createBoard(AuthService auth, BoardDataRepository boardData) {
  return (request) async {
    final current = await auth.currentUser(request.headers['authorization']);
    final body = await _readJson(request);
    final board = await boardData.createBoard(
      ownerId: current.id,
      workspaceId: body['workspaceId'] as String?,
      title: _stringBody(body, 'title'),
      description: body['description'] as String?,
    );
    return _jsonResponse(board.toJson(), statusCode: 201);
  };
}

Handler _updateBoard(AuthService auth, BoardDataRepository boardData) {
  return (request) async {
    final current = await auth.currentUser(request.headers['authorization']);
    final boardId = _pathParam(request, 'id');
    final body = await _readJson(request);
    final board = await boardData.updateBoard(
      boardId: boardId,
      actorUserId: current.id,
      title: body['title'] as String?,
      description: body['description'] as String?,
    );
    return _jsonResponse(board.toJson());
  };
}

Handler _deleteBoard(AuthService auth, BoardDataRepository boardData) {
  return (request) async {
    final current = await auth.currentUser(request.headers['authorization']);
    await boardData.deleteBoard(
      boardId: _pathParam(request, 'id'),
      actorUserId: current.id,
    );
    return _jsonResponse({'ok': true});
  };
}

Handler _boardMembers(AuthService auth, BoardDataRepository boardData) {
  return (request) async {
    final current = await auth.currentUser(request.headers['authorization']);
    final members = await boardData.listBoardMembers(
      boardId: _pathParam(request, 'id'),
      actorUserId: current.id,
    );
    return _jsonResponse({
      'members': members.map((member) => member.toJson()).toList(),
    });
  };
}

Handler _createColumn(AuthService auth, BoardDataRepository boardData) {
  return (request) async {
    final current = await auth.currentUser(request.headers['authorization']);
    final body = await _readJson(request);
    final column = await boardData.createColumn(
      actorUserId: current.id,
      boardId: _stringBody(body, 'boardId'),
      title: _stringBody(body, 'title'),
      position: _intBody(body, 'position'),
    );
    return _jsonResponse(column.toJson(), statusCode: 201);
  };
}

Handler _updateColumn(AuthService auth, BoardDataRepository boardData) {
  return (request) async {
    final current = await auth.currentUser(request.headers['authorization']);
    final body = await _readJson(request);
    final column = await boardData.updateColumn(
      actorUserId: current.id,
      columnId: _pathParam(request, 'id'),
      title: body['title'] as String?,
      position: body['position'] as int?,
    );
    return _jsonResponse(column.toJson());
  };
}

Handler _deleteColumn(AuthService auth, BoardDataRepository boardData) {
  return (request) async {
    final current = await auth.currentUser(request.headers['authorization']);
    await boardData.deleteColumn(
      actorUserId: current.id,
      columnId: _pathParam(request, 'id'),
    );
    return _jsonResponse({'ok': true});
  };
}

Handler _listTaskTypes(AuthService auth, BoardDataRepository boardData) {
  return (request) async {
    final current = await auth.currentUser(request.headers['authorization']);
    final boardId = request.url.queryParameters['boardId'];
    if (boardId == null || boardId.isEmpty) {
      throw const ApiException(
        statusCode: 400,
        code: 'missing_board_id',
        message: 'Нужен boardId',
      );
    }
    final types = await boardData.listTaskTypes(
      actorUserId: current.id,
      boardId: boardId,
    );
    return _jsonResponse({
      'taskTypes': types.map((type) => type.toJson()).toList(),
    });
  };
}

Handler _createTaskType(AuthService auth, BoardDataRepository boardData) {
  return (request) async {
    final current = await auth.currentUser(request.headers['authorization']);
    final body = await _readJson(request);
    final type = await boardData.createTaskType(
      actorUserId: current.id,
      boardId: _stringBody(body, 'boardId'),
      name: _stringBody(body, 'name'),
      color: _stringBody(body, 'color'),
      icon: _stringBody(body, 'icon'),
      description: body['description'] as String?,
    );
    return _jsonResponse(type.toJson(), statusCode: 201);
  };
}

Handler _updateTaskType(AuthService auth, BoardDataRepository boardData) {
  return (request) async {
    final current = await auth.currentUser(request.headers['authorization']);
    final body = await _readJson(request);
    final type = await boardData.updateTaskType(
      actorUserId: current.id,
      id: _pathParam(request, 'id'),
      name: body['name'] as String?,
      color: body['color'] as String?,
      icon: body['icon'] as String?,
      description: body['description'] as String?,
    );
    return _jsonResponse(type.toJson());
  };
}

Handler _deleteTaskType(AuthService auth, BoardDataRepository boardData) {
  return (request) async {
    final current = await auth.currentUser(request.headers['authorization']);
    await boardData.deleteTaskType(
      actorUserId: current.id,
      id: _pathParam(request, 'id'),
    );
    return _jsonResponse({'ok': true});
  };
}

Handler _listTasks(AuthService auth, TaskDataRepository taskData) {
  return (request) async {
    final current = await auth.currentUser(request.headers['authorization']);
    final boardId = request.url.queryParameters['boardId'];
    if (boardId == null || boardId.isEmpty) {
      throw const ApiException(
        statusCode: 400,
        code: 'missing_board_id',
        message: 'Нужен boardId',
      );
    }
    final tasks = await taskData.listTasks(
      boardId: boardId,
      actorUserId: current.id,
    );
    return _jsonResponse({
      'tasks': tasks.map((task) => task.toJson()).toList(),
    });
  };
}

Handler _createTask(
  AuthService auth,
  TaskDataRepository taskData,
  _RealtimeHub realtimeHub,
) {
  return (request) async {
    final current = await auth.currentUser(request.headers['authorization']);
    final task = await taskData.createTask(
      task: TaskDto.fromJson(await _readJson(request)),
      actorUserId: current.id,
    );
    realtimeHub.publish(
      RealtimeEventDto(
        type: RealtimeEventTypes.taskCreated,
        payload: {'taskId': task.id, 'boardId': task.boardId},
        occurredAt: DateTime.now().toUtc(),
      ),
    );
    return _jsonResponse(task.toJson(), statusCode: 201);
  };
}

Handler _updateTask(
  AuthService auth,
  TaskDataRepository taskData,
  _RealtimeHub realtimeHub,
) {
  return (request) async {
    final current = await auth.currentUser(request.headers['authorization']);
    final task = await taskData.updateTask(
      taskId: _pathParam(request, 'id'),
      actorUserId: current.id,
      patch: await _readJson(request),
    );
    realtimeHub.publish(
      RealtimeEventDto(
        type: RealtimeEventTypes.taskUpdated,
        payload: {'taskId': task.id, 'boardId': task.boardId},
        occurredAt: DateTime.now().toUtc(),
      ),
    );
    return _jsonResponse(task.toJson());
  };
}

Handler _deleteTask(
  AuthService auth,
  TaskDataRepository taskData,
  _RealtimeHub realtimeHub,
) {
  return (request) async {
    final current = await auth.currentUser(request.headers['authorization']);
    final taskId = _pathParam(request, 'id');
    await taskData.deleteTask(
      taskId: taskId,
      actorUserId: current.id,
    );
    realtimeHub.publish(
      RealtimeEventDto(
        type: RealtimeEventTypes.taskDeleted,
        payload: {'taskId': taskId},
        occurredAt: DateTime.now().toUtc(),
      ),
    );
    return _jsonResponse({'ok': true});
  };
}

Handler _listComments(AuthService auth, TaskDataRepository taskData) {
  return (request) async {
    final current = await auth.currentUser(request.headers['authorization']);
    final comments = await taskData.listComments(
      taskId: _pathParam(request, 'id'),
      actorUserId: current.id,
    );
    return _jsonResponse({
      'comments': comments.map((item) => item.toJson()).toList(),
    });
  };
}

Handler _createComment(
  AuthService auth,
  TaskDataRepository taskData,
  _RealtimeHub realtimeHub,
) {
  return (request) async {
    final current = await auth.currentUser(request.headers['authorization']);
    final body = await _readJson(request);
    final comment = await taskData.createComment(
      id: body['id'] as String?,
      taskId: _pathParam(request, 'id'),
      actorUserId: current.id,
      content: _stringBody(body, 'content'),
    );
    realtimeHub.publish(
      RealtimeEventDto(
        type: RealtimeEventTypes.commentCreated,
        payload: {'commentId': comment.id, 'taskId': comment.taskId},
        occurredAt: DateTime.now().toUtc(),
      ),
    );
    return _jsonResponse(comment.toJson(), statusCode: 201);
  };
}

Handler _updateComment(
  AuthService auth,
  TaskDataRepository taskData,
  _RealtimeHub realtimeHub,
) {
  return (request) async {
    final current = await auth.currentUser(request.headers['authorization']);
    final body = await _readJson(request);
    final comment = await taskData.updateComment(
      commentId: _pathParam(request, 'id'),
      actorUserId: current.id,
      content: _stringBody(body, 'content'),
    );
    realtimeHub.publish(
      RealtimeEventDto(
        type: RealtimeEventTypes.commentUpdated,
        payload: {'commentId': comment.id, 'taskId': comment.taskId},
        occurredAt: DateTime.now().toUtc(),
      ),
    );
    return _jsonResponse(comment.toJson());
  };
}

Handler _deleteComment(
  AuthService auth,
  TaskDataRepository taskData,
  _RealtimeHub realtimeHub,
) {
  return (request) async {
    final current = await auth.currentUser(request.headers['authorization']);
    final commentId = _pathParam(request, 'id');
    await taskData.deleteComment(
      commentId: commentId,
      actorUserId: current.id,
    );
    realtimeHub.publish(
      RealtimeEventDto(
        type: RealtimeEventTypes.commentDeleted,
        payload: {'commentId': commentId},
        occurredAt: DateTime.now().toUtc(),
      ),
    );
    return _jsonResponse({'ok': true});
  };
}

Handler _listAssignees(AuthService auth, TaskDataRepository taskData) {
  return (request) async {
    final current = await auth.currentUser(request.headers['authorization']);
    final assignees = await taskData.listAssignees(
      taskId: _pathParam(request, 'id'),
      actorUserId: current.id,
    );
    return _jsonResponse({
      'assignees': assignees.map((item) => item.toJson()).toList(),
    });
  };
}

Handler _assignTask(AuthService auth, TaskDataRepository taskData) {
  return (request) async {
    final current = await auth.currentUser(request.headers['authorization']);
    final body = await _readJson(request);
    final assignee = await taskData.assign(
      id: body['id'] as String?,
      taskId: _pathParam(request, 'id'),
      userId: _stringBody(body, 'userId'),
      actorUserId: current.id,
    );
    return _jsonResponse(assignee.toJson(), statusCode: 201);
  };
}

Handler _unassignTask(AuthService auth, TaskDataRepository taskData) {
  return (request) async {
    final current = await auth.currentUser(request.headers['authorization']);
    await taskData.unassign(
      taskId: _pathParam(request, 'id'),
      userId: _pathParam(request, 'userId'),
      actorUserId: current.id,
    );
    return _jsonResponse({'ok': true});
  };
}

Handler _taskHistory(AuthService auth, TaskDataRepository taskData) {
  return (request) async {
    final current = await auth.currentUser(request.headers['authorization']);
    final history = await taskData.listHistory(
      taskId: _pathParam(request, 'id'),
      actorUserId: current.id,
    );
    return _jsonResponse({
      'history': history.map((item) => item.toJson()).toList(),
    });
  };
}

Future<Map<String, dynamic>> _readJson(Request request) async {
  final body = await request.readAsString();
  if (body.trim().isEmpty) return <String, dynamic>{};
  final decoded = jsonDecode(body);
  if (decoded is! Map<String, dynamic>) {
    throw const FormatException('Expected JSON object');
  }
  return decoded;
}

String _pathParam(Request request, String name) {
  final value = request.params[name];
  if (value == null || value.isEmpty) {
    throw ApiException(
      statusCode: 400,
      code: 'missing_$name',
      message: 'Не хватает параметра $name',
    );
  }
  return value;
}

String _stringBody(Map<String, dynamic> body, String key) {
  final value = body[key];
  if (value is! String || value.trim().isEmpty) {
    throw ApiException(
      statusCode: 400,
      code: 'missing_$key',
      message: 'Не хватает поля $key',
    );
  }
  return value;
}

int _intBody(Map<String, dynamic> body, String key) {
  final value = body[key];
  if (value is! int) {
    throw ApiException(
      statusCode: 400,
      code: 'missing_$key',
      message: 'Не хватает числового поля $key',
    );
  }
  return value;
}

Response _jsonResponse(Map<String, Object?> body, {int statusCode = 200}) {
  return Response(
    statusCode,
    body: jsonEncode(body),
    headers: const {'content-type': 'application/json; charset=utf-8'},
  );
}

AuthService _createInMemoryAuthService() {
  final config = ServerConfig.fromEnvironment(const {});
  return AuthService(
    repository: InMemoryAuthRepository(),
    passwordHasher: const PasswordHasher(),
    jwtService: JwtService(
      secret: config.jwtSecret,
      accessTokenTtl: config.accessTokenTtl,
    ),
    refreshTokenTtl: config.refreshTokenTtl,
  );
}
