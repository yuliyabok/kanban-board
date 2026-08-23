import 'package:drift/drift.dart';

class TaskCommentsTable extends Table {
  TextColumn get id => text()();
  TextColumn get taskId => text()();
  TextColumn get authorId => text()();
  TextColumn get content => text().withLength(min: 1, max: 5000)();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  TextColumn get syncAction => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
