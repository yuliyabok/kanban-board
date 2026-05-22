import 'package:drift/drift.dart';

class BoardColumnsTable extends Table {
  TextColumn get id => text()();

  TextColumn get boardId => text()();

  TextColumn get title => text().withLength(min: 1, max: 50)();

  IntColumn get position => integer()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();

  DateTimeColumn get deletedAt => dateTime().nullable()();

  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();

  TextColumn get syncAction => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
