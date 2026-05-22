import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/domain/entities/auth_session.dart';
import '../../features/auth/presentation/controllers/auth_controller.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/boards/presentation/pages/boards_page.dart';
import '../../features/tasks/presentation/pages/tasks_page.dart';
import 'app_routes.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authNotifier = ref.watch(authRouterNotifierProvider);

  return GoRouter(
    initialLocation: AppRoute.boards.path,
    refreshListenable: authNotifier,
    redirect: (context, state) {
      final isLoggingIn = state.matchedLocation == AppRoute.login.path;
      final authState = authNotifier.authState;

      return switch (authState) {
        AsyncLoading<AuthSession?>() => null,
        AsyncError<AuthSession?>() => isLoggingIn ? null : AppRoute.login.path,
        AsyncData<AuthSession?>(:final value) => switch (value) {
          null => isLoggingIn ? null : AppRoute.login.path,
          _ => isLoggingIn ? AppRoute.boards.path : null,
        },
      };
    },
    routes: [
      GoRoute(
        path: AppRoute.login.path,
        name: AppRoute.login.name,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoute.boards.path,
        name: AppRoute.boards.name,
        builder: (context, state) => const BoardsPage(),
      ),
      GoRoute(
        path: AppRoute.boardTasks.path,
        name: AppRoute.boardTasks.name,
        builder: (context, state) => TasksPage(
          boardId: state.pathParameters['boardId']!,
        ),
      ),
    ],
  );
});

final authRouterNotifierProvider = Provider<AuthRouterNotifier>((ref) {
  final notifier = AuthRouterNotifier(ref.read(authControllerProvider));

  ref
    ..listen<AsyncValue<AuthSession?>>(
      authControllerProvider,
      (previous, next) => notifier.authState = next,
    )
    ..onDispose(notifier.dispose);

  return notifier;
});

final class AuthRouterNotifier extends ChangeNotifier {
  AuthRouterNotifier(this._authState);

  AsyncValue<AuthSession?> _authState;

  AsyncValue<AuthSession?> get authState => _authState;

  set authState(AsyncValue<AuthSession?> value) {
    _authState = value;
    notifyListeners();
  }
}
