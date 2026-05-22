import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/board_entity.dart';
import '../mappers/board_mapper.dart';

abstract interface class BoardLocalDataSource {
  Stream<List<BoardEntity>> watchAll();

  Future<List<BoardEntity>> getAll();

  Future<void> save(BoardEntity board);

  Future<void> savePending(BoardEntity board, String syncAction);

  Future<void> markSynced(String boardId);

  Future<void> delete(String boardId);
}

final class DriftBoardLocalDataSource implements BoardLocalDataSource {
  const DriftBoardLocalDataSource(this._database);

  final AppDatabase _database;

  @override
  Stream<List<BoardEntity>> watchAll() {
    final query = _database.select(_database.boardsTable)
      ..where((board) => board.deletedAt.isNull())
      ..orderBy([(board) => OrderingTerm.desc(board.updatedAt)]);

    return query.watch().map(
      (rows) => rows.map((row) => row.toEntity()).toList(growable: false),
    );
  }

  @override
  Future<List<BoardEntity>> getAll() async {
    final query = _database.select(_database.boardsTable)
      ..where((board) => board.deletedAt.isNull())
      ..orderBy([(board) => OrderingTerm.desc(board.updatedAt)]);

    final rows = await query.get();
    return rows.map((row) => row.toEntity()).toList(growable: false);
  }

  @override
  Future<void> save(BoardEntity board) {
    return _database
        .into(_database.boardsTable)
        .insertOnConflictUpdate(board.toCompanion());
  }

  @override
  Future<void> savePending(BoardEntity board, String syncAction) {
    return _database
        .into(_database.boardsTable)
        .insertOnConflictUpdate(board.toCompanion(syncAction: syncAction));
  }

  @override
  Future<void> delete(String boardId) async {
    final now = DateTime.now().toUtc();
    await (_database.update(
      _database.boardsTable,
    )..where((board) => board.id.equals(boardId))).write(
      BoardsTableCompanion(
        deletedAt: Value(now),
        updatedAt: Value(now),
        isSynced: const Value(false),
        syncAction: const Value('delete'),
      ),
    );
  }

  @override
  Future<void> markSynced(String boardId) async {
    await (_database.update(
      _database.boardsTable,
    )..where((board) => board.id.equals(boardId))).write(
      const BoardsTableCompanion(
        isSynced: Value(true),
        syncAction: Value(null),
      ),
    );
  }
}
