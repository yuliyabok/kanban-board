import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';

abstract interface class BoardMemberLocalDataSource {
  Stream<List<BoardMembersTableData>> watchByBoard(String boardId);

  Future<List<BoardMembersTableData>> getByBoard(String boardId);

  Future<BoardMembersTableData?> getByUser({
    required String boardId,
    required String userId,
  });

  Future<void> upsert(BoardMembersTableCompanion member);

  Future<void> delete({
    required String boardId,
    required String userId,
  });
}

final class DriftBoardMemberLocalDataSource
    implements BoardMemberLocalDataSource {
  const DriftBoardMemberLocalDataSource(this._database);

  final AppDatabase _database;

  @override
  Stream<List<BoardMembersTableData>> watchByBoard(String boardId) {
    return (_database.select(
      _database.boardMembersTable,
    )..where((table) => table.boardId.equals(boardId))).watch();
  }

  @override
  Future<List<BoardMembersTableData>> getByBoard(String boardId) {
    return (_database.select(
      _database.boardMembersTable,
    )..where((table) => table.boardId.equals(boardId))).get();
  }

  @override
  Future<BoardMembersTableData?> getByUser({
    required String boardId,
    required String userId,
  }) {
    return (_database.select(_database.boardMembersTable)..where(
          (table) =>
              table.boardId.equals(boardId) & table.userId.equals(userId),
        ))
        .getSingleOrNull();
  }

  @override
  Future<void> upsert(BoardMembersTableCompanion member) {
    return _database
        .into(_database.boardMembersTable)
        .insertOnConflictUpdate(member);
  }

  @override
  Future<void> delete({
    required String boardId,
    required String userId,
  }) {
    return (_database.delete(_database.boardMembersTable)..where(
          (table) =>
              table.boardId.equals(boardId) & table.userId.equals(userId),
        ))
        .go();
  }
}
