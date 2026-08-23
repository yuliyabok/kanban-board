import '../../../../core/error/result.dart';
import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

final class AddSubtaskUseCase {
  const AddSubtaskUseCase(this._repository);

  final TaskRepository _repository;

  Future<Result<TaskEntity>> call({
    required TaskEntity parent,
    required String title,
    String? actorUserId,
  }) {
    return _repository.create(
      boardId: parent.boardId,
      columnId: parent.columnId,
      parentTaskId: parent.id,
      title: title,
      actorUserId: actorUserId,
    );
  }
}
