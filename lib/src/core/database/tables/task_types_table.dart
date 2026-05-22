import 'package:drift/drift.dart';

class TaskTypesTable extends Table {
  TextColumn get id => text()();

  TextColumn get boardId => text().withDefault(const Constant(''))();

  TextColumn get name => text().withLength(min: 1, max: 50)();

  TextColumn get color => text().withLength(min: 1, max: 40)();

  TextColumn get icon => text().withLength(min: 1, max: 60)();

  TextColumn get description => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();

  DateTimeColumn get deletedAt => dateTime().nullable()();

  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();

  TextColumn get syncAction => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
