import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/providers/core_providers.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../data/datasources/workspace_local_datasource.dart';
import '../../data/repositories/default_workspace_repository.dart';
import '../../domain/entities/workspace_entity.dart';
import '../../domain/repositories/workspace_repository.dart';
import '../../domain/usecases/workspace_usecases.dart';

final workspaceLocalDataSourceProvider = Provider<WorkspaceLocalDataSource>(
  (ref) => DriftWorkspaceLocalDataSource(ref.watch(appDatabaseProvider)),
);

final workspaceMemberLocalDataSourceProvider =
    Provider<WorkspaceMemberLocalDataSource>(
      (ref) =>
          DriftWorkspaceMemberLocalDataSource(ref.watch(appDatabaseProvider)),
    );

final workspaceRepositoryProvider = Provider<WorkspaceRepository>(
  (ref) => DefaultWorkspaceRepository(
    localDataSource: ref.watch(workspaceLocalDataSourceProvider),
    memberLocalDataSource: ref.watch(workspaceMemberLocalDataSourceProvider),
    uuid: const Uuid(),
  ),
);

final workspaceMemberRepositoryProvider = Provider<WorkspaceMemberRepository>(
  (ref) => DefaultWorkspaceMemberRepository(
    ref.watch(workspaceMemberLocalDataSourceProvider),
  ),
);

final createWorkspaceUseCaseProvider = Provider<CreateWorkspaceUseCase>(
  (ref) => CreateWorkspaceUseCase(ref.watch(workspaceRepositoryProvider)),
);

final workspaceControllerProvider =
    AsyncNotifierProvider<WorkspaceController, void>(
      WorkspaceController.new,
      isAutoDispose: true,
    );

final workspacesProvider = StreamProvider.autoDispose<List<WorkspaceEntity>>(
  (ref) => ref.watch(workspaceRepositoryProvider).watchAll(),
);

final selectedWorkspaceProvider =
    NotifierProvider<SelectedWorkspaceController, String?>(
      SelectedWorkspaceController.new,
    );

final class SelectedWorkspaceController extends Notifier<String?> {
  String? _selected;

  @override
  String? build() {
    final workspaces = ref
        .watch(workspacesProvider)
        .maybeWhen(
          data: (value) => value,
          orElse: () => const <WorkspaceEntity>[],
        );
    if (_selected != null && workspaces.any((item) => item.id == _selected)) {
      return _selected;
    }
    return _selected = workspaces.firstOrNull?.id;
  }

  String? get selected => _selected;

  set selected(String? workspaceId) {
    _selected = workspaceId;
    state = workspaceId;
  }
}

final workspaceMembersProvider = StreamProvider.autoDispose
    .family<List<WorkspaceMemberEntity>, String>(
      (ref, workspaceId) => ref
          .watch(workspaceMemberRepositoryProvider)
          .watchByWorkspace(workspaceId),
    );

final class WorkspaceController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> create(String name) async {
    final session = ref
        .read(authControllerProvider)
        .maybeWhen(
          data: (value) => value,
          orElse: () => null,
        );
    if (session == null) return;
    state = const AsyncLoading();
    final result = await ref
        .read(createWorkspaceUseCaseProvider)
        .call(name: name, ownerId: session.userId);
    state = result.fold(
      onSuccess: (_) => const AsyncData(null),
      onFailure: (failure) => AsyncError(failure, StackTrace.current),
    );
  }
}
