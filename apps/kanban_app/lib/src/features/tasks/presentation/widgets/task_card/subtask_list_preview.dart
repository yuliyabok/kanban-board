import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_theme.dart';
import '../../../domain/entities/task_entity.dart';

class SubtaskListPreview extends StatelessWidget {
  const SubtaskListPreview({
    required this.subtasks,
    required this.onToggle,
    super.key,
  });

  final List<TaskEntity> subtasks;
  final ValueChanged<TaskEntity> onToggle;

  @override
  Widget build(BuildContext context) {
    if (subtasks.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        for (final subtask in subtasks.take(3))
          CheckboxListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            value: subtask.isCompleted,
            onChanged: (_) => onToggle(subtask),
            title: Text(
              subtask.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        if (subtasks.length > 3)
          Padding(
            padding: EdgeInsets.only(top: context.spacing.xs),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '+${subtasks.length - 3} еще',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
      ],
    );
  }
}
