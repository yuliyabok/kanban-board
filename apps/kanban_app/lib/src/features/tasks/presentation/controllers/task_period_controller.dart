import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/result.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/value_objects/task_enums.dart';
import '../providers/task_providers.dart';

final taskPeriodControllerProvider =
    AsyncNotifierProvider<TaskPeriodController, void>(
      TaskPeriodController.new,
      isAutoDispose: true,
    );

class TaskPeriodController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> updatePeriod({
    required TaskEntity task,
    required TaskPeriodType periodType,
    DateTime? startDate,
    DateTime? dueDate,
  }) async {
    state = const AsyncLoading();
    final result = await ref
        .read(updateTaskPeriodProvider)
        .call(
          task: task,
          periodType: periodType,
          startDate: startDate,
          dueDate: dueDate,
          actorUserId: _currentUserId(),
        );
    state = switch (result) {
      Success<TaskEntity>() => const AsyncData(null),
      Error<TaskEntity>(:final failure) => AsyncError(
        failure,
        StackTrace.current,
      ),
    };
  }

  String? _currentUserId() {
    return ref
        .read(authControllerProvider)
        .maybeWhen(data: (session) => session?.userId, orElse: () => null);
  }
}
