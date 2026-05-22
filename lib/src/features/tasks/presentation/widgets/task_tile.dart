import 'package:flutter/material.dart';

import '../../../../../core/theme/app_breakpoints.dart';
import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/app_context_menu.dart';
import '../../../../app/theme/app_design_tokens.dart';
import '../../domain/entities/task_entity.dart';

class TaskTile extends StatefulWidget {
  const TaskTile({
    required this.index,
    required this.task,
    required this.onToggle,
    required this.onDelete,
    this.onOpen,
    super.key,
  });

  final int index;
  final TaskEntity task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final VoidCallback? onOpen;

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final showActions = _hovered || !AppBreakpoints.of(context).isDesktop;

    return GestureDetector(
      onSecondaryTapDown: (details) {
        AppContextMenu.show(
          context,
          position: details.globalPosition,
          items: [
            AppContextMenuItem(
              label: widget.task.isCompleted ? 'Вернуть в работу' : 'Завершить',
              icon: AppIcons.tasks,
              onSelected: widget.onToggle,
            ),
            AppContextMenuItem(
              label: 'Удалить',
              icon: AppIcons.delete,
              isDanger: true,
              onSelected: widget.onDelete,
            ),
          ],
        );
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: AppCard(
          onTap: widget.onOpen,
          padding: EdgeInsets.all(context.spacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: widget.task.isCompleted,
                    onChanged: (_) => widget.onToggle(),
                  ),
                  SizedBox(width: context.spacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.task.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.titleSmall?.copyWith(
                            decoration: widget.task.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                            color: widget.task.isCompleted
                                ? colorScheme.onSurfaceVariant
                                : colorScheme.onSurface,
                          ),
                        ),
                        if (widget.task.description?.isNotEmpty ?? false) ...[
                          SizedBox(height: context.spacing.xs),
                          Text(
                            widget.task.description!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodySmall,
                          ),
                        ],
                      ],
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: showActions ? 1 : 0,
                    duration: context.motion.hover,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          tooltip: 'Удалить',
                          onPressed: widget.onDelete,
                          icon: const Icon(AppIcons.delete, size: 18),
                        ),
                        ReorderableDragStartListener(
                          index: widget.index,
                          child: const Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(AppIcons.drag, size: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.spacing.sm),
              Wrap(
                spacing: context.spacing.xs,
                runSpacing: context.spacing.xs,
                children: [
                  _MetaChip(
                    icon: Icons.flag_outlined,
                    label: 'Medium',
                    color: colorScheme.primary,
                  ),
                  _MetaChip(
                    icon: Icons.schedule_rounded,
                    label: 'Сегодня',
                    color: colorScheme.onSurfaceVariant,
                  ),
                  if (!widget.task.isSynced)
                    _MetaChip(
                      icon: Icons.cloud_off_outlined,
                      label: 'Офлайн',
                      color: colorScheme.error,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(context.radii.sm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
