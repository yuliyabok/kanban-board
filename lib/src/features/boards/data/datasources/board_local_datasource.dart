import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/board_entity.dart';
import '../mappers/board_mapper.dart';

abstract interface class BoardLocalDataSource {
  Stream<List<BoardEntity>> watchAll();

  Stream<List<BoardEntity>> watchVisibleToUser(String userId);

  Future<List<BoardEntity>> getAll();

  Future<void> save(BoardEntity board);

  Future<void> savePending(BoardEntity board, String syncAction);

  Future<void> addOwnerMembership(BoardEntity board);

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
  Stream<List<BoardEntity>> watchVisibleToUser(String userId) {
    return _database.select(_database.boardsTable).watch().asyncMap((
      rows,
    ) async {
      final boardMembers = await (_database.select(
        _database.boardMembersTable,
      )..where((member) => member.userId.equals(userId))).get();
      final workspaceMembers = await (_database.select(
        _database.workspaceMembersTable,
      )..where((member) => member.userId.equals(userId))).get();

      final boardIds = boardMembers.map((member) => member.boardId).toSet();
      final workspaceIds = workspaceMembers
          .map((member) => member.workspaceId)
          .toSet();

      final visible =
          rows
              .where((row) {
                if (row.deletedAt != null) return false;
                if (row.ownerId == userId) return true;
                if (boardIds.contains(row.id)) return true;
                final workspaceId = row.workspaceId;
                return workspaceId != null &&
                    workspaceIds.contains(workspaceId);
              })
              .toList(growable: false)
            ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

      return visible.map((row) => row.toEntity()).toList(growable: false);
    });
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
  Future<void> addOwnerMembership(BoardEntity board) {
    return _database
        .into(_database.boardMembersTable)
        .insertOnConflictUpdate(
          BoardMembersTableCompanion.insert(
            id: '${board.id}:${board.ownerId}',
            boardId: board.id,
            userId: board.ownerId,
            role: 'admin',
            joinedAt: board.createdAt,
            isSynced: const Value(false),
            syncAction: const Value('create'),
          ),
        );
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
