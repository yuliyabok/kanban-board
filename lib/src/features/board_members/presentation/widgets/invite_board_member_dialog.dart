import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../invitations/domain/entities/invitation_entity.dart';
import '../../../invitations/presentation/providers/invitation_providers.dart';
import '../../../permissions/domain/entities/permission.dart';

class InviteBoardMemberDialog extends ConsumerStatefulWidget {
  const InviteBoardMemberDialog({required this.boardId, super.key});

  final String boardId;

  @override
  ConsumerState<InviteBoardMemberDialog> createState() =>
      _InviteBoardMemberDialogState();
}

class _InviteBoardMemberDialogState
    extends ConsumerState<InviteBoardMemberDialog> {
  final _emailController = TextEditingController();
  BoardRole _role = BoardRole.editor;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Пригласить на доску'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<BoardRole>(
            initialValue: _role,
            items: [
              for (final role in BoardRole.values)
                DropdownMenuItem(value: role, child: Text(role.name)),
            ],
            onChanged: (role) => setState(() => _role = role ?? _role),
            decoration: const InputDecoration(labelText: 'Роль'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Отмена'),
        ),
        FilledButton(
          onPressed: () async {
            final session = ref
                .read(authControllerProvider)
                .maybeWhen(data: (value) => value, orElse: () => null);
            if (session == null) return;
            final now = DateTime.now().toUtc();
            await ref
                .read(createInvitationUseCaseProvider)
                .call(
                  InvitationEntity(
                    id: const Uuid().v7(),
                    email: _emailController.text,
                    boardId: widget.boardId,
                    role: _role.name,
                    token: const Uuid().v7(),
                    invitedBy: session.userId,
                    expiresAt: now.add(const Duration(days: 7)),
                    createdAt: now,
                  ),
                );
            if (context.mounted) Navigator.of(context).pop();
          },
          child: const Text('Пригласить'),
        ),
      ],
    );
  }
}
