import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/result.dart';
import '../../domain/entities/auth_credentials.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/entities/registration_data.dart';
import '../providers/auth_providers.dart';

final authControllerProvider =
    AsyncNotifierProvider<AuthController, AuthSession?>(
      AuthController.new,
    );

class AuthController extends AsyncNotifier<AuthSession?> {
  @override
  Future<AuthSession?> build() async {
    final result = await ref.watch(restoreSessionProvider).call();
    return result.fold(
      onSuccess: (session) => session,
      onFailure: (failure) => throw failure,
    );
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    final result = await ref
        .read(signInProvider)
        .call(
          AuthCredentials(email: email, password: password),
        );

    state = switch (result) {
      Success<AuthSession>(:final value) => AsyncData(value),
      Error<AuthSession>(:final failure) => AsyncError(
        failure,
        StackTrace.current,
      ),
    };
  }

  Future<void> register({
    required String email,
    required String password,
    String? displayName,
  }) async {
    state = const AsyncLoading();
    final result = await ref
        .read(registerAccountProvider)
        .call(
          RegistrationData(
            email: email,
            password: password,
            displayName: displayName,
          ),
        );

    state = switch (result) {
      Success<AuthSession>(:final value) => AsyncData(value),
      Error<AuthSession>(:final failure) => AsyncError(
        failure,
        StackTrace.current,
      ),
    };
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    final result = await ref.read(signOutProvider).call();
    state = switch (result) {
      Success<void>() => const AsyncData(null),
      Error<void>(:final failure) => AsyncError(failure, StackTrace.current),
    };
  }
}
