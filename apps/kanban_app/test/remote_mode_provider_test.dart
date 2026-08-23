// Проверяет главный переключатель подготовки к backend: local-режим оставляет
// безопасные заглушки, server-режим подключает API datasource.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board/src/core/config/app_config.dart';
import 'package:kanban_board/src/core/providers/core_providers.dart';
import 'package:kanban_board/src/features/boards/data/datasources/board_remote_datasource.dart';
import 'package:kanban_board/src/features/boards/presentation/providers/board_providers.dart';
import 'package:kanban_board/src/features/columns/data/datasources/column_remote_datasource.dart';
import 'package:kanban_board/src/features/columns/presentation/providers/column_providers.dart';
import 'package:kanban_board/src/features/comments/data/datasources/task_comment_remote_datasource.dart';
import 'package:kanban_board/src/features/comments/presentation/providers/task_comment_providers.dart';
import 'package:kanban_board/src/features/task_assignees/data/datasources/task_assignee_remote_datasource.dart';
import 'package:kanban_board/src/features/task_assignees/presentation/providers/task_assignee_providers.dart';
import 'package:kanban_board/src/features/task_types/data/datasources/task_type_remote_datasource.dart';
import 'package:kanban_board/src/features/task_types/presentation/providers/task_type_providers.dart';
import 'package:kanban_board/src/features/tasks/data/datasources/task_remote_datasource.dart';
import 'package:kanban_board/src/features/tasks/presentation/providers/task_providers.dart';
import 'package:kanban_board/src/features/users/data/datasources/user_remote_datasource.dart';
import 'package:kanban_board/src/features/users/presentation/providers/user_providers.dart';
import 'package:kanban_board/src/features/workspaces/data/datasources/workspace_remote_datasource.dart';
import 'package:kanban_board/src/features/workspaces/presentation/providers/workspace_providers.dart';

void main() {
  test('local mode keeps local remote datasource adapters', () {
    final container = ProviderContainer(
      overrides: [
        appConfigProvider.overrideWithValue(_config(RemoteMode.local)),
      ],
    );
    addTearDown(container.dispose);

    expect(
      container.read(taskRemoteDataSourceProvider),
      isA<LocalTaskRemoteDataSource>(),
    );
    expect(
      container.read(boardRemoteDataSourceProvider),
      isA<LocalBoardRemoteDataSource>(),
    );
    expect(
      container.read(columnRemoteDataSourceProvider),
      isA<LocalColumnRemoteDataSource>(),
    );
    expect(
      container.read(taskTypeRemoteDataSourceProvider),
      isA<LocalTaskTypeRemoteDataSource>(),
    );
    expect(
      container.read(taskCommentRemoteDataSourceProvider),
      isA<MockTaskCommentRemoteDataSource>(),
    );
    expect(
      container.read(taskAssigneeRemoteDataSourceProvider),
      isA<MockTaskAssigneeRemoteDataSource>(),
    );
    expect(
      container.read(userRemoteDataSourceProvider),
      isA<MockUserRemoteDataSource>(),
    );
    expect(
      container.read(workspaceRemoteDataSourceProvider),
      isA<MockWorkspaceRemoteDataSource>(),
    );
  });

  test('server mode switches prepared features to api datasource adapters', () {
    final container = ProviderContainer(
      overrides: [
        appConfigProvider.overrideWithValue(_config(RemoteMode.server)),
      ],
    );
    addTearDown(container.dispose);

    expect(
      container.read(taskRemoteDataSourceProvider),
      isA<ApiTaskRemoteDataSource>(),
    );
    expect(
      container.read(boardRemoteDataSourceProvider),
      isA<ApiBoardRemoteDataSource>(),
    );
    expect(
      container.read(columnRemoteDataSourceProvider),
      isA<ApiColumnRemoteDataSource>(),
    );
    expect(
      container.read(taskTypeRemoteDataSourceProvider),
      isA<ApiTaskTypeRemoteDataSource>(),
    );
    expect(
      container.read(taskCommentRemoteDataSourceProvider),
      isA<ApiTaskCommentRemoteDataSource>(),
    );
    expect(
      container.read(taskAssigneeRemoteDataSourceProvider),
      isA<ApiTaskAssigneeRemoteDataSource>(),
    );
    expect(
      container.read(userRemoteDataSourceProvider),
      isA<ApiUserRemoteDataSource>(),
    );
    expect(
      container.read(workspaceRemoteDataSourceProvider),
      isA<ApiWorkspaceRemoteDataSource>(),
    );
  });
}

AppConfig _config(RemoteMode mode) {
  return AppConfig(
    apiBaseUrl: 'http://localhost:8080',
    webSocketUrl: 'ws://localhost:8080/realtime',
    databaseName: 'kanban_board_test',
    remoteMode: mode,
  );
}
