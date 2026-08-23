// Простой migration runner: читает SQL-файлы из папки migrations и запоминает
// примененные версии в таблице schema_migrations.
import 'dart:io';

import 'package:kanban_server/src/database/postgres_database.dart';

typedef SqlExecutor = Future<void> Function(String sql);

final class MigrationRunner {
  const MigrationRunner({
    required SqlExecutor execute,
    required Future<List<String>> Function() appliedVersions,
    required Future<void> Function(String version) markApplied,
    required Directory migrationsDirectory,
  }) : _execute = execute,
       _appliedVersions = appliedVersions,
       _markApplied = markApplied,
       _migrationsDirectory = migrationsDirectory;

  factory MigrationRunner.postgres(PostgresDatabase database) {
    return MigrationRunner(
      execute: (sql) => database.execute(sql, ignoreRows: true),
      appliedVersions: () async {
        await database.execute(
          '''
          CREATE TABLE IF NOT EXISTS schema_migrations (
            version text PRIMARY KEY,
            applied_at timestamptz NOT NULL
          )
          ''',
          ignoreRows: true,
        );
        final result = await database.execute(
          'SELECT version FROM schema_migrations ORDER BY version',
        );
        return result
            .map((row) => row.toColumnMap()['version'] as String)
            .toList(growable: false);
      },
      markApplied: (version) => database.execute(
        '''
        INSERT INTO schema_migrations(version, applied_at)
        VALUES (@version, @appliedAt)
        ON CONFLICT (version) DO NOTHING
        ''',
        parameters: {
          'version': version,
          'appliedAt': DateTime.now().toUtc(),
        },
        ignoreRows: true,
      ),
      migrationsDirectory: Directory('migrations'),
    );
  }

  final SqlExecutor _execute;
  final Future<List<String>> Function() _appliedVersions;
  final Future<void> Function(String version) _markApplied;
  final Directory _migrationsDirectory;

  Future<List<String>> runPending() async {
    final applied = (await _appliedVersions()).toSet();
    final files =
        _migrationsDirectory
            .listSync()
            .whereType<File>()
            .where((file) => file.path.endsWith('.sql'))
            .toList()
          ..sort((a, b) => a.path.compareTo(b.path));
    final appliedNow = <String>[];

    for (final file in files) {
      final version = file.uri.pathSegments.last;
      if (applied.contains(version)) continue;
      await _execute(await file.readAsString());
      await _markApplied(version);
      appliedNow.add(version);
    }

    return appliedNow;
  }
}
