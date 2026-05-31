import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';

abstract interface class TaskCommentLocalDataSource {
  Stream<List<TaskCommentsTableData>> watchByTask(String taskId);

  Future<List<TaskCommentsTableData>> getByTask(String taskId);

  Future<TaskCommentsTableData?> getById(String id);

  Future<void> upsert(TaskCommentsTableCompanion comment);
}

final class DriftTaskCommentLocalDataSource
    implements TaskCommentLocalDataSource {
  const DriftTaskCommentLocalDataSource(this._database);

  final AppDatabase _database;

  @override
  Stream<List<TaskCommentsTableData>> watchByTask(String taskId) {
    return (_database.select(_database.taskCommentsTable)
          ..where(
            (table) => table.taskId.equals(taskId) & table.deletedAt.isNull(),
          )
          ..orderBy([
            (table) => OrderingTerm.asc(table.createdAt),
          ]))
        .watch();
  }

  @override
  Future<List<TaskCommentsTableData>> getByTask(String taskId) {
    return (_database.select(_database.taskCommentsTable)
          ..where(
            (table) => table.taskId.equals(taskId) & table.deletedAt.isNull(),
          )
          ..orderBy([
            (table) => OrderingTerm.asc(table.createdAt),
          ]))
        .get();
  }

  @override
  Future<TaskCommentsTableData?> getById(String id) {
    return (_database.select(
      _database.taskCommentsTable,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
  }

  @override
  Future<void> upsert(TaskCommentsTableCompanion comment) {
    return _database
        .into(_database.taskCommentsTable)
        .insertOnConflictUpdate(comment);
  }
}
