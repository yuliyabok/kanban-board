import 'package:drift/drift.dart';

class WorkspacesTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 120)();
  TextColumn get ownerId => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  TextColumn get syncAction => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
