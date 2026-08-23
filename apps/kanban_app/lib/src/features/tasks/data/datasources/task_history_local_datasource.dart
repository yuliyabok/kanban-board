import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../mappers/task_history_mapper.dart';
import '../../domain/entities/task_history_entry.dart';

abstract interface class TaskHistoryLocalDataSource {
  Stream<List<TaskHistoryEntry>> watchByTask(String taskId);

  Stream<List<TaskHistoryEntry>> watchSince(DateTime since);

  Future<void> insert(TaskHistoryEntry entry);
}

final class DriftTaskHistoryLocalDataSource
    implements TaskHistoryLocalDataSource {
  const DriftTaskHistoryLocalDataSource(this._database);

  final AppDatabase _database;

  @override
  Stream<List<TaskHistoryEntry>> watchByTask(String taskId) {
    final query = _database.select(_database.taskHistoryTable)
      ..where((entry) => entry.taskId.equals(taskId))
      ..orderBy([(entry) => OrderingTerm.desc(entry.changedAt)]);

    return query.watch().map(
      (rows) => rows.map((row) => row.toEntity()).toList(growable: false),
    );
  }

  @override
  Stream<List<TaskHistoryEntry>> watchSince(DateTime since) {
    final query = _database.select(_database.taskHistoryTable)
      ..where((entry) => entry.changedAt.isBiggerOrEqualValue(since))
      ..orderBy([(entry) => OrderingTerm.desc(entry.changedAt)]);

    return query.watch().map(
      (rows) => rows.map((row) => row.toEntity()).toList(growable: false),
    );
  }

  @override
  Future<void> insert(TaskHistoryEntry entry) {
    return _database
        .into(_database.taskHistoryTable)
        .insertOnConflictUpdate(entry.toCompanion());
  }
}
