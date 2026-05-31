import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/providers/core_providers.dart';
import '../../../permissions/presentation/providers/permission_providers.dart';
import '../../data/datasources/task_comment_local_datasource.dart';
import '../../data/repositories/default_task_comment_repository.dart';
import '../../domain/entities/task_comment_entity.dart';
import '../../domain/repositories/task_comment_repository.dart';
import '../../domain/usecases/task_comment_usecases.dart';

final taskCommentLocalDataSourceProvider = Provider<TaskCommentLocalDataSource>(
  (ref) => DriftTaskCommentLocalDataSource(ref.watch(appDatabaseProvider)),
);

final taskCommentRepositoryProvider = Provider<TaskCommentRepository>(
  (ref) => DefaultTaskCommentRepository(
    database: ref.watch(appDatabaseProvider),
    localDataSource: ref.watch(taskCommentLocalDataSourceProvider),
    permissionRepository: ref.watch(permissionRepositoryProvider),
    realtimeService: ref.watch(realtimeServiceProvider),
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
