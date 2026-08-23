import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_theme.dart';
import '../../../domain/entities/task_entity.dart';
import '../../../domain/value_objects/task_enums.dart';
import 'task_card_models.dart';

class TaskPeriodBadge extends StatelessWidget {
  const TaskPeriodBadge({
    required this.task,
    super.key,
  });

  final TaskEntity task;

  @override
  Widget build(BuildContext context) {
    final status = task.periodStatus;
    final colorScheme = Theme.of(context).colorScheme;
    final color = switch (status) {
      TaskPeriodStatus.overdue => colorScheme.error,
      TaskPeriodStatus.completed => colorScheme.tertiary,
      TaskPeriodStatus.inProgress => colorScheme.primary,
      TaskPeriodStatus.notStarted => colorScheme.onSurfaceVariant,
      TaskPeriodStatus.noSchedule => colorScheme.onSurfaceVariant,
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.schedule_rounded, size: 12, color: color),
          SizedBox(width: context.spacing.xs),
          Text(
            task.periodLabel,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
