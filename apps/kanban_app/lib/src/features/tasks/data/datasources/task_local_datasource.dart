import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';

abstract interface class TaskLocalDataSource {
  Stream<List<TasksTableData>> watchByBoard(String boardId);

  Future<List<TasksTableData>> getByBoard(String boardId);

  Future<TasksTableData?> getById(String id);

  Future<void> upsert(TasksTableCompanion task);

  Future<void> markSynced(String id);

  Future<void> softDelete({
    required String id,
    required DateTime deletedAt,
  });
}

final class DriftTaskLocalDataSource implements TaskLocalDataSource {
  const DriftTaskLocalDataSource(this._database);

  final AppDatabase _database;

  @override
  Stream<List<TasksTableData>> watchByBoard(String boardId) {
    final query = _database.select(_database.tasksTable)
      ..where((task) => task.boardId.equals(boardId))
      ..where((task) => task.deletedAt.isNull())
      ..orderBy([
        (task) => OrderingTerm.asc(task.parentTaskId),
        (task) => OrderingTerm.asc(task.position),
      ]);

    return query.watch();
  }

  @override
  Future<List<TasksTableData>> getByBoard(String boardId) {
    final query = _database.select(_database.tasksTable)
      ..where((task) => task.boardId.equals(boardId))
      ..where((task) => task.deletedAt.isNull())
      ..orderBy([
        (task) => OrderingTerm.asc(task.parentTaskId),
        (task) => OrderingTerm.asc(task.position),
      ]);

    return query.get();
  }

  @override
  Future<TasksTableData?> getById(String id) {
    final query = _database.select(_database.tasksTable)
      ..where((task) => task.id.equals(id));

    return query.getSingleOrNull();
  }

  @override
  Future<void> upsert(TasksTableCompanion task) {
    return _database.into(_database.tasksTable).insertOnConflictUpdate(task);
  }

  @override
  Future<void> markSynced(String id) async {
    await (_database.update(
      _database.tasksTable,
    )..where((task) => task.id.equals(id))).write(
      const TasksTableCompanion(
        isSynced: Value(true),
        syncAction: Value(null),
      ),
    );
  }

  @override
  Future<void> softDelete({
    required String id,
    required DateTime deletedAt,
  }) async {
    await (_database.update(
      _database.tasksTable,
    )..where((task) => task.id.equals(id))).write(
      TasksTableCompanion(
        deletedAt: Value(deletedAt),
        updatedAt: Value(deletedAt),
        isSynced: const Value(false),
        syncAction: const Value('delete'),
      ),
    );
  }
}
