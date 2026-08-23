import 'package:drift/drift.dart';

class BoardCardSettingsTable extends Table {
  TextColumn get boardId => text()();

  BoolColumn get showDescription =>
      boolean().withDefault(const Constant(true))();

  BoolColumn get showTaskType => boolean().withDefault(const Constant(true))();

  BoolColumn get showPeriod => boolean().withDefault(const Constant(true))();

  BoolColumn get showSubtaskProgress =>
      boolean().withDefault(const Constant(true))();

  BoolColumn get showPriority => boolean().withDefault(const Constant(true))();

  BoolColumn get showAssignee => boolean().withDefault(const Constant(true))();

  BoolColumn get showLabels => boolean().withDefault(const Constant(true))();

  BoolColumn get showCreatedAt =>
      boolean().withDefault(const Constant(false))();

  BoolColumn get showQuickActions =>
      boolean().withDefault(const Constant(true))();

  TextColumn get density => text().withDefault(const Constant('compact'))();

  TextColumn get style => text().withDefault(const Constant('bordered'))();

  TextColumn get typeBadgePlacement =>
      text().withDefault(const Constant('top'))();

  TextColumn get typeColorMode =>
      text().withDefault(const Constant('smallDot'))();

  TextColumn get cardBackgroundColor =>
      text().withDefault(const Constant('default'))();

  TextColumn get columnBackgroundColor =>
      text().withDefault(const Constant('default'))();

  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {boardId};
}
