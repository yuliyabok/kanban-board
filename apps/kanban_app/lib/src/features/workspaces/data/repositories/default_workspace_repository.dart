import 'package:uuid/uuid.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../../permissions/domain/entities/permission.dart';
import '../../domain/entities/workspace_entity.dart';
import '../../domain/repositories/workspace_repository.dart';
import '../datasources/workspace_local_datasource.dart';
import '../datasources/workspace_remote_datasource.dart';
import '../dto/workspace_dto.dart';
import '../mappers/workspace_mapper.dart';

final class DefaultWorkspaceRepository implements WorkspaceRepository {
  const DefaultWorkspaceRepository({
    required WorkspaceLocalDataSource localDataSource,
    required WorkspaceMemberLocalDataSource memberLocalDataSource,
    required Uuid uuid,
    WorkspaceRemoteDataSource? remoteDataSource,
    bool usesServerRemote = false,
  }) : _localDataSource = localDataSource,
       _memberLocalDataSource = memberLocalDataSource,
       _uuid = uuid,
       _remoteDataSource = remoteDataSource,
       _usesServerRemote = usesServerRemote;

  final WorkspaceLocalDataSource _localDataSource;
  final WorkspaceMemberLocalDataSource _memberLocalDataSource;
  final Uuid _uuid;
  final WorkspaceRemoteDataSource? _remoteDataSource;
  final bool _usesServerRemote;

  @override
  Stream<List<WorkspaceEntity>> watchAll() {
    return _localDataSource.watchAll().map(
      (rows) => rows.map((row) => row.toEntity()).toList(growable: false),
    );
  }

  @override
  Future<Result<List<WorkspaceEntity>>> getAll() async {
    try {
      if (_usesServerRemote && _remoteDataSource != null) {
        final remoteWorkspaces = await _remoteDataSource.getAll();
        for (final workspace in remoteWorkspaces) {
          await _localDataSource.upsert(
            workspace.toEntity().toCompanion(syncAction: null),
          );
          final members = await _remoteDataSource.getMembers(workspace.id);
          for (final member in members) {
            await _memberLocalDataSource.upsert(
              member.toEntity().toCompanion(syncAction: null),
            );
          }
        }
        return Success(
          remoteWorkspaces
              .map((workspace) => workspace.toEntity())
              .toList(growable: false),
        );
      }

      final rows = await _localDataSource.getAll();
      return Success(rows.map((row) => row.toEntity()).toList(growable: false));
    } on Exception catch (error) {
      return Error(StorageFailure(error.toString()));
    }
  }

  @override
  Future<Result<WorkspaceEntity>> create({
    required String name,
    required String ownerId,
  }) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) {
      return const Error(ValidationFailure('Название workspace не пустое'));
    }

    try {
      final now = DateTime.now().toUtc();
      final workspace = WorkspaceEntity(
        id: _uuid.v7(),
        name: trimmed,
        ownerId: ownerId,
        createdAt: now,
        updatedAt: now,
      );
      await _localDataSource.upsert(
        workspace.toCompanion(syncAction: 'create'),
      );
      await _memberLocalDataSource.upsert(
        WorkspaceMemberEntity(
          id: '${workspace.id}:$ownerId',
          workspaceId: workspace.id,
          userId: ownerId,
          role: WorkspaceRole.owner,
          joinedAt: now,
        ).toCompanion(syncAction: 'create'),
      );
      if (_usesServerRemote && _remoteDataSource != null) {
        final remote = await _remoteDataSource.create(workspace.toDto());
        await _localDataSource.upsert(
          remote.toEntity().toCompanion(syncAction: null),
        );
        final members = await _remoteDataSource.getMembers(remote.id);
        for (final member in members) {
          await _memberLocalDataSource.upsert(
            member.toEntity().toCompanion(syncAction: null),
          );
        }
        return Success(remote.toEntity());
      }
      return Success(workspace);
    } on Exception catch (error) {
      return Error(StorageFailure(error.toString()));
    }
  }
}

final class DefaultWorkspaceMemberRepository
    implements WorkspaceMemberRepository {
  const DefaultWorkspaceMemberRepository(
    this._localDataSource, {
    WorkspaceRemoteDataSource? remoteDataSource,
    bool usesServerRemote = false,
  }) : _remoteDataSource = remoteDataSource,
       _usesServerRemote = usesServerRemote;

  final WorkspaceMemberLocalDataSource _localDataSource;
  final WorkspaceRemoteDataSource? _remoteDataSource;
  final bool _usesServerRemote;

  @override
  Stream<List<WorkspaceMemberEntity>> watchByWorkspace(String workspaceId) {
    return _localDataSource
        .watchByWorkspace(workspaceId)
        .map(
          (rows) => rows.map((row) => row.toEntity()).toList(growable: false),
        );
  }

  @override
  Future<Result<List<WorkspaceMemberEntity>>> getByWorkspace(
    String workspaceId,
  ) async {
    try {
      if (_usesServerRemote && _remoteDataSource != null) {
        final remoteMembers = await _remoteDataSource.getMembers(workspaceId);
        for (final member in remoteMembers) {
          await _localDataSource.upsert(
            member.toEntity().toCompanion(syncAction: null),
          );
        }
        return Success(
          remoteMembers
              .map((member) => member.toEntity())
              .toList(growable: false),
        );
      }

      final rows = await _localDataSource.getByWorkspace(workspaceId);
      return Success(rows.map((row) => row.toEntity()).toList(growable: false));
    } on Exception catch (error) {
      return Error(StorageFailure(error.toString()));
    }
  }

  @override
  Future<Result<WorkspaceMemberEntity>> add(
    WorkspaceMemberEntity member,
  ) async {
    try {
      await _localDataSource.upsert(member.toCompanion(syncAction: 'create'));
      return Success(member);
    } on Exception catch (error) {
      return Error(StorageFailure(error.toString()));
    }
  }

  @override
  Future<Result<void>> remove({
    required String workspaceId,
    required String userId,
    required String actorUserId,
  }) async {
    try {
      final members = (await _localDataSource.getByWorkspace(
        workspaceId,
      )).map((row) => row.toEntity()).toList(growable: false);
      final actor = members
          .where((member) => member.userId == actorUserId)
          .firstOrNull;
      if (actor == null || !_canManage(actor.role)) {
        return const Error(ValidationFailure('Недостаточно прав'));
      }
      final target = members
          .where((member) => member.userId == userId)
          .firstOrNull;
      if (target == null) return const Success(null);
      if (_isLastWorkspaceAdmin(target, members)) {
        return const Error(
          ValidationFailure('Нельзя удалить последнего owner/admin'),
        );
      }
      await _localDataSource.delete(workspaceId: workspaceId, userId: userId);
      return const Success(null);
    } on Exception catch (error) {
      return Error(StorageFailure(error.toString()));
    }
  }

  @override
  Future<Result<WorkspaceMemberEntity>> updateRole({
    required String workspaceId,
    required String userId,
    required WorkspaceMemberEntity member,
    required String actorUserId,
  }) async {
    try {
      final members = (await _localDataSource.getByWorkspace(
        workspaceId,
      )).map((row) => row.toEntity()).toList(growable: false);
      final actor = members
          .where((item) => item.userId == actorUserId)
          .firstOrNull;
      if (actor == null || !_canManage(actor.role)) {
        return const Error(ValidationFailure('Недостаточно прав'));
      }
      final existing = members
          .where((item) => item.userId == userId)
          .firstOrNull;
      if (existing != null && _isLastWorkspaceAdmin(existing, members)) {
        return const Error(
          ValidationFailure('Нельзя изменить последнего owner/admin'),
        );
      }
      final updated = member.copyWith(joinedAt: existing?.joinedAt);
      await _localDataSource.upsert(updated.toCompanion(syncAction: 'update'));
      return Success(updated);
    } on Exception catch (error) {
      return Error(StorageFailure(error.toString()));
    }
  }

  bool _canManage(WorkspaceRole role) =>
      role == WorkspaceRole.owner || role == WorkspaceRole.admin;

  bool _isLastWorkspaceAdmin(
    WorkspaceMemberEntity target,
    List<WorkspaceMemberEntity> members,
  ) {
    if (!_canManage(target.role)) return false;
    final admins = members.where((member) => _canManage(member.role)).length;
    return admins <= 1;
  }
}
