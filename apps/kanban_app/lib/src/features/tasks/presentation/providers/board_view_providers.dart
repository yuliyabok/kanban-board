import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../board_settings/presentation/providers/board_card_settings_providers.dart';
import '../../../columns/presentation/providers/column_providers.dart';
import '../../../task_types/presentation/providers/task_type_providers.dart';
import '../../application/queries/board_view_query.dart';
import '../../application/services/board_task_projection_service.dart';
import '../../application/state/board_view_state.dart';
import 'task_providers.dart';

final boardTaskProjectionServiceProvider = Provider<BoardTaskProjectionService>(
  (ref) {
    return const BoardTaskProjectionService();
  },
);

final boardViewQueryProvider = Provider<BoardViewQuery>((ref) {
  return DefaultBoardViewQuery(
    taskRepository: ref.watch(taskRepositoryProvider),
    columnRepository: ref.watch(columnRepositoryProvider),
    boardSettingsRepository: ref.watch(boardSettingsRepositoryProvider),
    taskTypeRepository: ref.watch(taskTypeRepositoryProvider),
    projectionService: ref.watch(boardTaskProjectionServiceProvider),
  );
});

final boardViewProvider = StreamProvider.autoDispose
    .family<BoardViewState, BoardViewArgs>((ref, args) {
      return ref.watch(boardViewQueryProvider).watch(args);
    });
