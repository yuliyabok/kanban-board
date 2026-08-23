import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../domain/entities/board_card_settings.dart';
import '../../domain/repositories/board_settings_repository.dart';
import '../datasources/board_card_settings_local_datasource.dart';
import '../mappers/board_card_settings_mapper.dart';

final class LocalBoardSettingsRepository implements BoardSettingsRepository {
  const LocalBoardSettingsRepository(this._localDataSource);

  final BoardCardSettingsLocalDataSource _localDataSource;

  @override
  Future<BoardCardSettings> getCardSettings(String boardId) async {
    final row = await _localDataSource.get(boardId);
    if (row == null) {
      final defaults = BoardCardSettings.defaults(boardId);
      await _localDataSource.upsert(defaults.toCompanion());
      return defaults;
    }
    return row.toEntity();
  }

  @override
  Stream<BoardCardSettings> watchCardSettings(String boardId) async* {
    await getCardSettings(boardId);
    yield* _localDataSource
        .watch(boardId)
        .map(
          (row) => row?.toEntity() ?? BoardCardSettings.defaults(boardId),
        );
  }

  @override
  Future<Result<BoardCardSettings>> updateCardSettings(
    BoardCardSettings settings,
  ) async {
    try {
      final updated = settings.copyWith(updatedAt: DateTime.now().toUtc());
      await _localDataSource.upsert(updated.toCompanion());
      return Success(updated);
    } on Exception catch (error) {
      return Error(StorageFailure(error.toString()));
    }
  }
}
