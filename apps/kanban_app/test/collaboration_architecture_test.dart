import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board/src/core/database/app_database.dart';
import 'package:kanban_board/src/core/error/failure.dart';
import 'package:kanban_board/src/core/error/result.dart';
import 'package:kanban_board/src/core/storage/secure_storage.dart';
import 'package:kanban_board/src/core/sync/realtime_service.dart';
import 'package:kanban_board/src/core/sync/sync_outbox.dart';
import 'package:kanban_board/src/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:kanban_board/src/features/auth/data/dto/auth_credentials_dto.dart';
import 'package:kanban_board/src/features/auth/data/dto/registration_dto.dart';
import 'package:kanban_board/src/features/board_members/data/datasources/board_member_local_datasource.dart';
import 'package:kanban_board/src/features/board_members/data/repositories/default_board_member_repository.dart';
import 'package:kanban_board/src/features/boards/data/datasources/board_local_datasource.dart';
import 'package:kanban_board/src/features/boards/domain/entities/board_entity.dart';
import 'package:kanban_board/src/features/comments/data/datasources/task_comment_local_datasource.dart';
import 'package:kanban_board/src/features/comments/data/datasources/task_comment_remote_datasource.dart';
import 'package:kanban_board/src/features/comments/data/repositories/default_task_comment_repository.dart';
import 'package:kanban_board/src/features/comments/domain/entities/task_comment_entity.dart';
import 'package:kanban_board/src/features/invitations/data/datasources/invitation_local_datasource.dart';
import 'package:kanban_board/src/features/invitations/data/repositories/default_invitation_repository.dart';
import 'package:kanban_board/src/features/invitations/domain/entities/invitation_entity.dart';
import 'package:kanban_board/src/features/permissions/data/repositories/default_permission_repository.dart';
import 'package:kanban_board/src/features/permissions/domain/entities/permission.dart';
import 'package:kanban_board/src/features/task_assignees/data/datasources/task_assignee_local_datasource.dart';
import 'package:kanban_board/src/features/task_assignees/data/datasources/task_assignee_remote_datasource.dart';
import 'package:kanban_board/src/features/task_assignees/data/repositories/default_task_assignee_repository.dart';
import 'package:kanban_board/src/features/tasks/data/datasources/task_history_local_datasource.dart';
import 'package:kanban_board/src/features/users/data/datasources/user_local_datasource.dart';
import 'package:uuid/uuid.dart';

void main() {
  late AppDatabase database;
  late MockRealtimeService realtime;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    realtime = MockRealtimeService();
  });

  tearDown(() async {
    await realtime.dispose();
    await database.close();
  });

  test('local auth stores password hash, not plaintext password', () async {
    final auth = LocalAuthRemoteDataSource(
      storage: _MemorySecureStorage(),
      userLocalDataSource: DriftUserLocalDataSource(database),
      uuid: const Uuid(),
    );

    await auth.register(
      const RegistrationDto(
        email: 'owner@example.com',
        password: 'super-secret',
        displayName: 'Owner',
      ),
    );

    final user = await DriftUserLocalDataSource(
      database,
    ).getByEmail('owner@example.com');
    expect(user, isNotNull);
    expect(user!.passwordHash, isNot('super-secret'));
    expect(user.passwordSalt, isNotEmpty);

    final session = await auth.signIn(
      const AuthCredentialsDto(
        email: 'owner@example.com',
        password: 'super-secret',
      ),
    );
    expect(session.accessToken, startsWith('local-access-'));
  });

  test('role permission matrix enforces board capabilities', () async {
    await _seedBoard(database);
    await _addBoardMember(database, userId: 'editor', role: BoardRole.editor);
    await _addBoardMember(
      database,
      userId: 'commenter',
      role: BoardRole.commenter,
    );
    await _addBoardMember(database, userId: 'viewer', role: BoardRole.viewer);
    final permissions = DefaultPermissionRepository(database);

    expect(
      await permissions.hasBoardPermission(
        userId: 'editor',
        boardId: 'board-1',
        permission: Permission.editTask,
      ),
      isTrue,
    );
    expect(
      await permissions.hasBoardPermission(
        userId: 'editor',
        boardId: 'board-1',
        permission: Permission.manageBoard,
      ),
      isFalse,
    );
    expect(
      await permissions.hasBoardPermission(
        userId: 'commenter',
        boardId: 'board-1',
        permission: Permission.commentTask,
      ),
      isTrue,
    );
    expect(
      await permissions.hasBoardPermission(
        userId: 'viewer',
        boardId: 'board-1',
        permission: Permission.commentTask,
      ),
      isFalse,
    );
  });

  test('duplicate pending invitation is rejected', () async {
    final repo = DefaultInvitationRepository(
      database: database,
      localDataSource: DriftInvitationLocalDataSource(database),
      realtimeService: realtime,
    );
    final now = DateTime.now().toUtc();
    final invitation = InvitationEntity(
      id: 'invite-1',
      email: 'member@example.com',
      boardId: 'board-1',
      role: BoardRole.editor.name,
      token: 'token-1',
      invitedBy: 'owner',
      expiresAt: now.add(const Duration(days: 7)),
      createdAt: now,
    );

    expect(await repo.create(invitation), isA<Success<InvitationEntity>>());
    final duplicate = await repo.create(
      invitation.copyWith(id: 'invite-2', token: 'token-2'),
    );

    expect(duplicate, isA<Error<InvitationEntity>>());
    expect(
      (duplicate as Error<InvitationEntity>).failure,
      isA<ValidationFailure>(),
    );
  });

  test('cannot remove last board admin', () async {
    await _seedBoard(database);
    final repo = DefaultBoardMemberRepository(
      DriftBoardMemberLocalDataSource(database),
    );

    final result = await repo.remove(
      boardId: 'board-1',
      userId: 'owner',
      actorUserId: 'owner',
    );

    expect(result, isA<Error<void>>());
  });

  test('board list only includes owned or invited boards', () async {
    final dataSource = DriftBoardLocalDataSource(database);
    final now = DateTime.utc(2026, 5, 28);
    await dataSource.save(
      BoardEntity(
        id: 'owner-board',
        ownerId: 'owner',
        title: 'Owner board',
        createdAt: now,
        updatedAt: now,
      ),
    );
    await dataSource.save(
      BoardEntity(
        id: 'other-board',
        ownerId: 'other',
        title: 'Other board',
        createdAt: now,
        updatedAt: now,
      ),
    );

    var visible = await dataSource.watchVisibleToUser('owner').first;
    expect(visible.map((board) => board.id), ['owner-board']);

    await _addBoardMember(
      database,
      boardId: 'other-board',
      userId: 'owner',
      role: BoardRole.viewer,
    );
    visible = await dataSource.watchVisibleToUser('owner').first;
    expect(visible.map((board) => board.id).toSet(), {
      'owner-board',
      'other-board',
    });
  });

  test('cannot assign task to user outside board and workspace', () async {
    await _seedBoard(database);
    await _seedTask(database);
    final repo = DefaultTaskAssigneeRepository(
      database: database,
      localDataSource: DriftTaskAssigneeLocalDataSource(database),
      remoteDataSource: const MockTaskAssigneeRemoteDataSource(),
      historyLocalDataSource: DriftTaskHistoryLocalDataSource(database),
      permissionRepository: DefaultPermissionRepository(database),
      realtimeService: realtime,
      uuid: const Uuid(),
    );

    final result = await repo.assign(
      taskId: 'task-1',
      userId: 'outsider',
      assignedBy: 'owner',
    );

    expect(result, isA<Error<void>>());
  });

  test('comment edit/delete allowed for author or admin only', () async {
    await _seedBoard(database);
    await _seedTask(database);
    await _addBoardMember(
      database,
      userId: 'commenter',
      role: BoardRole.commenter,
    );
    await _addBoardMember(database, userId: 'viewer', role: BoardRole.viewer);
    final repo = DefaultTaskCommentRepository(
      database: database,
      localDataSource: DriftTaskCommentLocalDataSource(database),
      remoteDataSource: const MockTaskCommentRemoteDataSource(),
      historyLocalDataSource: DriftTaskHistoryLocalDataSource(database),
      permissionRepository: DefaultPermissionRepository(database),
      realtimeService: realtime,
      syncOutbox: MemorySyncOutbox(),
      uuid: const Uuid(),
    );

    final created = await repo.create(
      taskId: 'task-1',
      authorId: 'commenter',
      content: 'Looks good',
    );
    final comment = (created as Success).value as TaskCommentEntity;

    expect(
      await repo.update(
        id: comment.id,
        actorUserId: 'viewer',
        content: 'Nope',
      ),
      isA<Error<TaskCommentEntity>>(),
    );
    expect(
      await repo.delete(id: comment.id, actorUserId: 'owner'),
      isA<Success<void>>(),
    );
  });
}

Future<void> _seedBoard(AppDatabase database) async {
  final now = DateTime.utc(2026, 5, 28);
  await database
      .into(database.workspacesTable)
      .insert(
        WorkspacesTableCompanion.insert(
          id: 'workspace-1',
          name: 'Workspace',
          ownerId: 'owner',
          createdAt: now,
          updatedAt: now,
        ),
      );
  await database
      .into(database.workspaceMembersTable)
      .insert(
        WorkspaceMembersTableCompanion.insert(
          id: 'workspace-1:owner',
          workspaceId: 'workspace-1',
          userId: 'owner',
          role: WorkspaceRole.owner.name,
          joinedAt: now,
        ),
      );
  await database
      .into(database.boardsTable)
      .insert(
        BoardsTableCompanion.insert(
          id: 'board-1',
          ownerId: 'owner',
          workspaceId: const Value('workspace-1'),
          title: 'Board',
          createdAt: now,
          updatedAt: now,
        ),
      );
  await _addBoardMember(database, userId: 'owner', role: BoardRole.admin);
}

Future<void> _seedTask(AppDatabase database) {
  final now = DateTime.utc(2026, 5, 28);
  return database
      .into(database.tasksTable)
      .insert(
        TasksTableCompanion.insert(
          id: 'task-1',
          boardId: 'board-1',
          title: 'Task',
          position: 0,
          createdAt: now,
          updatedAt: now,
        ),
      );
}

Future<void> _addBoardMember(
  AppDatabase database, {
  String boardId = 'board-1',
  required String userId,
  required BoardRole role,
}) {
  return database
      .into(database.boardMembersTable)
      .insertOnConflictUpdate(
        BoardMembersTableCompanion.insert(
          id: '$boardId:$userId',
          boardId: boardId,
          userId: userId,
          role: role.name,
          joinedAt: DateTime.utc(2026, 5, 28),
        ),
      );
}

final class _MemorySecureStorage implements SecureStorage {
  final _values = <String, String>{};

  @override
  Future<void> delete(String key) async {
    _values.remove(key);
  }

  @override
  Future<String?> read(String key) async => _values[key];

  @override
  Future<void> write({required String key, required String value}) async {
    _values[key] = value;
  }
}
