import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/providers/core_providers.dart';
import '../../application/services/task_command_service.dart';
import '../../data/datasources/task_local_datasource.dart';
import '../../data/datasources/task_remote_datasource.dart';
import '../../data/repositories/offline_first_task_repository.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/task_repository.dart';
import '../../domain/usecases/create_task.dart';
import '../../domain/usecases/delete_task.dart';
import '../../domain/usecases/add_subtask.dart';
import '../../domain/usecases/reorder_subtasks.dart';
import '../../domain/usecases/toggle_subtask.dart';
import '../../domain/usecases/update_task.dart';
import '../../domain/usecases/update_task_period.dart';
import '../../domain/usecases/update_task_type.dart';
import '../../domain/usecases/watch_board_tasks.dart';

final uuidProvider = Provider<Uuid>((ref) => const Uuid());

final taskLocalDataSourceProvider = Provider<TaskLocalDataSource>((ref) {
  return DriftTaskLocalDataSource(ref.watch(appDatabaseProvider));
});

final taskRemoteDataSourceProvider = Provider<TaskRemoteDataSource>((ref) {
  return const LocalTaskRemoteDataSource();
});

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return OfflineFirstTaskRepository(
    localDataSource: ref.watch(taskLocalDataSourceProvider),
    remoteDataSource: ref.watch(taskRemoteDataSourceProvider),
    uuid: ref.watch(uuidProvider),
  );
});

final taskCommandServiceProvider = Provider<TaskCommandService>((ref) {
  return DefaultTaskCommandService(ref.watch(taskRepositoryProvider));
});

final watchBoardTasksProvider = Provider<WatchBoardTasks>((ref) {
  return WatchBoardTasks(ref.watch(taskRepositoryProvider));
});

final createTaskProvider = Provider<CreateTask>((ref) {
  return CreateTask(ref.watch(taskRepositoryProvider));
});

final updateTaskProvider = Provider<UpdateTask>((ref) {
  return UpdateTask(ref.watch(taskRepositoryProvider));
});

final addSubtaskProvider = Provider<AddSubtaskUseCase>((ref) {
  return AddSubtaskUseCase(ref.watch(taskRepositoryProvider));
});

final toggleSubtaskProvider = Provider<ToggleSubtaskUseCase>((ref) {
  return ToggleSubtaskUseCase(ref.watch(taskRepositoryProvider));
});

final reorderSubtasksProvider = Provider<ReorderSubtasksUseCase>((ref) {
  return ReorderSubtasksUseCase(ref.watch(taskRepositoryProvider));
});

final updateTaskTypeProvider = Provider<UpdateTaskTypeUseCase>((ref) {
  return UpdateTaskTypeUseCase(ref.watch(taskRepositoryProvider));
});

final updateTaskPeriodProvider = Provider<UpdateTaskPeriodUseCase>((ref) {
  return UpdateTaskPeriodUseCase(ref.watch(taskRepositoryProvider));
});

final deleteTaskProvider = Provider<DeleteTask>((ref) {
  return DeleteTask(ref.watch(taskRepositoryProvider));
});

final boardTasksProvider = StreamProvider.autoDispose
    .family<List<TaskEntity>, String>((ref, boardId) {
      return ref.watch(watchBoardTasksProvider).call(boardId);
    });

final taskSubtasksProvider = Provider.autoDispose
    .family<List<TaskEntity>, ({String boardId, String taskId})>((ref, args) {
      final tasks =
          ref.watch(boardTasksProvider(args.boardId)).asData?.value ??
          const <TaskEntity>[];
      return tasks
          .where((task) => task.parentTaskId == args.taskId)
          .toList(growable: false);
    });
