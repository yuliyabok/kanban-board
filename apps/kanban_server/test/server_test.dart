// Smoke-тесты серверного scaffold: проверяют health, shared DTO и стандартную
// ошибку для endpoints, которые еще не реализованы.
import 'dart:convert';
import 'dart:io';

import 'package:kanban_contracts/kanban_contracts.dart';
import 'package:kanban_server/server.dart';
import 'package:kanban_server/src/auth/auth_service.dart';
import 'package:kanban_server/src/auth/in_memory_auth_repository.dart';
import 'package:kanban_server/src/auth/jwt_service.dart';
import 'package:kanban_server/src/auth/password_hasher.dart';
import 'package:kanban_server/src/boards/in_memory_board_data_repository.dart';
import 'package:kanban_server/src/database/migration_runner.dart';
import 'package:kanban_server/src/tasks/in_memory_task_data_repository.dart';
import 'package:kanban_server/src/workspaces/in_memory_workspace_repository.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

void main() {
  test('health endpoint returns service metadata', () async {
    final response = await createServerHandler()(
      Request('GET', Uri.parse('http://localhost${KanbanApiRoutes.health}')),
    );

    expect(response.statusCode, 200);
    final body = jsonDecode(await response.readAsString());
    expect(body, containsPair('status', 'ok'));
    expect(body, containsPair('service', 'kanban_server'));
  });

  test('changes summary uses shared contract shape', () async {
    final response = await createServerHandler()(
      Request(
        'GET',
        Uri.parse(
          'http://localhost${KanbanApiRoutes.changesSummary}?since=2026-06-01T00:00:00Z',
        ),
      ),
    );

    expect(response.statusCode, 200);
    final body = jsonDecode(await response.readAsString());
    final summary = ChangesSummaryDto.fromJson(body as Map<String, dynamic>);
    expect(summary.changedTasks, 0);
    expect(summary.since, DateTime.utc(2026, 6));
  });

  test('migration runner applies unapplied sql files once', () async {
    final executed = <String>[];
    final marked = <String>[];
    final runner = MigrationRunner(
      execute: (sql) async => executed.add(sql),
      appliedVersions: () async => const [],
      markApplied: (version) async => marked.add(version),
      migrationsDirectory: Directory('migrations'),
    );

    final applied = await runner.runPending();

    expect(applied, contains('001_auth.sql'));
    expect(marked, contains('001_auth.sql'));
    expect(executed.first, contains('CREATE TABLE IF NOT EXISTS users'));
    expect(
      executed.first,
      contains('CREATE TABLE IF NOT EXISTS refresh_sessions'),
    );
    expect(applied, contains('002_workspaces.sql'));
    expect(marked, contains('002_workspaces.sql'));
    expect(
      executed,
      contains(contains('CREATE TABLE IF NOT EXISTS workspaces')),
    );
    expect(applied, contains('003_boards_columns_task_types.sql'));
    expect(executed, contains(contains('CREATE TABLE IF NOT EXISTS boards')));
    expect(
      executed,
      contains(contains('CREATE TABLE IF NOT EXISTS board_columns')),
    );
    expect(
      executed,
      contains(contains('CREATE TABLE IF NOT EXISTS task_types')),
    );
    expect(applied, contains('004_tasks_comments_assignees_history.sql'));
    expect(executed.last, contains('CREATE TABLE IF NOT EXISTS tasks'));
    expect(executed.last, contains('CREATE TABLE IF NOT EXISTS task_comments'));
    expect(
      executed.last,
      contains('CREATE TABLE IF NOT EXISTS task_assignees'),
    );
    expect(executed.last, contains('CREATE TABLE IF NOT EXISTS task_history'));
  });

  test('register creates a user session', () async {
    final response = await _handler()(
      _jsonRequest(
        'POST',
        KanbanApiRoutes.authRegister,
        {
          'email': ' MEMBER@example.com ',
          'password': 'secret1',
          'displayName': 'Member',
        },
      ),
    );

    expect(response.statusCode, 201);
    final body = jsonDecode(await response.readAsString());
    final session = AuthSessionDto.fromJson(body as Map<String, dynamic>);
    expect(session.email, 'member@example.com');
    expect(session.accessToken, isNotEmpty);
    expect(session.refreshToken, isNotEmpty);
  });

  test('register rejects duplicate email with standard api error', () async {
    final handler = _handler();
    await handler(
      _jsonRequest(
        'POST',
        KanbanApiRoutes.authRegister,
        {'email': 'member@example.com', 'password': 'secret1'},
      ),
    );

    final response = await handler(
      _jsonRequest(
        'POST',
        KanbanApiRoutes.authRegister,
        {'email': ' MEMBER@example.com ', 'password': 'secret1'},
      ),
    );

    expect(response.statusCode, 409);
    final body = jsonDecode(await response.readAsString());
    expect(
      ApiErrorDto.fromJson(body as Map<String, dynamic>).code,
      'email_already_exists',
    );
  });

  test('login accepts valid password and rejects invalid password', () async {
    final handler = _handler();
    await handler(
      _jsonRequest(
        'POST',
        KanbanApiRoutes.authRegister,
        {'email': 'member@example.com', 'password': 'secret1'},
      ),
    );

    final success = await handler(
      _jsonRequest(
        'POST',
        KanbanApiRoutes.authLogin,
        {'email': 'member@example.com', 'password': 'secret1'},
      ),
    );
    expect(success.statusCode, 200);

    final failure = await handler(
      _jsonRequest(
        'POST',
        KanbanApiRoutes.authLogin,
        {'email': 'member@example.com', 'password': 'wrong-password'},
      ),
    );
    expect(failure.statusCode, 401);
  });

  test(
    'refresh returns a new session and logout revokes refresh token',
    () async {
      final handler = _handler();
      final register = await handler(
        _jsonRequest(
          'POST',
          KanbanApiRoutes.authRegister,
          {'email': 'member@example.com', 'password': 'secret1'},
        ),
      );
      final session = AuthSessionDto.fromJson(
        jsonDecode(await register.readAsString()) as Map<String, dynamic>,
      );

      final refreshed = await handler(
        _jsonRequest(
          'POST',
          KanbanApiRoutes.authRefresh,
          {'refreshToken': session.refreshToken},
        ),
      );
      expect(refreshed.statusCode, 200);
      final refreshedSession = AuthSessionDto.fromJson(
        jsonDecode(await refreshed.readAsString()) as Map<String, dynamic>,
      );

      final logout = await handler(
        _jsonRequest(
          'POST',
          KanbanApiRoutes.authLogout,
          {'refreshToken': refreshedSession.refreshToken},
        ),
      );
      expect(logout.statusCode, 200);

      final revokedRefresh = await handler(
        _jsonRequest(
          'POST',
          KanbanApiRoutes.authRefresh,
          {'refreshToken': refreshedSession.refreshToken},
        ),
      );
      expect(revokedRefresh.statusCode, 401);
    },
  );

  test('me returns current user only with bearer token', () async {
    final handler = _handler();
    final register = await handler(
      _jsonRequest(
        'POST',
        KanbanApiRoutes.authRegister,
        {
          'email': 'member@example.com',
          'password': 'secret1',
          'displayName': 'Member',
        },
      ),
    );
    final session = AuthSessionDto.fromJson(
      jsonDecode(await register.readAsString()) as Map<String, dynamic>,
    );

    final unauthorized = await handler(
      Request('GET', Uri.parse('http://localhost${KanbanApiRoutes.authMe}')),
    );
    expect(unauthorized.statusCode, 401);

    final authorized = await handler(
      Request(
        'GET',
        Uri.parse('http://localhost${KanbanApiRoutes.authMe}'),
        headers: {'authorization': 'Bearer ${session.accessToken}'},
      ),
    );
    expect(authorized.statusCode, 200);
    final user = UserDto.fromJson(
      jsonDecode(await authorized.readAsString()) as Map<String, dynamic>,
    );
    expect(user.fullName, 'Member');
  });

  test('users search returns current user for matching query', () async {
    final handler = _handler();
    final session = await _register(handler);

    final response = await handler(
      Request(
        'GET',
        Uri.parse('http://localhost${KanbanApiRoutes.usersSearch}?query=mem'),
        headers: {'authorization': 'Bearer ${session.accessToken}'},
      ),
    );

    expect(response.statusCode, 200);
    final body =
        jsonDecode(await response.readAsString()) as Map<String, dynamic>;
    final users = body['users'] as List<dynamic>;
    expect(users, hasLength(1));
    expect(
      (users.single as Map<String, dynamic>)['email'],
      'member@example.com',
    );
  });

  test('workspace endpoints require bearer token', () async {
    final response = await _handler()(
      Request(
        'GET',
        Uri.parse('http://localhost${KanbanApiRoutes.workspaces}'),
      ),
    );

    expect(response.statusCode, 401);
  });

  test('creates workspace and lists owner membership', () async {
    final handler = _handler();
    final session = await _register(handler);

    final created = await handler(
      _jsonRequest(
        'POST',
        KanbanApiRoutes.workspaces,
        {'name': 'Product'},
        accessToken: session.accessToken,
      ),
    );
    expect(created.statusCode, 201);
    final workspace = WorkspaceDto.fromJson(
      jsonDecode(await created.readAsString()) as Map<String, dynamic>,
    );
    expect(workspace.name, 'Product');
    expect(workspace.ownerId, session.userId);

    final list = await handler(
      Request(
        'GET',
        Uri.parse('http://localhost${KanbanApiRoutes.workspaces}'),
        headers: {'authorization': 'Bearer ${session.accessToken}'},
      ),
    );
    final listBody =
        jsonDecode(await list.readAsString()) as Map<String, dynamic>;
    expect(listBody['workspaces'] as List<dynamic>, hasLength(1));

    final members = await handler(
      Request(
        'GET',
        Uri.parse(
          'http://localhost${KanbanApiRoutes.workspaceMembers(workspace.id)}',
        ),
        headers: {'authorization': 'Bearer ${session.accessToken}'},
      ),
    );
    expect(members.statusCode, 200);
    final membersBody =
        jsonDecode(await members.readAsString()) as Map<String, dynamic>;
    final items = membersBody['members'] as List<dynamic>;
    expect(items, hasLength(1));
    expect((items.single as Map<String, dynamic>)['role'], 'owner');
  });

  test('creates, lists, updates and deletes boards', () async {
    final handler = _handler();
    final session = await _register(handler);

    final created = await _createBoard(handler, session);
    expect(created.title, 'Roadmap');

    final listed = await handler(
      Request(
        'GET',
        Uri.parse('http://localhost${KanbanApiRoutes.boards}'),
        headers: {'authorization': 'Bearer ${session.accessToken}'},
      ),
    );
    final listedBody =
        jsonDecode(await listed.readAsString()) as Map<String, dynamic>;
    expect(listedBody['boards'] as List<dynamic>, hasLength(1));

    final updated = await handler(
      _jsonRequest(
        'PATCH',
        KanbanApiRoutes.board(created.id),
        {'title': 'Updated roadmap'},
        accessToken: session.accessToken,
      ),
    );
    expect(updated.statusCode, 200);
    expect(
      BoardDto.fromJson(
        jsonDecode(await updated.readAsString()) as Map<String, dynamic>,
      ).title,
      'Updated roadmap',
    );

    final members = await handler(
      Request(
        'GET',
        Uri.parse(
          'http://localhost${KanbanApiRoutes.boardMembers(created.id)}',
        ),
        headers: {'authorization': 'Bearer ${session.accessToken}'},
      ),
    );
    final membersBody =
        jsonDecode(await members.readAsString()) as Map<String, dynamic>;
    expect(
      (membersBody['members'] as List<dynamic>).single,
      isA<Map<String, dynamic>>(),
    );

    final deleted = await handler(
      Request(
        'DELETE',
        Uri.parse('http://localhost${KanbanApiRoutes.board(created.id)}'),
        headers: {'authorization': 'Bearer ${session.accessToken}'},
      ),
    );
    expect(deleted.statusCode, 200);
  });

  test('creates, updates and deletes columns', () async {
    final handler = _handler();
    final session = await _register(handler);
    final board = await _createBoard(handler, session);

    final created = await handler(
      _jsonRequest(
        'POST',
        KanbanApiRoutes.columns,
        {'boardId': board.id, 'title': 'Todo', 'position': 0},
        accessToken: session.accessToken,
      ),
    );
    expect(created.statusCode, 201);
    final column = BoardColumnDto.fromJson(
      jsonDecode(await created.readAsString()) as Map<String, dynamic>,
    );
    expect(column.title, 'Todo');

    final updated = await handler(
      _jsonRequest(
        'PATCH',
        KanbanApiRoutes.column(column.id),
        {'title': 'Doing', 'position': 1},
        accessToken: session.accessToken,
      ),
    );
    expect(updated.statusCode, 200);
    expect(
      BoardColumnDto.fromJson(
        jsonDecode(await updated.readAsString()) as Map<String, dynamic>,
      ).position,
      1,
    );

    final deleted = await handler(
      Request(
        'DELETE',
        Uri.parse('http://localhost${KanbanApiRoutes.column(column.id)}'),
        headers: {'authorization': 'Bearer ${session.accessToken}'},
      ),
    );
    expect(deleted.statusCode, 200);
  });

  test('lists, creates, updates and deletes task types', () async {
    final handler = _handler();
    final session = await _register(handler);
    final board = await _createBoard(handler, session);

    final created = await handler(
      _jsonRequest(
        'POST',
        KanbanApiRoutes.taskTypes,
        {
          'boardId': board.id,
          'name': 'Bug',
          'color': '#ff0000',
          'icon': 'bug',
        },
        accessToken: session.accessToken,
      ),
    );
    expect(created.statusCode, 201);
    final type = TaskTypeDto.fromJson(
      jsonDecode(await created.readAsString()) as Map<String, dynamic>,
    );

    final listed = await handler(
      Request(
        'GET',
        Uri.parse(
          'http://localhost${KanbanApiRoutes.taskTypes}?boardId=${type.boardId}',
        ),
        headers: {'authorization': 'Bearer ${session.accessToken}'},
      ),
    );
    final listedBody =
        jsonDecode(await listed.readAsString()) as Map<String, dynamic>;
    expect(listedBody['taskTypes'] as List<dynamic>, hasLength(1));

    final updated = await handler(
      _jsonRequest(
        'PATCH',
        KanbanApiRoutes.taskType(type.id),
        {'name': 'Feature'},
        accessToken: session.accessToken,
      ),
    );
    expect(updated.statusCode, 200);
    expect(
      TaskTypeDto.fromJson(
        jsonDecode(await updated.readAsString()) as Map<String, dynamic>,
      ).name,
      'Feature',
    );

    final deleted = await handler(
      Request(
        'DELETE',
        Uri.parse('http://localhost${KanbanApiRoutes.taskType(type.id)}'),
        headers: {'authorization': 'Bearer ${session.accessToken}'},
      ),
    );
    expect(deleted.statusCode, 200);
  });

  test('creates, lists, updates and deletes tasks', () async {
    final handler = _handler();
    final session = await _register(handler);
    final board = await _createBoard(handler, session);
    final task = await _createTask(handler, session, board.id);

    final listed = await handler(
      Request(
        'GET',
        Uri.parse(
          'http://localhost${KanbanApiRoutes.tasks}?boardId=${board.id}',
        ),
        headers: {'authorization': 'Bearer ${session.accessToken}'},
      ),
    );
    final listedBody =
        jsonDecode(await listed.readAsString()) as Map<String, dynamic>;
    expect(listedBody['tasks'] as List<dynamic>, hasLength(1));

    final updated = await handler(
      _jsonRequest(
        'PATCH',
        KanbanApiRoutes.task(task.id),
        {'title': 'Updated task', 'priority': 'urgent'},
        accessToken: session.accessToken,
      ),
    );
    expect(updated.statusCode, 200);
    expect(
      TaskDto.fromJson(
        jsonDecode(await updated.readAsString()) as Map<String, dynamic>,
      ).priority,
      'urgent',
    );

    final deleted = await handler(
      Request(
        'DELETE',
        Uri.parse('http://localhost${KanbanApiRoutes.task(task.id)}'),
        headers: {'authorization': 'Bearer ${session.accessToken}'},
      ),
    );
    expect(deleted.statusCode, 200);
  });

  test('comments, assignees and history work for a task', () async {
    final handler = _handler();
    final session = await _register(handler);
    final board = await _createBoard(handler, session);
    final task = await _createTask(handler, session, board.id);
    const commentId = '019e939d-0000-7000-8000-000000000101';
    const assigneeId = '019e939d-0000-7000-8000-000000000102';

    final commentResponse = await handler(
      _jsonRequest(
        'POST',
        KanbanApiRoutes.taskComments(task.id),
        {'id': commentId, 'content': 'Looks good'},
        accessToken: session.accessToken,
      ),
    );
    expect(commentResponse.statusCode, 201);
    final comment = TaskCommentDto.fromJson(
      jsonDecode(await commentResponse.readAsString()) as Map<String, dynamic>,
    );
    expect(comment.id, commentId);

    final comments = await handler(
      Request(
        'GET',
        Uri.parse('http://localhost${KanbanApiRoutes.taskComments(task.id)}'),
        headers: {'authorization': 'Bearer ${session.accessToken}'},
      ),
    );
    expect(
      (jsonDecode(await comments.readAsString())
              as Map<String, dynamic>)['comments']
          as List<dynamic>,
      hasLength(1),
    );

    final assignee = await handler(
      _jsonRequest(
        'POST',
        KanbanApiRoutes.taskAssignees(task.id),
        {'id': assigneeId, 'userId': session.userId},
        accessToken: session.accessToken,
      ),
    );
    expect(assignee.statusCode, 201);
    expect(
      TaskAssigneeDto.fromJson(
        jsonDecode(await assignee.readAsString()) as Map<String, dynamic>,
      ).id,
      assigneeId,
    );

    final assignees = await handler(
      Request(
        'GET',
        Uri.parse('http://localhost${KanbanApiRoutes.taskAssignees(task.id)}'),
        headers: {'authorization': 'Bearer ${session.accessToken}'},
      ),
    );
    expect(
      (jsonDecode(await assignees.readAsString())
              as Map<String, dynamic>)['assignees']
          as List<dynamic>,
      hasLength(1),
    );

    final history = await handler(
      Request(
        'GET',
        Uri.parse('http://localhost${KanbanApiRoutes.taskHistory(task.id)}'),
        headers: {'authorization': 'Bearer ${session.accessToken}'},
      ),
    );
    final historyItems =
        (jsonDecode(await history.readAsString())
                as Map<String, dynamic>)['history']
            as List<dynamic>;
    expect(historyItems.length, greaterThanOrEqualTo(3));

    final deleteComment = await handler(
      Request(
        'DELETE',
        Uri.parse('http://localhost${KanbanApiRoutes.comment(comment.id)}'),
        headers: {'authorization': 'Bearer ${session.accessToken}'},
      ),
    );
    expect(deleteComment.statusCode, 200);
  });
}

Handler _handler() => createServerHandler(
  authService: AuthService(
    repository: InMemoryAuthRepository(),
    passwordHasher: const PasswordHasher(),
    jwtService: const JwtService(
      secret: 'test-secret',
      accessTokenTtl: Duration(minutes: 30),
    ),
    refreshTokenTtl: const Duration(days: 30),
  ),
  workspaceRepository: InMemoryWorkspaceRepository(),
  boardDataRepository: InMemoryBoardDataRepository(),
  taskDataRepository: InMemoryTaskDataRepository(),
);

Request _jsonRequest(
  String method,
  String path,
  Map<String, Object?> body, {
  String? accessToken,
}) {
  return Request(
    method,
    Uri.parse('http://localhost$path'),
    headers: {
      'content-type': 'application/json',
      if (accessToken != null) 'authorization': 'Bearer $accessToken',
    },
    body: jsonEncode(body),
  );
}

Future<AuthSessionDto> _register(Handler handler) async {
  final response = await handler(
    _jsonRequest(
      'POST',
      KanbanApiRoutes.authRegister,
      {
        'email': 'member@example.com',
        'password': 'secret1',
        'displayName': 'Member',
      },
    ),
  );
  return AuthSessionDto.fromJson(
    jsonDecode(await response.readAsString()) as Map<String, dynamic>,
  );
}

Future<BoardDto> _createBoard(Handler handler, AuthSessionDto session) async {
  final response = await handler(
    _jsonRequest(
      'POST',
      KanbanApiRoutes.boards,
      {'title': 'Roadmap'},
      accessToken: session.accessToken,
    ),
  );
  return BoardDto.fromJson(
    jsonDecode(await response.readAsString()) as Map<String, dynamic>,
  );
}

Future<TaskDto> _createTask(
  Handler handler,
  AuthSessionDto session,
  String boardId,
) async {
  final response = await handler(
    _jsonRequest(
      'POST',
      KanbanApiRoutes.tasks,
      {
        'id': '019e939d-0000-7000-8000-000000000001',
        'boardId': boardId,
        'title': 'Server task',
        'position': 0,
        'createdAt': DateTime.now().toUtc().toIso8601String(),
        'updatedAt': DateTime.now().toUtc().toIso8601String(),
      },
      accessToken: session.accessToken,
    ),
  );
  return TaskDto.fromJson(
    jsonDecode(await response.readAsString()) as Map<String, dynamic>,
  );
}
