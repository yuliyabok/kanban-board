import '../entities/board_entity.dart';
import '../repositories/board_repository.dart';

final class WatchBoards {
  const WatchBoards(this._repository);

  final BoardRepository _repository;

  Stream<List<BoardEntity>> call() => _repository.watchAll();

  Stream<List<BoardEntity>> visibleToUser(String userId) =>
      _repository.watchVisibleToUser(userId);
}
