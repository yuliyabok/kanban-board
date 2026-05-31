import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/ui/app_back_button.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../providers/invitation_providers.dart';

class AcceptInvitationPage extends ConsumerWidget {
  const AcceptInvitationPage({required this.token, super.key});

  final String token;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref
        .watch(authControllerProvider)
        .maybeWhen(data: (value) => value, orElse: () => null);
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Принять приглашение'),
      ),
      body: Center(
        child: FilledButton.icon(
          onPressed: session == null
              ? null
              : () async {
                  await ref
                      .read(acceptInvitationUseCaseProvider)
                      .call(
                        token: token,
                        userId: session.userId,
                      );
                  if (context.mounted) {
                    await Navigator.of(context).maybePop();
                  }
                },
          icon: const Icon(Icons.check),
          label: const Text('Принять'),
        ),
      ),
    );
  }
}
