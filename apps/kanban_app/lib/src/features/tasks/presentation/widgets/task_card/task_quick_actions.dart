import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_icons.dart';

class TaskQuickActions extends StatelessWidget {
  const TaskQuickActions({
    required this.onAddSubtask,
    required this.onDelete,
    required this.onDragHandle,
    required this.index,
    super.key,
  });

  final VoidCallback onAddSubtask;
  final VoidCallback onDelete;
  final VoidCallback onDragHandle;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          tooltip: 'Добавить подзадачу',
          onPressed: onAddSubtask,
          icon: const Icon(Icons.account_tree_outlined, size: 18),
        ),
        IconButton(
          tooltip: 'Удалить',
          onPressed: onDelete,
          icon: const Icon(AppIcons.delete, size: 18),
        ),
        ReorderableDragStartListener(
          index: index,
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: Icon(AppIcons.drag, size: 18),
          ),
        ),
      ],
    );
  }
}
