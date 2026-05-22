import '../../../../core/error/result.dart';
import '../repositories/task_repository.dart';

final class DeleteTask {
  const DeleteTask(this._repository);

  final TaskRepository _repository;

  Future<Result<void>> call(String taskId, {bool cascade = true}) {
    return _repository.delete(taskId, cascade: cascade);
  }
}
