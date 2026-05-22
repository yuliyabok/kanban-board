import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/core_providers.dart';
import '../../../tasks/presentation/providers/task_providers.dart';
import '../../data/datasources/column_local_datasource.dart';
import '../../data/datasources/column_remote_datasource.dart';
import '../../data/repositories/offline_first_column_repository.dart';
import '../../domain/entities/board_column_entity.dart';
import '../../domain/repositories/column_repository.dart';
import '../../domain/usecases/create_column.dart';
import '../../domain/usecases/delete_column.dart';
import '../../domain/usecases/reorder_columns.dart';
import '../../domain/usecases/update_column_title.dart';
import '../../domain/usecases/watch_board_columns.dart';

final columnLocalDataSourceProvider = Provider<ColumnLocalDataSource>((ref) {
  return DriftColumnLocalDataSource(ref.watch(appDatabaseProvider));
});

final columnRemoteDataSourceProvider = Provider<ColumnRemoteDataSource>((ref) {
  return const LocalColumnRemoteDataSource();
});

final columnRepositoryProvider = Provider<ColumnRepository>((ref) {
  return OfflineFirstColumnRepository(
    localDataSource: ref.watch(columnLocalDataSourceProvider),
    remoteDataSource: ref.watch(columnRemoteDataSourceProvider),
    uuid: ref.watch(uuidProvider),
  );
});

final watchBoardColumnsProvider = Provider<WatchBoardColumns>((ref) {
  return WatchBoardColumns(ref.watch(columnRepositoryProvider));
});

final createColumnProvider = Provider<CreateColumnUseCase>((ref) {
  return CreateColumnUseCase(ref.watch(columnRepositoryProvider));
});

final updateColumnTitleProvider = Provider<UpdateColumnTitleUseCase>((ref) {
  return UpdateColumnTitleUseCase(ref.watch(columnRepositoryProvider));
});

final deleteColumnProvider = Provider<DeleteColumnUseCase>((ref) {
  return DeleteColumnUseCase(ref.watch(columnRepositoryProvider));
});

final reorderColumnsProvider = Provider<ReorderColumnsUseCase>((ref) {
  return ReorderColumnsUseCase(ref.watch(columnRepositoryProvider));
});

final boardColumnsProvider = StreamProvider.autoDispose
    .family<List<BoardColumnEntity>, String>((ref, boardId) {
      return ref.watch(watchBoardColumnsProvider).call(boardId);
    });
