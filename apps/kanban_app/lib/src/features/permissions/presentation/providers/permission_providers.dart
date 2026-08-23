import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/core_providers.dart';
import '../../data/repositories/default_permission_repository.dart';
import '../../domain/entities/permission.dart';
import '../../domain/repositories/permission_repository.dart';
import '../../domain/usecases/permission_usecases.dart';

final permissionRepositoryProvider = Provider<PermissionRepository>(
  (ref) => DefaultPermissionRepository(ref.watch(appDatabaseProvider)),
);

final checkBoardPermissionUseCaseProvider = Provider<CheckPermissionUseCase>(
  (ref) => CheckPermissionUseCase(ref.watch(permissionRepositoryProvider)),
);

final permissionProvider = FutureProvider.autoDispose
    .family<bool, ({String userId, String boardId, Permission permission})>((
      ref,
      args,
    ) {
      return ref
          .watch(permissionRepositoryProvider)
          .hasBoardPermission(
            userId: args.userId,
            boardId: args.boardId,
            permission: args.permission,
          );
    });
