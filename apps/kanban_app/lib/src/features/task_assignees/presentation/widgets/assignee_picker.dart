import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../users/presentation/providers/user_providers.dart';
import '../providers/task_assignee_providers.dart';

class AssigneePicker extends ConsumerStatefulWidget {
  const AssigneePicker({required this.taskId, super.key});

  final String taskId;

  @override
  ConsumerState<AssigneePicker> createState() => _AssigneePickerState();
}

class _AssigneePickerState extends ConsumerState<AssigneePicker> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(userSearchProvider(_query));
    final session = ref
        .watch(authControllerProvider)
        .maybeWhen(data: (value) => value, orElse: () => null);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Поиск пользователя',
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (value) => setState(() => _query = value),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 280,
          child: users.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(child: Text(error.toString())),
            data: (items) => ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final user = items[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(user.fullName.characters.first.toUpperCase()),
                  ),
                  title: Text(user.fullName),
                  subtitle: Text(user.email),
                  onTap: session == null
                      ? null
                      : () async {
                          await ref
                              .read(assignTaskUserUseCaseProvider)
                              .call(
                                taskId: widget.taskId,
                                userId: user.id,
                                assignedBy: session.userId,
                              );
                          if (context.mounted) Navigator.of(context).pop();
                        },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
