import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/providers/core_providers.dart';
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
  (ref) => const LocalBoardRemoteDataSource(),
);

final boardRepositoryProvider = Provider<BoardRepository>(
  (ref) => OfflineFirstBoardRepository(
    localDataSource: ref.watch(boardLocalDataSourceProvider),
    remoteDataSource: ref.watch(boardRemoteDataSourceProvider),
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
  (ref) => ref.watch(watchBoardsUseCaseProvider).call(),
);
