import '../../../../core/database/app_database.dart';

abstract interface class UserLocalDataSource {
  Future<UsersTableData?> getById(String id);

  Future<UsersTableData?> getByEmail(String email);

  Future<List<UsersTableData>> search(String query);

  Future<void> upsert(UsersTableCompanion user);
}

final class DriftUserLocalDataSource implements UserLocalDataSource {
  const DriftUserLocalDataSource(this._database);

  final AppDatabase _database;

  @override
  Future<UsersTableData?> getById(String id) {
    return (_database.select(
      _database.usersTable,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
  }

  @override
  Future<UsersTableData?> getByEmail(String email) {
    return (_database.select(_database.usersTable)
          ..where((table) => table.email.equals(email.trim().toLowerCase())))
        .getSingleOrNull();
  }

  @override
  Future<List<UsersTableData>> search(String query) async {
    final normalized = query.trim().toLowerCase();
    final rows = await _database.select(_database.usersTable).get();
    if (normalized.isEmpty) return rows.take(20).toList(growable: false);
    return rows
        .where(
          (row) =>
              row.email.toLowerCase().contains(normalized) ||
              row.fullName.toLowerCase().contains(normalized),
        )
        .take(20)
        .toList(growable: false);
  }

  @override
  Future<void> upsert(UsersTableCompanion user) {
    return _database.into(_database.usersTable).insertOnConflictUpdate(user);
  }
}

extension UserLocalEntityReader on UserLocalDataSource {
  Future<List<UsersTableData>> searchEntities(String query) => search(query);
}
