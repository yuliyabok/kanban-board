import '../../../../core/error/result.dart';
import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';
import '../value_objects/task_enums.dart';

final class UpdateTaskPeriodUseCase {
  const UpdateTaskPeriodUseCase(this._repository);

  final TaskRepository _repository;

  Future<Result<TaskEntity>> call({
    required TaskEntity task,
    required TaskPeriodType periodType,
    DateTime? startDate,
    DateTime? dueDate,
    int? estimatedDurationMinutes,
    String? actorUserId,
  }) {
    return _repository.update(
      task.copyWith(
        periodType: periodType,
        startDate: startDate,
        dueDate: dueDate,
        estimatedDurationMinutes: estimatedDurationMinutes,
      ),
      actorUserId: actorUserId,
    );
  }
}
