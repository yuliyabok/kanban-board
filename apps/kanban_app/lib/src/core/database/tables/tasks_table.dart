import 'package:drift/drift.dart';

class TasksTable extends Table {
  TextColumn get id => text()();

  TextColumn get boardId => text()();

  TextColumn get columnId => text().nullable()();

  TextColumn get parentTaskId => text().nullable()();

  TextColumn get taskTypeId => text().nullable()();

  TextColumn get title => text().withLength(min: 1, max: 120)();

  TextColumn get description => text().nullable()();

  TextColumn get cardBackgroundColor => text().nullable()();

  TextColumn get cardTextColor => text().nullable()();

  IntColumn get position => integer()();

  IntColumn get depth => integer().withDefault(const Constant(0))();

  TextColumn get status => text().withDefault(const Constant('todo'))();

  TextColumn get priority => text().withDefault(const Constant('medium'))();

  TextColumn get assigneeName => text().nullable()();

  TextColumn get labelsJson => text().withDefault(const Constant('[]'))();

  DateTimeColumn get startDate => dateTime().nullable()();

  DateTimeColumn get dueDate => dateTime().nullable()();

  DateTimeColumn get completedAt => dateTime().nullable()();

  IntColumn get estimatedDurationMinutes => integer().nullable()();

  IntColumn get actualDurationMinutes => integer().nullable()();

  TextColumn get periodType => text().withDefault(const Constant('custom'))();

  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();

  DateTimeColumn get deletedAt => dateTime().nullable()();

  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();

  TextColumn get syncAction => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
