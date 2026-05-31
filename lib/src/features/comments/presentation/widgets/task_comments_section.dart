import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/controllers/auth_controller.dart';
import '../providers/task_comment_providers.dart';
import 'comment_input.dart';
import 'comment_item.dart';
import 'delete_comment_confirmation.dart';
import 'edit_comment_dialog.dart';

class TaskCommentsSection extends ConsumerWidget {
  const TaskCommentsSection({required this.taskId, super.key});

  final String taskId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final comments = ref.watch(taskCommentsProvider(taskId));
    final session = ref
        .watch(authControllerProvider)
        .maybeWhen(data: (value) => value, orElse: () => null);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Комментарии', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        comments.when(
          loading: () => const LinearProgressIndicator(),
          error: (error, stackTrace) => Text(error.toString()),
          data: (items) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (items.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Комментариев пока нет.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              for (final comment in items)
                CommentItem(
                  comment: comment,
                  onEdit: () async {
                    final updated = await showDialog<String>(
                      context: context,
                      builder: (context) =>
                          EditCommentDialog(initialContent: comment.content),
                    );
                    if (updated == null || session == null) return;
                    await ref
                        .read(updateTaskCommentUseCaseProvider)
                        .call(
                          id: comment.id,
                          actorUserId: session.userId,
                          content: updated,
                        );
                  },
                  onDelete: () async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (context) => const DeleteCommentConfirmation(),
                    );
                    if (!(confirmed ?? false) || session == null) return;
                    await ref
                        .read(deleteTaskCommentUseCaseProvider)
                        .call(
                          id: comment.id,
                          actorUserId: session.userId,
                        );
                  },
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        CommentInput(
          onSubmit: session == null
              ? (_) {}
              : (content) async {
                  final result = await ref
                      .read(createTaskCommentUseCaseProvider)
                      .call(
                        taskId: taskId,
                        authorId: session.userId,
                        content: content,
                      );
                  if (!context.mounted) return;
                  result.fold(
                    onSuccess: (_) {},
                    onFailure: (failure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(failure.message)),
                      );
                    },
                  );
                },
        ),
      ],
    );
  }
}
