import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/core_providers.dart';
import '../../../tasks/presentation/providers/task_providers.dart';
import '../../data/datasources/task_type_local_datasource.dart';
import '../../data/datasources/task_type_remote_datasource.dart';
import '../../data/repositories/offline_first_task_type_repository.dart';
import '../../domain/entities/task_type_entity.dart';
import '../../domain/repositories/task_type_repository.dart';
import '../../domain/usecases/create_task_type.dart';
import '../../domain/usecases/update_task_type_entity.dart';
import '../../domain/usecases/watch_task_types.dart';

final taskTypeLocalDataSourceProvider = Provider<TaskTypeLocalDataSource>((
  ref,
) {
  return DriftTaskTypeLocalDataSource(ref.watch(appDatabaseProvider));
});

final taskTypeRemoteDataSourceProvider = Provider<TaskTypeRemoteDataSource>((
  ref,
) {
  return const LocalTaskTypeRemoteDataSource();
});

final taskTypeRepositoryProvider = Provider<TaskTypeRepository>((ref) {
  return OfflineFirstTaskTypeRepository(
    localDataSource: ref.watch(taskTypeLocalDataSourceProvider),
    remoteDataSource: ref.watch(taskTypeRemoteDataSourceProvider),
    uuid: ref.watch(uuidProvider),
  );
});

final watchTaskTypesProvider = Provider<WatchTaskTypesUseCase>((ref) {
  return WatchTaskTypesUseCase(ref.watch(taskTypeRepositoryProvider));
});

final createTaskTypeProvider = Provider<CreateTaskTypeUseCase>((ref) {
  return CreateTaskTypeUseCase(ref.watch(taskTypeRepositoryProvider));
});

final updateTaskTypeEntityProvider = Provider<UpdateTaskTypeEntityUseCase>((
  ref,
) {
  return UpdateTaskTypeEntityUseCase(ref.watch(taskTypeRepositoryProvider));
});

final taskTypesProvider = StreamProvider.autoDispose
    .family<List<TaskTypeEntity>, String>((ref, boardId) {
      return ref.watch(watchTaskTypesProvider).call(boardId);
    });
