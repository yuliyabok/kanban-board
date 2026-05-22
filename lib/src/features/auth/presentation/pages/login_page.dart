import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/auth_controller.dart';
import '../widgets/login_form.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);

    ref.listen(authControllerProvider, (previous, next) {
      if (next case AsyncError(:final error)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.toString())),
        );
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: LoginForm(
                isLoading: authState.isLoading,
                onSignIn: (email, password) {
                  unawaited(
                    ref
                        .read(authControllerProvider.notifier)
                        .signIn(
                          email: email,
                          password: password,
                        ),
                  );
                },
                onRegister: (email, password, displayName) {
                  unawaited(
                    ref
                        .read(authControllerProvider.notifier)
                        .register(
                          email: email,
                          password: password,
                          displayName: displayName,
                        ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
