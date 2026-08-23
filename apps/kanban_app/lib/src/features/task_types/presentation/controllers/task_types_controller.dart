import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/result.dart';
import '../../domain/entities/task_type_entity.dart';
import '../providers/task_type_providers.dart';

final taskTypesControllerProvider =
    AsyncNotifierProvider<TaskTypesController, void>(
      TaskTypesController.new,
      isAutoDispose: true,
    );

class TaskTypesController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> create({
    required String boardId,
    required String name,
    required String color,
    required String icon,
    String? description,
  }) async {
    state = const AsyncLoading();
    final result = await ref
        .read(createTaskTypeProvider)
        .call(
          boardId: boardId,
          name: name,
          color: color,
          icon: icon,
          description: description,
        );
    state = _toAsyncValue(result);
  }

  Future<void> updateType(TaskTypeEntity type) async {
    state = const AsyncLoading();
    final result = await ref.read(updateTaskTypeEntityProvider).call(type);
    state = _toAsyncValue(result);
  }

  Future<void> delete(String id) async {
    state = const AsyncLoading();
    final result = await ref.read(taskTypeRepositoryProvider).delete(id);
    state = _toAsyncValue(result);
  }

  AsyncValue<void> _toAsyncValue<T>(Result<T> result) {
    return switch (result) {
      Success<T>() => const AsyncData(null),
      Error<T>(:final failure) => AsyncError(failure, StackTrace.current),
    };
  }
}
