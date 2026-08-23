// Точка входа серверного приложения: читает host/port и запускает Shelf server.
import 'dart:io';

import 'package:args/args.dart';
import 'package:kanban_server/server.dart';
import 'package:kanban_server/src/auth/auth_service.dart';
import 'package:kanban_server/src/auth/jwt_service.dart';
import 'package:kanban_server/src/auth/password_hasher.dart';
import 'package:kanban_server/src/auth/postgres_auth_repository.dart';
import 'package:kanban_server/src/boards/postgres_board_data_repository.dart';
import 'package:kanban_server/src/config/server_config.dart';
import 'package:kanban_server/src/database/migration_runner.dart';
import 'package:kanban_server/src/database/postgres_database.dart';
import 'package:kanban_server/src/tasks/postgres_task_data_repository.dart';
import 'package:kanban_server/src/workspaces/postgres_workspace_repository.dart';
import 'package:shelf/shelf_io.dart';

Future<void> main(List<String> args) async {
  final config = ServerConfig.fromEnvironment(Platform.environment);
  final parser = ArgParser()
    ..addOption('host', defaultsTo: Platform.environment['HOST'] ?? '0.0.0.0')
    ..addOption('port', defaultsTo: Platform.environment['PORT'] ?? '8080');
  final parsed = parser.parse(args);
  final host = parsed['host'] as String;
  final port = int.parse(parsed['port'] as String);

  final database = await PostgresDatabase.open(config);
  if (config.runMigrationsOnStart) {
    await MigrationRunner.postgres(database).runPending();
  }

  final authService = AuthService(
    repository: PostgresAuthRepository(database),
    passwordHasher: const PasswordHasher(),
    jwtService: JwtService(
      secret: config.jwtSecret,
      accessTokenTtl: config.accessTokenTtl,
    ),
    refreshTokenTtl: config.refreshTokenTtl,
  );

  final server = await serve(
    createServerHandler(
      authService: authService,
      workspaceRepository: PostgresWorkspaceRepository(database),
      boardDataRepository: PostgresBoardDataRepository(database),
      taskDataRepository: PostgresTaskDataRepository(database),
    ),
    host,
    port,
  );
  stdout.writeln(
    'Kanban server listening on http://${server.address.host}:${server.port}',
  );

  ProcessSignal.sigint.watch().listen((_) async {
    await database.close();
    await server.close(force: true);
    exit(0);
  });
}
