import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/result.dart';
import '../../domain/entities/board_card_settings.dart';
import '../providers/board_card_settings_providers.dart';

final boardCardSettingsControllerProvider =
    AsyncNotifierProvider<BoardCardSettingsController, void>(
      BoardCardSettingsController.new,
      isAutoDispose: true,
    );

class BoardCardSettingsController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> saveSettings(BoardCardSettings settings) async {
    state = const AsyncLoading();
    final result = await ref
        .read(updateBoardCardSettingsProvider)
        .call(settings);
    state = switch (result) {
      Success<BoardCardSettings>() => const AsyncData(null),
      Error<BoardCardSettings>(:final failure) => AsyncError(
        failure,
        StackTrace.current,
      ),
    };
  }
}
