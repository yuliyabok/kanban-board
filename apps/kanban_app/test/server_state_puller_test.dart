// Проверяет первый слой входящей server-mode синхронизации: данные с backend
// применяются в локальный Drift-кеш, из которого уже читает UI.
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board/src/core/database/app_database.dart';
import 'package:kanban_board/src/core/network/api_client.dart';
import 'package:kanban_board/src/core/network/api_endpoints.dart';
import 'package:kanban_board/src/core/sync/server_state_puller.dart';

void main() {
  test(
    'pulls ready server entities into Drift',
    () async {
      final database = AppDatabase(NativeDatabase.memory());
      addTearDown(database.close);

      await ServerStatePuller(
        database: database,
        apiClient: _FakeApiClient(),
      ).pull();

      expect(await database.select(database.boardsTable).get(), hasLength(1));
      expect(
        await database.select(database.workspacesTable).get(),
        hasLength(1),
      );
      expect(
        await database.select(database.workspaceMembersTable).get(),
        hasLength(1),
      );
      expect(
        await database.select(database.boardMembersTable).get(),
        hasLength(1),
      );
      expect(
        await database.select(database.taskTypesTable).get(),
        hasLength(1),
      );
      expect(await database.select(database.tasksTable).get(), hasLength(1));
      expect(
        await database.select(database.taskCommentsTable).get(),
        hasLength(1),
      );
      expect(
        await database.select(database.taskAssigneesTable).get(),
        hasLength(1),
      );
      expect(
        await database.select(database.taskHistoryTable).get(),
        hasLength(1),
      );

      final task = await database.select(database.tasksTable).getSingle();
      expect(task.title, 'Server task');
      expect(task.isSynced, isTrue);
      expect(task.syncAction, isNull);
    },
  );
}

final class _FakeApiClient implements ApiClient {
  static final _now = DateTime.utc(2026, 6, 4, 12).toIso8601String();

  @override
  Future<Map<String, dynamic>> getJson(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    if (path == ApiEndpoints.boards) {
      return {
        'boards': [
          {
            'id': 'board-1',
            'ownerId': 'user-1',
            'title': 'Server board',
            'createdAt': _now,
            'updatedAt': _now,
          },
        ],
      };
    }

    if (path == ApiEndpoints.workspaces) {
      return {
        'workspaces': [
          {
            'id': 'workspace-1',
            'name': 'Server workspace',
            'ownerId': 'user-1',
            'createdAt': _now,
            'updatedAt': _now,
          },
        ],
      };
    }

    if (path == ApiEndpoints.workspaceMembers('workspace-1')) {
      return {
        'members': [
          {
            'id': 'workspace-1:user-1',
            'workspaceId': 'workspace-1',
            'userId': 'user-1',
            'role': 'owner',
            'joinedAt': _now,
          },
        ],
      };
    }

    if (path == ApiEndpoints.boardMembers('board-1')) {
      return {
        'members': [
          {
            'id': 'board-1:user-1',
            'boardId': 'board-1',
            'userId': 'user-1',
            'role': 'admin',
            'joinedAt': _now,
          },
        ],
      };
    }

    if (path == ApiEndpoints.taskTypes) {
      expect(queryParameters?['boardId'], 'board-1');
      return {
        'taskTypes': [
          {
            'id': 'type-1',
            'boardId': 'board-1',
            'name': 'Feature',
            'color': 'blue',
            'icon': 'sparkles',
            'createdAt': _now,
            'updatedAt': _now,
          },
        ],
      };
    }

    if (path == ApiEndpoints.usersSearch) {
      return {
        'users': [
          {
            'id': 'user-1',
            'email': 'member@example.com',
            'fullName': 'Member Example',
            'createdAt': _now,
            'updatedAt': _now,
          },
        ],
      };
    }

    if (path == ApiEndpoints.tasks) {
      expect(queryParameters?['boardId'], 'board-1');
      return {
        'tasks': [
          {
            'id': 'task-1',
            'boardId': 'board-1',
            'title': 'Server task',
            'position': 0,
            'createdAt': _now,
            'updatedAt': _now,
          },
        ],
      };
    }

    if (path == ApiEndpoints.taskComments('task-1')) {
      return {
        'comments': [
          {
            'id': 'comment-1',
            'taskId': 'task-1',
            'authorId': 'user-1',
            'content': 'Synced comment',
            'createdAt': _now,
            'updatedAt': _now,
          },
        ],
      };
    }

    if (path == ApiEndpoints.taskAssignees('task-1')) {
      return {
        'assignees': [
          {
            'id': 'assignee-1',
            'taskId': 'task-1',
            'userId': 'user-1',
            'assignedBy': 'user-1',
            'assignedAt': _now,
          },
        ],
      };
    }

    if (path == ApiEndpoints.taskHistory('task-1')) {
      return {
        'history': [
          {
            'id': 'history-1',
            'taskId': 'task-1',
            'boardId': 'board-1',
            'action': 'create',
            'summary': 'Задача создана',
            'actorUserId': 'user-1',
            'changedAt': _now,
          },
        ],
      };
    }

    fail('Unexpected GET $path');
  }

  @override
  Future<void> delete(String path) async {}

  @override
  Future<Map<String, dynamic>> patchJson(String path, {Object? body}) async {
    fail('Unexpected PATCH $path');
  }

  @override
  Future<Map<String, dynamic>> postJson(String path, {Object? body}) async {
    fail('Unexpected POST $path');
  }
}
