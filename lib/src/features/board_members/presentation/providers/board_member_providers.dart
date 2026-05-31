import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/core_providers.dart';
import '../../data/datasources/board_member_local_datasource.dart';
import '../../data/repositories/default_board_member_repository.dart';
import '../../domain/entities/board_member_entity.dart';
import '../../domain/repositories/board_member_repository.dart';

final boardMemberLocalDataSourceProvider = Provider<BoardMemberLocalDataSource>(
  (ref) => DriftBoardMemberLocalDataSource(ref.watch(appDatabaseProvider)),
);

final boardMemberRepositoryProvider = Provider<BoardMemberRepository>(
  (ref) => DefaultBoardMemberRepository(
    ref.watch(boardMemberLocalDataSourceProvider),
  ),
);

final boardMembersProvider = StreamProvider.autoDispose
    .family<List<BoardMemberEntity>, String>(
      (ref, boardId) =>
          ref.watch(boardMemberRepositoryProvider).watchByBoard(boardId),
    );
