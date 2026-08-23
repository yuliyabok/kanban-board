import '../../../../core/error/result.dart';
import '../entities/workspace_entity.dart';

abstract interface class WorkspaceRepository {
  Stream<List<WorkspaceEntity>> watchAll();

  Future<Result<List<WorkspaceEntity>>> getAll();

  Future<Result<WorkspaceEntity>> create({
    required String name,
    required String ownerId,
  });
}

abstract interface class WorkspaceMemberRepository {
  Stream<List<WorkspaceMemberEntity>> watchByWorkspace(String workspaceId);

  Future<Result<List<WorkspaceMemberEntity>>> getByWorkspace(
    String workspaceId,
  );

  Future<Result<WorkspaceMemberEntity>> add(WorkspaceMemberEntity member);

  Future<Result<WorkspaceMemberEntity>> updateRole({
    required String workspaceId,
    required String userId,
    required WorkspaceMemberEntity member,
    required String actorUserId,
  });

  Future<Result<void>> remove({
    required String workspaceId,
    required String userId,
    required String actorUserId,
  });
}
