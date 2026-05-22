import 'package:drift/drift.dart';

class BoardsTable extends Table {
  TextColumn get id => text()();

  TextColumn get ownerId => text()();

  TextColumn get title => text().withLength(min: 1, max: 120)();

  TextColumn get description => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();

  DateTimeColumn get deletedAt => dateTime().nullable()();

  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();

  TextColumn get syncAction => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
