import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';

abstract interface class ColumnLocalDataSource {
  Stream<List<BoardColumnsTableData>> watchByBoard(String boardId);

  Future<List<BoardColumnsTableData>> getByBoard(String boardId);

  Future<BoardColumnsTableData?> getById(String id);

  Future<void> upsert(BoardColumnsTableCompanion column);

  Future<void> upsertAll(List<BoardColumnsTableCompanion> columns);

  Future<void> markSynced(String id);

  Future<void> softDelete({
    required String id,
    required DateTime deletedAt,
  });
}

final class DriftColumnLocalDataSource implements ColumnLocalDataSource {
  const DriftColumnLocalDataSource(this._database);

  final AppDatabase _database;

  @override
  Stream<List<BoardColumnsTableData>> watchByBoard(String boardId) {
    final query = _database.select(_database.boardColumnsTable)
      ..where((column) => column.boardId.equals(boardId))
      ..where((column) => column.deletedAt.isNull())
      ..orderBy([(column) => OrderingTerm.asc(column.position)]);

    return query.watch();
  }

  @override
  Future<List<BoardColumnsTableData>> getByBoard(String boardId) {
    final query = _database.select(_database.boardColumnsTable)
      ..where((column) => column.boardId.equals(boardId))
      ..where((column) => column.deletedAt.isNull())
      ..orderBy([(column) => OrderingTerm.asc(column.position)]);

    return query.get();
  }

  @override
  Future<BoardColumnsTableData?> getById(String id) {
    final query = _database.select(_database.boardColumnsTable)
      ..where((column) => column.id.equals(id));

    return query.getSingleOrNull();
  }

  @override
  Future<void> upsert(BoardColumnsTableCompanion column) {
    return _database
        .into(_database.boardColumnsTable)
        .insertOnConflictUpdate(column);
  }

  @override
  Future<void> upsertAll(List<BoardColumnsTableCompanion> columns) async {
    await _database.batch((batch) {
      batch.insertAllOnConflictUpdate(_database.boardColumnsTable, columns);
    });
  }

  @override
  Future<void> markSynced(String id) async {
    await (_database.update(
      _database.boardColumnsTable,
    )..where((column) => column.id.equals(id))).write(
      const BoardColumnsTableCompanion(
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
      _database.boardColumnsTable,
    )..where((column) => column.id.equals(id))).write(
      BoardColumnsTableCompanion(
        deletedAt: Value(deletedAt),
        updatedAt: Value(deletedAt),
        isSynced: const Value(false),
        syncAction: const Value('delete'),
      ),
    );
  }
}
