import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/core_providers.dart';
import '../../data/datasources/board_card_settings_local_datasource.dart';
import '../../data/repositories/local_board_settings_repository.dart';
import '../../domain/entities/board_card_settings.dart';
import '../../domain/repositories/board_settings_repository.dart';
import '../../domain/usecases/update_board_card_settings.dart';
import '../../domain/usecases/watch_board_card_settings.dart';

final boardCardSettingsLocalDataSourceProvider =
    Provider<BoardCardSettingsLocalDataSource>((ref) {
      return DriftBoardCardSettingsLocalDataSource(
        ref.watch(appDatabaseProvider),
      );
    });

final boardSettingsRepositoryProvider = Provider<BoardSettingsRepository>((
  ref,
) {
  return LocalBoardSettingsRepository(
    ref.watch(boardCardSettingsLocalDataSourceProvider),
  );
});

final watchBoardCardSettingsProvider = Provider<WatchBoardCardSettingsUseCase>((
  ref,
) {
  return WatchBoardCardSettingsUseCase(
    ref.watch(boardSettingsRepositoryProvider),
  );
});

final updateBoardCardSettingsProvider =
    Provider<UpdateBoardCardSettingsUseCase>((ref) {
      return UpdateBoardCardSettingsUseCase(
        ref.watch(boardSettingsRepositoryProvider),
      );
    });

final boardCardSettingsProvider = StreamProvider.autoDispose
    .family<BoardCardSettings, String>((ref, boardId) {
      return ref.watch(watchBoardCardSettingsProvider).call(boardId);
    });
