import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../domain/entities/board_entity.dart';
import '../providers/board_providers.dart';

final boardsControllerProvider = AsyncNotifierProvider<BoardsController, void>(
  BoardsController.new,
  isAutoDispose: true,
);

class BoardsController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> create({
    required String title,
    String? description,
    String? workspaceId,
  }) async {
    final session = ref
        .read(authControllerProvider)
        .maybeWhen(
          data: (value) => value,
          orElse: () => null,
        );
    if (session == null) {
      state = AsyncError(
        const UnexpectedFailure('Нельзя создать доску без активной сессии'),
        StackTrace.current,
      );
      return;
    }

    state = const AsyncLoading();
    final now = DateTime.now().toUtc();
    final result = await ref
        .read(createBoardProvider)
        .call(
          BoardEntity(
            id: '',
            ownerId: session.userId,
            workspaceId: workspaceId,
            title: title,
            description: description,
            createdAt: now,
            updatedAt: now,
          ),
        );

    state = switch (result) {
      Success<BoardEntity>() => const AsyncData(null),
      Error<BoardEntity>(:final failure) => AsyncError(
        failure,
        StackTrace.current,
      ),
    };
  }
}
