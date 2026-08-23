import '../../../../core/error/result.dart';
import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

final class ReorderSubtasksUseCase {
  const ReorderSubtasksUseCase(this._repository);

  final TaskRepository _repository;

  Future<Result<void>> call(List<TaskEntity> subtasks) async {
    for (var index = 0; index < subtasks.length; index++) {
      final result = await _repository.update(
        subtasks[index].copyWith(position: index),
      );
      if (result case Error(:final failure)) {
        return Error(failure);
      }
    }
    return const Success(null);
  }
}
