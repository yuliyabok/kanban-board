import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/ui/app_back_button.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../providers/invitation_providers.dart';
import '../widgets/invitation_status_badge.dart';

class PendingInvitationsPage extends ConsumerWidget {
  const PendingInvitationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invitations = ref.watch(invitationsProvider);
    final session = ref
        .watch(authControllerProvider)
        .maybeWhen(data: (value) => value, orElse: () => null);
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Приглашения'),
      ),
      body: invitations.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        data: (items) {
          if (items.isEmpty) {
            return const Center(child: Text('Нет приглашений'));
          }
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final invitation = items[index];
              return ListTile(
                title: Text(invitation.email),
                subtitle: Text(
                  invitation.boardId ?? invitation.workspaceId ?? '',
                ),
                trailing: Wrap(
                  spacing: 8,
                  children: [
                    InvitationStatusBadge(invitation: invitation),
                    IconButton(
                      tooltip: 'Принять',
                      onPressed: session == null
                          ? null
                          : () => ref
                                .read(acceptInvitationUseCaseProvider)
                                .call(
                                  token: invitation.token,
                                  userId: session.userId,
                                ),
                      icon: const Icon(Icons.check),
                    ),
                    IconButton(
                      tooltip: 'Отклонить',
                      onPressed: () => ref
                          .read(declineInvitationUseCaseProvider)
                          .call(invitation.token),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
