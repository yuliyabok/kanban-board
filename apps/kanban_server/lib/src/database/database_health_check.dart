// Проверка, что backend может выполнить простой запрос к PostgreSQL.
import 'package:kanban_server/src/database/postgres_database.dart';

final class DatabaseHealthCheck {
  const DatabaseHealthCheck(this._database);

  final PostgresDatabase _database;

  Future<bool> isHealthy() async {
    final result = await _database.execute('SELECT 1 AS ok');
    return result.single.toColumnMap()['ok'] == 1;
  }
}
