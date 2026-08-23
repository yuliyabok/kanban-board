// Тонкая обертка над postgres connection: централизует подключение, execute и
// закрытие соединения.
import 'package:kanban_server/src/config/server_config.dart';
import 'package:postgres/postgres.dart';

final class PostgresDatabase {
  const PostgresDatabase(this._connection);

  final Connection _connection;

  static Future<PostgresDatabase> open(ServerConfig config) async {
    // Add sslmode=disable to the connection string for local development
    final connectionUrl = config.databaseUrl.contains('sslmode')
        ? config.databaseUrl
        : '${config.databaseUrl}?sslmode=disable';
    
    final connection = await Connection.openFromUrl(connectionUrl);
    return PostgresDatabase(connection);
  }

  Future<Result> execute(
    String sql, {
    Map<String, Object?> parameters = const {},
    bool ignoreRows = false,
  }) {
    return _connection.execute(
      Sql.named(sql),
      parameters: parameters,
      ignoreRows: ignoreRows,
    );
  }

  Future<void> close() {
    return _connection.close();
  }
}
