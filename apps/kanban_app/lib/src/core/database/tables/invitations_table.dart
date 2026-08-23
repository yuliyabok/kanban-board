import 'package:drift/drift.dart';

class InvitationsTable extends Table {
  TextColumn get id => text()();
  TextColumn get email => text()();
  TextColumn get workspaceId => text().nullable()();
  TextColumn get boardId => text().nullable()();
  TextColumn get role => text()();
  TextColumn get token => text()();
  TextColumn get invitedBy => text()();
  DateTimeColumn get expiresAt => dateTime()();
  DateTimeColumn get acceptedAt => dateTime().nullable()();
  DateTimeColumn get declinedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  TextColumn get syncAction => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
