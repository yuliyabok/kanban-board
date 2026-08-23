import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

final class WatchBoardTasks {
  const WatchBoardTasks(this._repository);

  final TaskRepository _repository;

  Stream<List<TaskEntity>> call(String boardId) {
    return _repository.watchByBoard(boardId);
  }
}
