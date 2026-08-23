import '../../../../core/error/result.dart';
import '../entities/board_card_settings.dart';

abstract interface class BoardSettingsRepository {
  Stream<BoardCardSettings> watchCardSettings(String boardId);

  Future<BoardCardSettings> getCardSettings(String boardId);

  Future<Result<BoardCardSettings>> updateCardSettings(
    BoardCardSettings settings,
  );
}
