// Тесты shared-контрактов: защищают имена JSON-полей и round-trip DTO.
import 'package:kanban_contracts/kanban_contracts.dart';
import 'package:test/test.dart';

void main() {
  test('auth contracts round-trip JSON expected by Flutter client', () {
    final credentials = AuthCredentialsDto.fromJson(
      const {'email': 'user@example.com', 'password': 'secret'},
    );
    expect(credentials.toJson(), {
      'email': 'user@example.com',
      'password': 'secret',
    });

    final registration = RegistrationDto.fromJson(
      const {
        'email': 'user@example.com',
        'password': 'secret',
        'displayName': 'User',
      },
    );
    expect(registration.toJson()['displayName'], 'User');

    final session = AuthSessionDto(
      userId: 'user-1',
      email: 'user@example.com',
      accessToken: 'access',
      refreshToken: 'refresh',
      expiresAt: DateTime.utc(2026, 6, 4, 12),
    );
    expect(AuthSessionDto.fromJson(session.toJson()).userId, 'user-1');
  });

  test('user contract does not expose password fields', () {
    final user = UserDto(
      id: 'user-1',
      email: 'user@example.com',
      fullName: 'User',
      createdAt: DateTime.utc(2026, 6, 4),
      updatedAt: DateTime.utc(2026, 6, 4),
    );

    expect(user.toJson(), isNot(contains('passwordHash')));
    expect(user.toJson(), isNot(contains('passwordSalt')));
    expect(UserDto.fromJson(user.toJson()).email, 'user@example.com');
  });

  test('workspace contracts round-trip JSON expected by Flutter client', () {
    final workspace = WorkspaceDto(
      id: 'workspace-1',
      name: 'Product',
      ownerId: 'user-1',
      createdAt: DateTime.utc(2026, 6, 4),
      updatedAt: DateTime.utc(2026, 6, 4, 1),
    );
    final member = WorkspaceMemberDto(
      id: 'workspace-1:user-1',
      workspaceId: 'workspace-1',
      userId: 'user-1',
      role: 'owner',
      joinedAt: DateTime.utc(2026, 6, 4),
    );

    expect(WorkspaceDto.fromJson(workspace.toJson()).ownerId, 'user-1');
    expect(WorkspaceMemberDto.fromJson(member.toJson()).role, 'owner');
  });

  test('board contracts round-trip JSON expected by Flutter client', () {
    final board = BoardDto(
      id: 'board-1',
      ownerId: 'user-1',
      workspaceId: 'workspace-1',
      title: 'Roadmap',
      createdAt: DateTime.utc(2026, 6, 4),
      updatedAt: DateTime.utc(2026, 6, 4, 1),
    );
    final column = BoardColumnDto(
      id: 'column-1',
      boardId: 'board-1',
      title: 'Todo',
      position: 0,
      createdAt: DateTime.utc(2026, 6, 4),
      updatedAt: DateTime.utc(2026, 6, 4),
    );
    final type = TaskTypeDto(
      id: 'type-1',
      boardId: 'board-1',
      name: 'Bug',
      color: '#ff0000',
      icon: 'bug',
      createdAt: DateTime.utc(2026, 6, 4),
      updatedAt: DateTime.utc(2026, 6, 4),
    );

    expect(BoardDto.fromJson(board.toJson()).title, 'Roadmap');
    expect(BoardColumnDto.fromJson(column.toJson()).position, 0);
    expect(TaskTypeDto.fromJson(type.toJson()).icon, 'bug');
  });

  test('task contracts round-trip JSON expected by Flutter client', () {
    final task = TaskDto(
      id: 'task-1',
      boardId: 'board-1',
      title: 'Ship it',
      position: 0,
      priority: 'high',
      labels: const ['release'],
      createdAt: DateTime.utc(2026, 6, 4),
      updatedAt: DateTime.utc(2026, 6, 4),
    );
    final comment = TaskCommentDto(
      id: 'comment-1',
      taskId: 'task-1',
      authorId: 'user-1',
      content: 'Done',
      createdAt: DateTime.utc(2026, 6, 4),
      updatedAt: DateTime.utc(2026, 6, 4),
    );
    final assignee = TaskAssigneeDto(
      id: 'assignee-1',
      taskId: 'task-1',
      userId: 'user-1',
      assignedBy: 'user-1',
      assignedAt: DateTime.utc(2026, 6, 4),
    );

    expect(TaskDto.fromJson(task.toJson()).labels, ['release']);
    expect(TaskCommentDto.fromJson(comment.toJson()).content, 'Done');
    expect(TaskAssigneeDto.fromJson(assignee.toJson()).userId, 'user-1');
  });

  test('changes summary uses stable JSON field names and UTC dates', () {
    final dto = ChangesSummaryDto(
      changedTasks: 14,
      comments: 3,
      newTasks: 2,
      overdueTasks: 1,
      since: DateTime.utc(2026, 6),
      generatedAt: DateTime.utc(2026, 6, 3, 12),
    );

    final json = dto.toJson();
    expect(json['changedTasks'], 14);
    expect(json['generatedAt'], '2026-06-03T12:00:00.000Z');
    expect(ChangesSummaryDto.fromJson(json).overdueTasks, 1);
  });

  test('sync delta round-trips history and realtime contracts', () {
    final changedAt = DateTime.utc(2026, 6, 3, 9);
    final delta = SyncDeltaDto(
      serverTime: changedAt,
      changedEntities: const [
        {'type': 'task', 'id': 'task-1', 'updatedAt': '2026-06-03T09:00:00Z'},
      ],
      deletedEntityIds: const ['task-2'],
      historyEntries: [
        TaskHistoryEntryDto(
          id: 'history-1',
          taskId: 'task-1',
          boardId: 'board-1',
          action: 'update',
          summary: 'Задача обновлена',
          actorUserId: 'user-1',
          changedAt: changedAt,
        ),
      ],
      realtimeEvents: [
        RealtimeEventDto(
          type: RealtimeEventTypes.taskUpdated,
          payload: const {'taskId': 'task-1'},
          occurredAt: changedAt,
        ),
      ],
    );

    final restored = SyncDeltaDto.fromJson(delta.toJson());
    expect(restored.deletedEntityIds, ['task-2']);
    expect(restored.historyEntries.single.actorUserId, 'user-1');
    expect(restored.realtimeEvents.single.type, RealtimeEventTypes.taskUpdated);
  });
}
