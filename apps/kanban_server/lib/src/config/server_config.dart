// Конфигурация backend: читает env-переменные и дает серверу настройки БД,
// JWT и времени жизни токенов.
final class ServerConfig {
  const ServerConfig({
    required this.databaseUrl,
    required this.jwtSecret,
    required this.accessTokenTtl,
    required this.refreshTokenTtl,
    required this.runMigrationsOnStart,
  });

  factory ServerConfig.fromEnvironment(Map<String, String> environment) {
    final environmentName =
        environment['KANBAN_ENV'] ?? environment['ENV'] ?? 'development';
    final isProduction = environmentName.trim().toLowerCase() == 'production';
    final jwtSecret = environment['JWT_SECRET'];
    if (isProduction &&
        (jwtSecret == null ||
            jwtSecret.isEmpty ||
            jwtSecret == 'dev-secret-change-me')) {
      throw StateError('JWT_SECRET must be set for production');
    }

    return ServerConfig(
      databaseUrl:
          environment['DATABASE_URL'] ??
          'postgres://kanban:kanban@localhost:5432/kanban',
      jwtSecret: jwtSecret ?? 'dev-secret-change-me',
      accessTokenTtl: Duration(
        minutes:
            int.tryParse(
              environment['ACCESS_TOKEN_TTL_MINUTES'] ?? '',
            ) ??
            30,
      ),
      refreshTokenTtl: Duration(
        days: int.tryParse(environment['REFRESH_TOKEN_TTL_DAYS'] ?? '') ?? 30,
      ),
      runMigrationsOnStart:
          (environment['RUN_MIGRATIONS_ON_START'] ?? 'true') != 'false',
    );
  }

  final String databaseUrl;
  final String jwtSecret;
  final Duration accessTokenTtl;
  final Duration refreshTokenTtl;
  final bool runMigrationsOnStart;
}
