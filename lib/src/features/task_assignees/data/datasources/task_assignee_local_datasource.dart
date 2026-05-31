import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';

abstract interface class TaskAssigneeLocalDataSource {
  Stream<List<TaskAssigneesTableData>> watchByTask(String taskId);

  Future<List<TaskAssigneesTableData>> getByTask(String taskId);

  Future<List<TaskAssigneesTableData>> getByUser(String userId);

  Future<TaskAssigneesTableData?> get({
    required String taskId,
    required String userId,
  });

  Future<void> upsert(TaskAssigneesTableCompanion assignee);

  Future<void> delete({
    required String taskId,
    required String userId,
  });
}

final class DriftTaskAssigneeLocalDataSource
    implements TaskAssigneeLocalDataSource {
  const DriftTaskAssigneeLocalDataSource(this._database);

  final AppDatabase _database;

  @override
  Stream<List<TaskAssigneesTableData>> watchByTask(String taskId) {
    return (_database.select(
      _database.taskAssigneesTable,
    )..where((table) => table.taskId.equals(taskId))).watch();
  }

  @override
  Future<List<TaskAssigneesTableData>> getByTask(String taskId) {
    return (_database.select(
      _database.taskAssigneesTable,
    )..where((table) => table.taskId.equals(taskId))).get();
  }

  @override
  Future<List<TaskAssigneesTableData>> getByUser(String userId) {
    return (_database.select(
      _database.taskAssigneesTable,
    )..where((table) => table.userId.equals(userId))).get();
  }

  @override
  Future<TaskAssigneesTableData?> get({
    required String taskId,
    required String userId,
  }) {
    return (_database.select(_database.taskAssigneesTable)..where(
          (table) => table.taskId.equals(taskId) & table.userId.equals(userId),
        ))
        .getSingleOrNull();
  }

  @override
  Future<void> upsert(TaskAssigneesTableCompanion assignee) {
    return _database
        .into(_database.taskAssigneesTable)
        .insertOnConflictUpdate(assignee);
  }

  @override
  Future<void> delete({
    required String taskId,
    required String userId,
  }) {
    return (_database.delete(_database.taskAssigneesTable)..where(
          (table) => table.taskId.equals(taskId) & table.userId.equals(userId),
        ))
        .go();
  }
}
