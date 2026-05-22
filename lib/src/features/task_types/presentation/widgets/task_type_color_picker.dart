import 'package:flutter/material.dart';

import '../../../../../core/theme/app_task_type_color_palette.dart';
import '../../../../../core/theme/app_theme.dart';

class TaskTypeColorPicker extends StatelessWidget {
  const TaskTypeColorPicker({
    required this.selectedColorId,
    required this.onSelected,
    super.key,
  });

  final String selectedColorId;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: context.spacing.sm,
      runSpacing: context.spacing.sm,
      children: [
        for (final color in AppTaskTypeColorPalette.colors)
          InkWell(
            onTap: () => onSelected(color.id),
            borderRadius: BorderRadius.circular(context.radii.md),
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: color.resolve(Theme.of(context).brightness),
                borderRadius: BorderRadius.circular(context.radii.md),
                border: Border.all(
                  color: selectedColorId == color.id
                      ? Theme.of(context).colorScheme.onSurface
                      : Theme.of(context).colorScheme.outlineVariant,
                  width: selectedColorId == color.id ? 2 : 1,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
