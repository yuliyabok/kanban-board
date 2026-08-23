// Провайдеры досок: собирают локальное хранилище, remote datasource и use cases.
// Remote datasource выбирается по `AppConfig.remoteMode`.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/providers/core_providers.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../data/datasources/board_local_datasource.dart';
import '../../data/datasources/board_remote_datasource.dart';
import '../../data/repositories/offline_first_board_repository.dart';
import '../../domain/entities/board_entity.dart';
import '../../domain/repositories/board_repository.dart';
import '../../domain/usecases/create_board.dart';
import '../../domain/usecases/watch_boards.dart';

final boardLocalDataSourceProvider = Provider<BoardLocalDataSource>(
  (ref) => DriftBoardLocalDataSource(ref.watch(appDatabaseProvider)),
);

final boardRemoteDataSourceProvider = Provider<BoardRemoteDataSource>(
  (ref) {
    final config = ref.watch(appConfigProvider);
    if (config.usesServerRemote) {
      return ApiBoardRemoteDataSource(ref.watch(apiClientProvider));
    }

    return const LocalBoardRemoteDataSource();
  },
);

final boardRepositoryProvider = Provider<BoardRepository>(
  (ref) => OfflineFirstBoardRepository(
    localDataSource: ref.watch(boardLocalDataSourceProvider),
    remoteDataSource: ref.watch(boardRemoteDataSourceProvider),
    syncOutbox: ref.watch(syncOutboxProvider),
    uuid: const Uuid(),
  ),
);

final watchBoardsUseCaseProvider = Provider<WatchBoards>(
  (ref) => WatchBoards(ref.watch(boardRepositoryProvider)),
);

final createBoardProvider = Provider<CreateBoard>(
  (ref) => CreateBoard(ref.watch(boardRepositoryProvider)),
);

final watchBoardsProvider = StreamProvider.autoDispose<List<BoardEntity>>(
  (ref) {
    final session = ref
        .watch(authControllerProvider)
        .maybeWhen(
          data: (value) => value,
          orElse: () => null,
        );
    if (session == null) return const Stream.empty();
    return ref.watch(watchBoardsUseCaseProvider).visibleToUser(session.userId);
  },
);
