import '../entities/board_card_settings.dart';
import '../repositories/board_settings_repository.dart';

final class WatchBoardCardSettingsUseCase {
  const WatchBoardCardSettingsUseCase(this._repository);

  final BoardSettingsRepository _repository;

  Stream<BoardCardSettings> call(String boardId) {
    return _repository.watchCardSettings(boardId);
  }
}
