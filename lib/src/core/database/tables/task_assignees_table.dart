import 'package:drift/drift.dart';

class TaskAssigneesTable extends Table {
  TextColumn get id => text()();
  TextColumn get taskId => text()();
  TextColumn get userId => text()();
  TextColumn get assignedBy => text()();
  DateTimeColumn get assignedAt => dateTime()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  TextColumn get syncAction => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
