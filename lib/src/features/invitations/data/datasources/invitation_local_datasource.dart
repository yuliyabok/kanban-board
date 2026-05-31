import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';

abstract interface class InvitationLocalDataSource {
  Stream<List<InvitationsTableData>> watchPending(String email);

  Future<List<InvitationsTableData>> getPending(String email);

  Future<List<InvitationsTableData>> getAll();

  Future<InvitationsTableData?> getByToken(String token);

  Future<void> upsert(InvitationsTableCompanion invitation);
}

final class DriftInvitationLocalDataSource
    implements InvitationLocalDataSource {
  const DriftInvitationLocalDataSource(this._database);

  final AppDatabase _database;

  @override
  Stream<List<InvitationsTableData>> watchPending(String email) {
    return (_database.select(_database.invitationsTable)..where(
          (table) =>
              table.email.equals(email.trim().toLowerCase()) &
              table.acceptedAt.isNull() &
              table.declinedAt.isNull(),
        ))
        .watch();
  }

  @override
  Future<List<InvitationsTableData>> getPending(String email) {
    return (_database.select(_database.invitationsTable)..where(
          (table) =>
              table.email.equals(email.trim().toLowerCase()) &
              table.acceptedAt.isNull() &
              table.declinedAt.isNull(),
        ))
        .get();
  }

  @override
  Future<List<InvitationsTableData>> getAll() {
    return _database.select(_database.invitationsTable).get();
  }

  @override
  Future<InvitationsTableData?> getByToken(String token) {
    return (_database.select(
      _database.invitationsTable,
    )..where((table) => table.token.equals(token))).getSingleOrNull();
  }

  @override
  Future<void> upsert(InvitationsTableCompanion invitation) {
    return _database
        .into(_database.invitationsTable)
        .insertOnConflictUpdate(invitation);
  }
}
