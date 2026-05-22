import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_theme.dart';
import 'task_card_models.dart';

class TaskProgressIndicator extends StatelessWidget {
  const TaskProgressIndicator({
    required this.stats,
    super.key,
  });

  final SubtaskStats stats;

  @override
  Widget build(BuildContext context) {
    if (stats.total == 0) return const SizedBox.shrink();
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.account_tree_outlined,
              size: 14,
              color: colorScheme.onSurfaceVariant,
            ),
            SizedBox(width: context.spacing.xs),
            Text(stats.label, style: Theme.of(context).textTheme.bodySmall),
            const Spacer(),
            Text(
              '${(stats.progress * 100).round()}%',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        SizedBox(height: context.spacing.xs),
        ClipRRect(
          borderRadius: BorderRadius.circular(context.radii.xs),
          child: LinearProgressIndicator(
            minHeight: 5,
            value: stats.progress,
            backgroundColor: colorScheme.surfaceContainerHighest,
          ),
        ),
      ],
    );
  }
}

class SubtaskCounter extends StatelessWidget {
  const SubtaskCounter({required this.stats, super.key});

  final SubtaskStats stats;

  @override
  Widget build(BuildContext context) {
    return Text(stats.label, style: Theme.of(context).textTheme.bodySmall);
  }
}
