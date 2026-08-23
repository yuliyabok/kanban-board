import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/providers/core_providers.dart';
import '../../../permissions/presentation/providers/permission_providers.dart';
import '../../../tasks/data/datasources/task_history_local_datasource.dart';
import '../../data/datasources/task_comment_local_datasource.dart';
import '../../data/datasources/task_comment_remote_datasource.dart';
import '../../data/repositories/default_task_comment_repository.dart';
import '../../domain/entities/task_comment_entity.dart';
import '../../domain/repositories/task_comment_repository.dart';
import '../../domain/usecases/task_comment_usecases.dart';

final taskCommentLocalDataSourceProvider = Provider<TaskCommentLocalDataSource>(
  (ref) => DriftTaskCommentLocalDataSource(ref.watch(appDatabaseProvider)),
);

final taskCommentRemoteDataSourceProvider =
    Provider<TaskCommentRemoteDataSource>((ref) {
      final config = ref.watch(appConfigProvider);
      if (config.usesServerRemote) {
        return ApiTaskCommentRemoteDataSource(ref.watch(apiClientProvider));
      }
      return const MockTaskCommentRemoteDataSource();
    });

final taskCommentRepositoryProvider = Provider<TaskCommentRepository>(
  (ref) => DefaultTaskCommentRepository(
    database: ref.watch(appDatabaseProvider),
    localDataSource: ref.watch(taskCommentLocalDataSourceProvider),
    remoteDataSource: ref.watch(taskCommentRemoteDataSourceProvider),
    historyLocalDataSource: DriftTaskHistoryLocalDataSource(
      ref.watch(appDatabaseProvider),
    ),
    permissionRepository: ref.watch(permissionRepositoryProvider),
    realtimeService: ref.watch(realtimeServiceProvider),
    syncOutbox: ref.watch(syncOutboxProvider),
    uuid: const Uuid(),
  ),
);

final createTaskCommentUseCaseProvider = Provider<CreateTaskCommentUseCase>(
  (ref) => CreateTaskCommentUseCase(ref.watch(taskCommentRepositoryProvider)),
);

final updateTaskCommentUseCaseProvider = Provider<UpdateTaskCommentUseCase>(
  (ref) => UpdateTaskCommentUseCase(ref.watch(taskCommentRepositoryProvider)),
);

final deleteTaskCommentUseCaseProvider = Provider<DeleteTaskCommentUseCase>(
  (ref) => DeleteTaskCommentUseCase(ref.watch(taskCommentRepositoryProvider)),
);

final taskCommentsProvider = StreamProvider.autoDispose
    .family<List<TaskCommentEntity>, String>(
      (ref, taskId) =>
          ref.watch(taskCommentRepositoryProvider).watchByTask(taskId),
    );
