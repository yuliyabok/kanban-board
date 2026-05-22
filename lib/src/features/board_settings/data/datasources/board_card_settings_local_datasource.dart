import '../../../../core/database/app_database.dart';

abstract interface class BoardCardSettingsLocalDataSource {
  Stream<BoardCardSettingsTableData?> watch(String boardId);

  Future<BoardCardSettingsTableData?> get(String boardId);

  Future<void> upsert(BoardCardSettingsTableCompanion settings);
}

final class DriftBoardCardSettingsLocalDataSource
    implements BoardCardSettingsLocalDataSource {
  const DriftBoardCardSettingsLocalDataSource(this._database);

  final AppDatabase _database;

  @override
  Stream<BoardCardSettingsTableData?> watch(String boardId) {
    final query = _database.select(_database.boardCardSettingsTable)
      ..where((settings) => settings.boardId.equals(boardId));

    return query.watchSingleOrNull();
  }

  @override
  Future<BoardCardSettingsTableData?> get(String boardId) {
    final query = _database.select(_database.boardCardSettingsTable)
      ..where((settings) => settings.boardId.equals(boardId));

    return query.getSingleOrNull();
  }

  @override
  Future<void> upsert(BoardCardSettingsTableCompanion settings) {
    return _database
        .into(_database.boardCardSettingsTable)
        .insertOnConflictUpdate(settings);
  }
}
