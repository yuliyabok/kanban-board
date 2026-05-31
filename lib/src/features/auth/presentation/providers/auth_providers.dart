import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/providers/core_providers.dart';
import '../../../../core/network/api_client.dart';
import '../../../users/data/datasources/user_local_datasource.dart';
import '../../data/datasources/auth_local_datasource.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/default_auth_repository.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/refresh_session.dart';
import '../../domain/usecases/register_account.dart';
import '../../domain/usecases/restore_session.dart';
import '../../domain/usecases/sign_in.dart';
import '../../domain/usecases/sign_out.dart';
import '../controllers/auth_controller.dart';

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  return SecureAuthLocalDataSource(ref.watch(secureStorageProvider));
});

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return LocalAuthRemoteDataSource(
    storage: ref.watch(secureStorageProvider),
    userLocalDataSource: DriftUserLocalDataSource(
      ref.watch(appDatabaseProvider),
    ),
    uuid: const Uuid(),
  );
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return DefaultAuthRepository(
    localDataSource: ref.watch(authLocalDataSourceProvider),
    remoteDataSource: ref.watch(authRemoteDataSourceProvider),
  );
});

final restoreSessionProvider = Provider<RestoreSession>((ref) {
  return RestoreSession(ref.watch(authRepositoryProvider));
});

final signInProvider = Provider<SignIn>((ref) {
  return SignIn(ref.watch(authRepositoryProvider));
});

final registerAccountProvider = Provider<RegisterAccount>((ref) {
  return RegisterAccount(ref.watch(authRepositoryProvider));
});

final signOutProvider = Provider<SignOut>((ref) {
  return SignOut(ref.watch(authRepositoryProvider));
});

final refreshSessionProvider = Provider<RefreshSession>((ref) {
  return RefreshSession(ref.watch(authRepositoryProvider));
});

final authApiClientProvider = Provider<ApiClient>((ref) {
  final config = ref.watch(appConfigProvider);
  final authState = ref.watch(authControllerProvider);
  final refreshSession = ref.watch(refreshSessionProvider);

  return DioApiClient(
    config,
    accessTokenResolver: () async {
      return authState.when(
        data: (session) => session?.accessToken,
        loading: () => null,
        error: (_, __) => null,
      );
    },
    refreshTokenHandler: () async {
      final session = authState.maybeWhen(
        data: (value) => value,
        orElse: () => null,
      );
      if (session == null) {
        return null;
      }

      final result = await refreshSession(session);
      return result.fold(
        onSuccess: (refreshedSession) => refreshedSession.accessToken,
        onFailure: (_) => null,
      );
    },
    onUnauthorized: () async {
      await ref.read(authControllerProvider.notifier).signOut();
    },
  );
});
