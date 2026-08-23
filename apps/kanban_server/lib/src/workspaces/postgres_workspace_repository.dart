// PostgreSQL-реализация workspaces repository.
import 'package:kanban_contracts/kanban_contracts.dart';
import 'package:kanban_server/src/database/postgres_database.dart';
import 'package:kanban_server/src/http/api_exception.dart';
import 'package:kanban_server/src/workspaces/workspace_repository.dart';
import 'package:uuid/uuid.dart';

final class PostgresWorkspaceRepository implements WorkspaceRepository {
  const PostgresWorkspaceRepository(
    this._database, {
    Uuid uuid = const Uuid(),
  }) : _uuid = uuid;

  final PostgresDatabase _database;
  final Uuid _uuid;

  @override
  Future<WorkspaceDto> create({
    required String name,
    required String ownerId,
  }) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) {
      throw const ApiException(
        statusCode: 400,
        code: 'invalid_workspace_name',
        message: 'Название workspace не пустое',
      );
    }

    final now = DateTime.now().toUtc();
    final workspace = WorkspaceDto(
      id: _uuid.v7(),
      name: trimmed,
      ownerId: ownerId,
      createdAt: now,
      updatedAt: now,
    );
    final member = WorkspaceMemberDto(
      id: '${workspace.id}:$ownerId',
      workspaceId: workspace.id,
      userId: ownerId,
      role: 'owner',
      joinedAt: now,
    );

    await _database.execute(
      '''
      INSERT INTO workspaces (id, name, owner_id, created_at, updated_at)
      VALUES (@id:uuid, @name, @ownerId:uuid, @createdAt, @updatedAt)
      ''',
      parameters: {
        'id': workspace.id,
        'name': workspace.name,
        'ownerId': workspace.ownerId,
        'createdAt': workspace.createdAt,
        'updatedAt': workspace.updatedAt,
      },
      ignoreRows: true,
    );
    await _database.execute(
      '''
      INSERT INTO workspace_members (
        id, workspace_id, user_id, role, joined_at
      ) VALUES (
        @id, @workspaceId:uuid, @userId:uuid, @role, @joinedAt
      )
      ''',
      parameters: {
        'id': member.id,
        'workspaceId': member.workspaceId,
        'userId': member.userId,
        'role': member.role,
        'joinedAt': member.joinedAt,
      },
      ignoreRows: true,
    );

    return workspace;
  }

  @override
  Future<List<WorkspaceDto>> listForUser(String userId) async {
    final result = await _database.execute(
      '''
      SELECT DISTINCT w.*
      FROM workspaces w
      INNER JOIN workspace_members wm ON wm.workspace_id = w.id
      WHERE wm.user_id = @userId:uuid
      ORDER BY w.created_at DESC
      ''',
      parameters: {'userId': userId},
    );
    return result
        .map((row) => _workspaceFromRow(row.toColumnMap()))
        .toList(growable: false);
  }

  @override
  Future<List<WorkspaceMemberDto>> listMembers({
    required String workspaceId,
    required String actorUserId,
  }) async {
    final access = await _database.execute(
      '''
      SELECT 1
      FROM workspace_members
      WHERE workspace_id = @workspaceId:uuid AND user_id = @actorUserId:uuid
      LIMIT 1
      ''',
      parameters: {
        'workspaceId': workspaceId,
        'actorUserId': actorUserId,
      },
    );
    if (access.isEmpty) {
      throw const ApiException(
        statusCode: 403,
        code: 'workspace_forbidden',
        message: 'Нет доступа к workspace',
      );
    }

    final result = await _database.execute(
      '''
      SELECT *
      FROM workspace_members
      WHERE workspace_id = @workspaceId:uuid
      ORDER BY joined_at ASC
      ''',
      parameters: {'workspaceId': workspaceId},
    );
    return result
        .map((row) => _memberFromRow(row.toColumnMap()))
        .toList(growable: false);
  }

  WorkspaceDto _workspaceFromRow(Map<String, dynamic> row) {
    return WorkspaceDto(
      id: row['id'].toString(),
      name: row['name'] as String,
      ownerId: row['owner_id'].toString(),
      createdAt: (row['created_at'] as DateTime).toUtc(),
      updatedAt: (row['updated_at'] as DateTime).toUtc(),
    );
  }

  WorkspaceMemberDto _memberFromRow(Map<String, dynamic> row) {
    return WorkspaceMemberDto(
      id: row['id'] as String,
      workspaceId: row['workspace_id'].toString(),
      userId: row['user_id'].toString(),
      role: row['role'] as String,
      joinedAt: (row['joined_at'] as DateTime).toUtc(),
    );
  }
}
