import 'package:flutter/material.dart';

import '../../../domain/entities/task_entity.dart';

class SubtaskList extends StatelessWidget {
  const SubtaskList({
    required this.subtasks,
    required this.onToggle,
    super.key,
  });

  final List<TaskEntity> subtasks;
  final ValueChanged<TaskEntity> onToggle;

  @override
  Widget build(BuildContext context) {
    if (subtasks.isEmpty) {
      return Text(
        'Подзадач пока нет',
        style: Theme.of(context).textTheme.bodySmall,
      );
    }

    return Column(
      children: [
        for (final subtask in subtasks)
          CheckboxListTile(
            value: subtask.isCompleted,
            onChanged: (_) => onToggle(subtask),
            title: Text(subtask.title),
            dense: true,
            contentPadding: EdgeInsets.zero,
          ),
      ],
    );
  }
}
