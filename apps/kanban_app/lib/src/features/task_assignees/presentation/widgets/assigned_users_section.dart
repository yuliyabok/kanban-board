import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../users/presentation/providers/user_providers.dart';
import '../providers/task_assignee_providers.dart';
import 'assignee_picker.dart';
import 'task_assignee_avatar.dart';

class AssignedUsersSection extends ConsumerWidget {
  const AssignedUsersSection({
    required this.taskId,
    this.editable = true,
    this.showTitle = true,
    super.key,
  });

  final String taskId;
  final bool editable;
  final bool showTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(taskAssigneesProvider(taskId));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showTitle)
          Row(
            children: [
              Expanded(
                child: Text(
                  'Исполнители',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              if (editable)
                IconButton(
                  tooltip: 'Назначить',
                  onPressed: () => showDialog<void>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Назначить исполнителя'),
                      content: SizedBox(
                        width: 420,
                        child: AssigneePicker(taskId: taskId),
                      ),
                    ),
                  ),
                  icon: const Icon(Icons.person_add_alt),
                ),
            ],
          ),
        state.when(
          loading: () => const LinearProgressIndicator(),
          error: (error, stackTrace) => Text(error.toString()),
          data: (assignees) => Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              if (assignees.isEmpty)
                Text(
                  'Пока никто не назначен',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              for (final assignee in assignees)
                editable
                    ? _EditableAssigneeChip(
                        taskId: taskId,
                        userId: assignee.userId,
                      )
                    : _AssigneeAvatar(userId: assignee.userId),
            ],
          ),
        ),
      ],
    );
  }
}

class _AssigneeAvatar extends ConsumerWidget {
  const _AssigneeAvatar({required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref
        .watch(userByIdProvider(userId))
        .maybeWhen(data: (value) => value, orElse: () => null);
    return TaskAssigneeAvatar(
      label: user?.fullName ?? userId,
      avatarUrl: user?.avatarUrl,
    );
  }
}

class _EditableAssigneeChip extends ConsumerWidget {
  const _EditableAssigneeChip({
    required this.taskId,
    required this.userId,
  });

  final String taskId;
  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref
        .watch(userByIdProvider(userId))
        .maybeWhen(
          data: (value) => value,
          orElse: () => null,
        );
    final session = ref
        .watch(authControllerProvider)
        .maybeWhen(
          data: (value) => value,
          orElse: () => null,
        );
    final label = user?.fullName ?? userId;

    return InputChip(
      avatar: TaskAssigneeAvatar(
        label: label,
        avatarUrl: user?.avatarUrl,
        radius: 14,
      ),
      label: Text(label),
      onDeleted: session == null
          ? null
          : () {
              unawaited(
                ref
                    .read(unassignTaskUserUseCaseProvider)
                    .call(
                      taskId: taskId,
                      userId: userId,
                      actorUserId: session.userId,
                    ),
              );
            },
    );
  }
}
