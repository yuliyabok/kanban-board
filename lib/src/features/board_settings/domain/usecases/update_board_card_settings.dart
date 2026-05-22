import '../../../../core/error/result.dart';
import '../entities/board_card_settings.dart';
import '../repositories/board_settings_repository.dart';

final class UpdateBoardCardSettingsUseCase {
  const UpdateBoardCardSettingsUseCase(this._repository);

  final BoardSettingsRepository _repository;

  Future<Result<BoardCardSettings>> call(BoardCardSettings settings) {
    return _repository.updateCardSettings(settings);
  }
}
