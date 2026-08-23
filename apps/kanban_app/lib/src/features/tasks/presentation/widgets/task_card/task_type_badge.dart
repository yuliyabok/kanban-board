import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_task_type_color_palette.dart';
import '../../../../../../core/theme/app_theme.dart';
import '../../../../task_types/domain/entities/task_type_entity.dart';

class TaskTypeBadge extends StatelessWidget {
  const TaskTypeBadge({
    required this.type,
    this.background = false,
    super.key,
  });

  final TaskTypeEntity? type;
  final bool background;

  @override
  Widget build(BuildContext context) {
    final color = AppTaskTypeColorPalette.resolve(context, type?.color);
    final label = type?.name ?? 'Task';

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing.sm,
        vertical: context.spacing.xs,
      ),
      decoration: BoxDecoration(
        color: background ? color.withValues(alpha: 0.12) : Colors.transparent,
        borderRadius: BorderRadius.circular(context.radii.sm),
        border: Border.all(color: color.withValues(alpha: 0.24)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: const SizedBox.square(dimension: 7),
          ),
          SizedBox(width: context.spacing.xs),
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
