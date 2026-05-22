import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/board_columns_table.dart';
import 'tables/board_card_settings_table.dart';
import 'tables/boards_table.dart';
import 'tables/task_types_table.dart';
import 'tables/tasks_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    BoardsTable,
    BoardColumnsTable,
    TaskTypesTable,
    BoardCardSettingsTable,
    TasksTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  factory AppDatabase.open(String name) {
    return AppDatabase(
      driftDatabase(
        name: name,
        web: DriftWebOptions(
          sqlite3Wasm: Uri.parse('sqlite3.wasm'),
          driftWorker: Uri.parse('drift_worker.js'),
        ),
      ),
    );
  }

  @override
  int get schemaVersion => 7;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (migrator) async {
        await migrator.createAll();
      },
      onUpgrade: (migrator, from, to) async {
        if (from < 2) {
          await migrator.createTable(boardsTable);
        }
        if (from < 3) {
          await migrator.createTable(boardColumnsTable);
          await migrator.addColumn(tasksTable, tasksTable.columnId);
        }
        if (from < 4) {
          await migrator.createTable(taskTypesTable);
          await migrator.createTable(boardCardSettingsTable);
          await migrator.addColumn(tasksTable, tasksTable.parentTaskId);
          await migrator.addColumn(tasksTable, tasksTable.taskTypeId);
          await migrator.addColumn(tasksTable, tasksTable.depth);
          await migrator.addColumn(tasksTable, tasksTable.status);
          await migrator.addColumn(tasksTable, tasksTable.priority);
          await migrator.addColumn(tasksTable, tasksTable.assigneeName);
          await migrator.addColumn(tasksTable, tasksTable.labelsJson);
          await migrator.addColumn(tasksTable, tasksTable.startDate);
          await migrator.addColumn(tasksTable, tasksTable.dueDate);
          await migrator.addColumn(tasksTable, tasksTable.completedAt);
          await migrator.addColumn(
            tasksTable,
            tasksTable.estimatedDurationMinutes,
          );
          await migrator.addColumn(
            tasksTable,
            tasksTable.actualDurationMinutes,
          );
          await migrator.addColumn(tasksTable, tasksTable.periodType);
        }
        if (from >= 4 && from < 5) {
          await migrator.addColumn(taskTypesTable, taskTypesTable.boardId);
          await customStatement('''
            INSERT OR IGNORE INTO task_types_table (
              id,
              board_id,
              name,
              color,
              icon,
              description,
              created_at,
              updated_at,
              deleted_at,
              is_synced,
              sync_action
            )
            SELECT
              boards_table.id || ':' || task_types_table.id,
              boards_table.id,
              task_types_table.name,
              task_types_table.color,
              task_types_table.icon,
              task_types_table.description,
              task_types_table.created_at,
              task_types_table.updated_at,
              task_types_table.deleted_at,
              task_types_table.is_synced,
              task_types_table.sync_action
            FROM boards_table
            CROSS JOIN task_types_table
            WHERE task_types_table.board_id = ''
              AND task_types_table.deleted_at IS NULL
          ''');
          await customStatement('''
            UPDATE tasks_table
            SET task_type_id = board_id || ':' || task_type_id
            WHERE task_type_id IS NOT NULL
              AND EXISTS (
                SELECT 1
                FROM task_types_table
                WHERE task_types_table.id =
                  tasks_table.board_id || ':' || tasks_table.task_type_id
              )
          ''');
        }
        if (from < 6) {
          await migrator.addColumn(
            boardCardSettingsTable,
            boardCardSettingsTable.cardBackgroundColor,
          );
          await migrator.addColumn(
            boardCardSettingsTable,
            boardCardSettingsTable.columnBackgroundColor,
          );
        }
        if (from < 7) {
          await migrator.addColumn(tasksTable, tasksTable.cardBackgroundColor);
          await migrator.addColumn(tasksTable, tasksTable.cardTextColor);
        }
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }
}
