import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../users/presentation/providers/user_providers.dart';
import '../../domain/entities/task_comment_entity.dart';

class CommentItem extends ConsumerWidget {
  const CommentItem({
    required this.comment,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  final TaskCommentEntity comment;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final author = ref.watch(userByIdProvider(comment.authorId));
    final authorName = author.maybeWhen(
      data: (user) => user?.fullName ?? comment.authorId,
      orElse: () => comment.authorId,
    );
    final position = author.maybeWhen(
      data: (user) => user?.position,
      orElse: () => null,
    );
    final initials = authorName.trim().isEmpty
        ? '?'
        : authorName.trim().characters.first.toUpperCase();

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        child: Text(initials),
      ),
      title: Text(
        authorName,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (position?.trim().isNotEmpty ?? false) Text(position!),
          Text(comment.content),
          const SizedBox(height: 4),
          Text(
            'Обновлено ${comment.updatedAt.toLocal()}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      trailing: PopupMenuButton<String>(
        onSelected: (value) {
          if (value == 'edit') onEdit();
          if (value == 'delete') onDelete();
        },
        itemBuilder: (context) => const [
          PopupMenuItem(value: 'edit', child: Text('Редактировать')),
          PopupMenuItem(value: 'delete', child: Text('Удалить')),
        ],
      ),
    );
  }
}
