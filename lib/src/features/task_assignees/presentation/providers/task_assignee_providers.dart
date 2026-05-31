import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/providers/core_providers.dart';
import '../../../permissions/presentation/providers/permission_providers.dart';
import '../../data/datasources/task_assignee_local_datasource.dart';
import '../../data/repositories/default_task_assignee_repository.dart';
import '../../domain/entities/task_assignee_entity.dart';
import '../../domain/repositories/task_assignee_repository.dart';
import '../../domain/usecases/task_assignee_usecases.dart';

final taskAssigneeLocalDataSourceProvider =
    Provider<TaskAssigneeLocalDataSource>(
      (ref) => DriftTaskAssigneeLocalDataSource(ref.watch(appDatabaseProvider)),
    );

final taskAssigneeRepositoryProvider = Provider<TaskAssigneeRepository>(
  (ref) => DefaultTaskAssigneeRepository(
    database: ref.watch(appDatabaseProvider),
    localDataSource: ref.watch(taskAssigneeLocalDataSourceProvider),
    permissionRepository: ref.watch(permissionRepositoryProvider),
    realtimeService: ref.watch(realtimeServiceProvider),
    uuid: const Uuid(),
  ),
);

final assignTaskUserUseCaseProvider = Provider<AssignTaskUserUseCase>(
  (ref) => AssignTaskUserUseCase(ref.watch(taskAssigneeRepositoryProvider)),
);

final unassignTaskUserUseCaseProvider = Provider<UnassignTaskUserUseCase>(
  (ref) => UnassignTaskUserUseCase(ref.watch(taskAssigneeRepositoryProvider)),
);

final taskAssigneesProvider = StreamProvider.autoDispose
    .family<List<TaskAssigneeEntity>, String>(
      (ref, taskId) =>
          ref.watch(taskAssigneeRepositoryProvider).watchByTask(taskId),
    );

final myTaskAssigneeIdsProvider = FutureProvider.autoDispose
    .family<Set<String>, ({String boardId, String userId})>((ref, args) async {
      final result = await ref
          .watch(taskAssigneeRepositoryProvider)
          .getMyTasks(
            boardId: args.boardId,
            userId: args.userId,
          );
      return result.fold(
        onSuccess: (items) => items.map((item) => item.taskId).toSet(),
        onFailure: (_) => const <String>{},
      );
    });
