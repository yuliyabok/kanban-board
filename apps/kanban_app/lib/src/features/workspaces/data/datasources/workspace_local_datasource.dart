import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';

abstract interface class WorkspaceLocalDataSource {
  Stream<List<WorkspacesTableData>> watchAll();

  Future<List<WorkspacesTableData>> getAll();

  Future<void> upsert(WorkspacesTableCompanion workspace);
}

abstract interface class WorkspaceMemberLocalDataSource {
  Stream<List<WorkspaceMembersTableData>> watchByWorkspace(String workspaceId);

  Future<List<WorkspaceMembersTableData>> getByWorkspace(String workspaceId);

  Future<WorkspaceMembersTableData?> getByUser({
    required String workspaceId,
    required String userId,
  });

  Future<void> upsert(WorkspaceMembersTableCompanion member);

  Future<void> delete({
    required String workspaceId,
    required String userId,
  });
}

final class DriftWorkspaceLocalDataSource implements WorkspaceLocalDataSource {
  const DriftWorkspaceLocalDataSource(this._database);

  final AppDatabase _database;

  @override
  Stream<List<WorkspacesTableData>> watchAll() =>
      _database.select(_database.workspacesTable).watch();

  @override
  Future<List<WorkspacesTableData>> getAll() =>
      _database.select(_database.workspacesTable).get();

  @override
  Future<void> upsert(WorkspacesTableCompanion workspace) {
    return _database
        .into(_database.workspacesTable)
        .insertOnConflictUpdate(workspace);
  }
}

final class DriftWorkspaceMemberLocalDataSource
    implements WorkspaceMemberLocalDataSource {
  const DriftWorkspaceMemberLocalDataSource(this._database);

  final AppDatabase _database;

  @override
  Stream<List<WorkspaceMembersTableData>> watchByWorkspace(String workspaceId) {
    return (_database.select(
      _database.workspaceMembersTable,
    )..where((table) => table.workspaceId.equals(workspaceId))).watch();
  }

  @override
  Future<List<WorkspaceMembersTableData>> getByWorkspace(String workspaceId) {
    return (_database.select(
      _database.workspaceMembersTable,
    )..where((table) => table.workspaceId.equals(workspaceId))).get();
  }

  @override
  Future<WorkspaceMembersTableData?> getByUser({
    required String workspaceId,
    required String userId,
  }) {
    return (_database.select(_database.workspaceMembersTable)..where(
          (table) =>
              table.workspaceId.equals(workspaceId) &
              table.userId.equals(userId),
        ))
        .getSingleOrNull();
  }

  @override
  Future<void> upsert(WorkspaceMembersTableCompanion member) {
    return _database
        .into(_database.workspaceMembersTable)
        .insertOnConflictUpdate(member);
  }

  @override
  Future<void> delete({
    required String workspaceId,
    required String userId,
  }) {
    return (_database.delete(_database.workspaceMembersTable)..where(
          (table) =>
              table.workspaceId.equals(workspaceId) &
              table.userId.equals(userId),
        ))
        .go();
  }
}
