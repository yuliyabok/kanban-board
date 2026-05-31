import '../../../../core/error/result.dart';
import '../../../permissions/domain/entities/permission.dart';
import '../entities/workspace_entity.dart';
import '../repositories/workspace_repository.dart';

final class CreateWorkspaceUseCase {
  const CreateWorkspaceUseCase(this._repository);

  final WorkspaceRepository _repository;

  Future<Result<WorkspaceEntity>> call({
    required String name,
    required String ownerId,
  }) => _repository.create(name: name, ownerId: ownerId);
}

final class GetWorkspacesUseCase {
  const GetWorkspacesUseCase(this._repository);

  final WorkspaceRepository _repository;

  Future<Result<List<WorkspaceEntity>>> call() => _repository.getAll();
}

final class GetWorkspaceMembersUseCase {
  const GetWorkspaceMembersUseCase(this._repository);

  final WorkspaceMemberRepository _repository;

  Future<Result<List<WorkspaceMemberEntity>>> call(String workspaceId) =>
      _repository.getByWorkspace(workspaceId);
}

final class InviteWorkspaceMemberUseCase {
  const InviteWorkspaceMemberUseCase();
}

final class UpdateWorkspaceMemberRoleUseCase {
  const UpdateWorkspaceMemberRoleUseCase(this._repository);

  final WorkspaceMemberRepository _repository;

  Future<Result<WorkspaceMemberEntity>> call({
    required String workspaceId,
    required String userId,
    required WorkspaceRole role,
    required String actorUserId,
  }) {
    return _repository.updateRole(
      workspaceId: workspaceId,
      userId: userId,
      actorUserId: actorUserId,
      member: WorkspaceMemberEntity(
        id: '$workspaceId:$userId',
        workspaceId: workspaceId,
        userId: userId,
        role: role,
        joinedAt: DateTime.now().toUtc(),
      ),
    );
  }
}

final class RemoveWorkspaceMemberUseCase {
  const RemoveWorkspaceMemberUseCase(this._repository);

  final WorkspaceMemberRepository _repository;

  Future<Result<void>> call({
    required String workspaceId,
    required String userId,
    required String actorUserId,
  }) => _repository.remove(
    workspaceId: workspaceId,
    userId: userId,
    actorUserId: actorUserId,
  );
}
