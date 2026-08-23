// In-memory workspace repository для server tests.
import 'package:kanban_contracts/kanban_contracts.dart';
import 'package:kanban_server/src/http/api_exception.dart';
import 'package:kanban_server/src/workspaces/workspace_repository.dart';
import 'package:uuid/uuid.dart';

final class InMemoryWorkspaceRepository implements WorkspaceRepository {
  InMemoryWorkspaceRepository({Uuid uuid = const Uuid()}) : _uuid = uuid;

  final Uuid _uuid;
  final _workspaces = <String, WorkspaceDto>{};
  final _members = <String, WorkspaceMemberDto>{};

  @override
  Future<WorkspaceDto> create({
    required String name,
    required String ownerId,
  }) async {
    final now = DateTime.now().toUtc();
    final workspace = WorkspaceDto(
      id: _uuid.v7(),
      name: name.trim(),
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
    _workspaces[workspace.id] = workspace;
    _members[member.id] = member;
    return workspace;
  }

  @override
  Future<List<WorkspaceDto>> listForUser(String userId) async {
    final workspaceIds = _members.values
        .where((member) => member.userId == userId)
        .map((member) => member.workspaceId)
        .toSet();
    return _workspaces.values
        .where((workspace) => workspaceIds.contains(workspace.id))
        .toList(growable: false);
  }

  @override
  Future<List<WorkspaceMemberDto>> listMembers({
    required String workspaceId,
    required String actorUserId,
  }) async {
    final isMember = _members.values.any(
      (member) =>
          member.workspaceId == workspaceId && member.userId == actorUserId,
    );
    if (!isMember) {
      throw const ApiException(
        statusCode: 403,
        code: 'workspace_forbidden',
        message: 'Нет доступа к workspace',
      );
    }
    return _members.values
        .where((member) => member.workspaceId == workspaceId)
        .toList(growable: false);
  }
}
