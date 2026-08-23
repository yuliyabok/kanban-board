import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_theme.dart';
import '../../../domain/value_objects/task_enums.dart';

class TaskPriorityBadge extends StatelessWidget {
  const TaskPriorityBadge({
    required this.priority,
    super.key,
  });

  final TaskPriority priority;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final color = switch (priority) {
      TaskPriority.low => colorScheme.onSurfaceVariant,
      TaskPriority.medium => colorScheme.primary,
      TaskPriority.high => const Color(0xFFB7791F),
      TaskPriority.urgent => colorScheme.error,
    };
    final label = switch (priority) {
      TaskPriority.low => 'Low',
      TaskPriority.medium => 'Medium',
      TaskPriority.high => 'High',
      TaskPriority.urgent => 'Urgent',
    };

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing.sm,
        vertical: context.spacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(context.radii.sm),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: color),
      ),
    );
  }
}
