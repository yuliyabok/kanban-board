import 'package:drift/drift.dart';

class TaskHistoryTable extends Table {
  TextColumn get id => text()();

  TextColumn get taskId => text()();

  TextColumn get boardId => text()();

  TextColumn get action => text()();

  TextColumn get summary => text()();

  TextColumn get detailsJson => text().nullable()();

  TextColumn get actorUserId => text().nullable()();

  DateTimeColumn get changedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
