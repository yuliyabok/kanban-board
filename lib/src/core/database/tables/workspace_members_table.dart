import 'package:drift/drift.dart';

class WorkspaceMembersTable extends Table {
  TextColumn get id => text()();
  TextColumn get workspaceId => text()();
  TextColumn get userId => text()();
  TextColumn get role => text()();
  DateTimeColumn get joinedAt => dateTime()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  TextColumn get syncAction => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
