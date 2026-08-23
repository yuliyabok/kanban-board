import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/core_providers.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../data/datasources/user_local_datasource.dart';
import '../../data/datasources/user_remote_datasource.dart';
import '../../data/repositories/default_user_repository.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/usecases/user_usecases.dart';

final userLocalDataSourceProvider = Provider<UserLocalDataSource>(
  (ref) => DriftUserLocalDataSource(ref.watch(appDatabaseProvider)),
);

final userRemoteDataSourceProvider = Provider<UserRemoteDataSource>((ref) {
  final config = ref.watch(appConfigProvider);
  if (config.usesServerRemote) {
    return ApiUserRemoteDataSource(ref.watch(apiClientProvider));
  }
  return const MockUserRemoteDataSource();
});

final userRepositoryProvider = Provider<UserRepository>(
  (ref) => DefaultUserRepository(
    localDataSource: ref.watch(userLocalDataSourceProvider),
    remoteDataSource: ref.watch(userRemoteDataSourceProvider),
    usesServerRemote: ref.watch(appConfigProvider).usesServerRemote,
  ),
);

final searchUsersUseCaseProvider = Provider<SearchUsersUseCase>(
  (ref) => SearchUsersUseCase(ref.watch(userRepositoryProvider)),
);

final updateCurrentUserUseCaseProvider = Provider<UpdateCurrentUserUseCase>(
  (ref) => UpdateCurrentUserUseCase(ref.watch(userRepositoryProvider)),
);

final currentUserProvider = FutureProvider<UserEntity?>((ref) async {
  final session = ref
      .watch(authControllerProvider)
      .maybeWhen(data: (value) => value, orElse: () => null);
  if (session == null) return null;
  final result = await ref
      .watch(userRepositoryProvider)
      .getById(session.userId);
  return result.fold(onSuccess: (user) => user, onFailure: (_) => null);
});

final userByIdProvider = FutureProvider.autoDispose.family<UserEntity?, String>(
  (ref, userId) async {
    final result = await ref.watch(userRepositoryProvider).getById(userId);
    return result.fold(onSuccess: (user) => user, onFailure: (_) => null);
  },
);

final userSearchProvider = FutureProvider.autoDispose
    .family<List<UserEntity>, String>((ref, query) async {
      final result = await ref.watch(searchUsersUseCaseProvider).call(query);
      return result.fold(
        onSuccess: (users) => users,
        onFailure: (_) => const <UserEntity>[],
      );
    });

final userProfileControllerProvider =
    AsyncNotifierProvider<UserProfileController, void>(
      UserProfileController.new,
      isAutoDispose: true,
    );

final class UserProfileController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> saveProfile(UserEntity user) async {
    state = const AsyncLoading();
    final result = await ref.read(updateCurrentUserUseCaseProvider).call(user);
    state = result.fold(
      onSuccess: (_) {
        ref.invalidate(currentUserProvider);
        return const AsyncData(null);
      },
      onFailure: (failure) => AsyncError(failure, StackTrace.current),
    );
  }
}
