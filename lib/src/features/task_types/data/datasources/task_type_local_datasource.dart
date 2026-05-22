import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';

abstract interface class TaskTypeLocalDataSource {
  Stream<List<TaskTypesTableData>> watchByBoard(String boardId);

  Future<List<TaskTypesTableData>> getByBoard(String boardId);

  Future<TaskTypesTableData?> getById(String id);

  Future<void> upsert(TaskTypesTableCompanion type);

  Future<void> upsertAll(List<TaskTypesTableCompanion> types);

  Future<void> softDelete({
    required String id,
    required DateTime deletedAt,
  });

  Future<void> clearTaskTypeUsage({
    required String boardId,
    required String taskTypeId,
    required DateTime updatedAt,
  });
}

final class DriftTaskTypeLocalDataSource implements TaskTypeLocalDataSource {
  const DriftTaskTypeLocalDataSource(this._database);

  final AppDatabase _database;

  @override
  Stream<List<TaskTypesTableData>> watchByBoard(String boardId) {
    final query = _database.select(_database.taskTypesTable)
      ..where((type) => type.boardId.equals(boardId))
      ..where((type) => type.deletedAt.isNull())
      ..orderBy([(type) => OrderingTerm.asc(type.name)]);

    return query.watch();
  }

  @override
  Future<List<TaskTypesTableData>> getByBoard(String boardId) {
    final query = _database.select(_database.taskTypesTable)
      ..where((type) => type.boardId.equals(boardId))
      ..where((type) => type.deletedAt.isNull())
      ..orderBy([(type) => OrderingTerm.asc(type.name)]);

    return query.get();
  }

  @override
  Future<TaskTypesTableData?> getById(String id) {
    final query = _database.select(_database.taskTypesTable)
      ..where((type) => type.id.equals(id))
      ..where((type) => type.deletedAt.isNull());

    return query.getSingleOrNull();
  }

  @override
  Future<void> upsert(TaskTypesTableCompanion type) {
    return _database
        .into(_database.taskTypesTable)
        .insertOnConflictUpdate(type);
  }

  @override
  Future<void> upsertAll(List<TaskTypesTableCompanion> types) async {
    await _database.batch((batch) {
      batch.insertAllOnConflictUpdate(_database.taskTypesTable, types);
    });
  }

  @override
  Future<void> softDelete({
    required String id,
    required DateTime deletedAt,
  }) async {
    await (_database.update(
      _database.taskTypesTable,
    )..where((type) => type.id.equals(id))).write(
      TaskTypesTableCompanion(
        deletedAt: Value(deletedAt),
        updatedAt: Value(deletedAt),
        isSynced: const Value(false),
        syncAction: const Value('delete'),
      ),
    );
  }

  @override
  Future<void> clearTaskTypeUsage({
    required String boardId,
    required String taskTypeId,
    required DateTime updatedAt,
  }) async {
    await (_database.update(_database.tasksTable)
          ..where((task) => task.boardId.equals(boardId))
          ..where((task) => task.taskTypeId.equals(taskTypeId)))
        .write(
          TasksTableCompanion(
            taskTypeId: const Value(null),
            updatedAt: Value(updatedAt),
            isSynced: const Value(false),
            syncAction: const Value('update'),
          ),
        );
  }
}
