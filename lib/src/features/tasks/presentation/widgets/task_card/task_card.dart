import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/theme/app_board_background_palette.dart';
import '../../../../../../core/theme/app_breakpoints.dart';
import '../../../../../../core/theme/app_task_text_color_palette.dart';
import '../../../../../../core/theme/app_task_type_color_palette.dart';
import '../../../../../../core/theme/app_theme.dart';
import '../../../../../../core/widgets/app_card.dart';
import '../../../../../../core/widgets/app_context_menu.dart';
import '../../../../board_settings/domain/entities/board_card_settings.dart';
import '../../../../task_types/domain/entities/task_type_entity.dart';
import '../../../../task_assignees/domain/entities/task_assignee_entity.dart';
import '../../../../task_assignees/presentation/providers/task_assignee_providers.dart';
import '../../../domain/entities/task_entity.dart';
import '../../controllers/task_card_controller.dart';
import 'subtask_list_preview.dart';
import 'task_assignee_avatar.dart';
import 'task_card_models.dart';
import 'task_period_badge.dart';
import 'task_priority_badge.dart';
import 'task_progress_indicator.dart';
import 'task_quick_actions.dart';
import 'task_type_badge.dart';

class TaskCard extends ConsumerStatefulWidget {
  const TaskCard({
    required this.index,
    required this.task,
    required this.parentTask,
    required this.subtasks,
    required this.settings,
    required this.taskType,
    required this.onOpen,
    required this.onToggle,
    required this.onDelete,
    required this.onAddSubtask,
    required this.onToggleSubtask,
    super.key,
  });

  final int index;
  final TaskEntity task;
  final TaskEntity? parentTask;
  final List<TaskEntity> subtasks;
  final BoardCardSettings settings;
  final TaskTypeEntity? taskType;
  final VoidCallback onOpen;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final VoidCallback onAddSubtask;
  final ValueChanged<TaskEntity> onToggleSubtask;

  @override
  ConsumerState<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends ConsumerState<TaskCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final stats = SubtaskStats.fromTasks(widget.subtasks);
    final isChildTask = widget.parentTask != null;
    final isMainTask = widget.parentTask == null;
    final showCompletionToggle = isChildTask;
    final expanded = ref
        .watch(expandedTaskCardsProvider)
        .contains(widget.task.id);
    final device = AppBreakpoints.of(context);
    final typeColor = AppTaskTypeColorPalette.resolve(
      context,
      widget.taskType?.color,
    );
    final backgroundColor = widget.task.cardBackgroundColor == null
        ? AppBoardBackgroundPalette.resolveCard(
            context,
            widget.settings.cardBackgroundColor,
          )
        : AppBoardBackgroundPalette.resolveCard(
            context,
            widget.task.cardBackgroundColor!,
          );
    final textColor = widget.task.cardTextColor == null
        ? null
        : AppTaskTextColorPalette.resolve(context, widget.task.cardTextColor);
    final showActions =
        widget.settings.showQuickActions && (_hovered || !device.isDesktop);
    final padding = switch (widget.settings.density) {
      TaskCardDensity.compact => context.spacing.md,
      TaskCardDensity.comfortable => context.spacing.lg,
      TaskCardDensity.detailed => context.spacing.xl,
    };

    return GestureDetector(
      onLongPress: device.isDesktop ? null : _showActions,
      onSecondaryTapDown: (details) => _showContextMenu(details.globalPosition),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: AppCard(
          onTap: widget.onOpen,
          padding: EdgeInsets.all(padding),
          backgroundColor: backgroundColor,
          borderColor: isMainTask
              ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.55)
              : null,
          borderWidth: isMainTask ? 2 : 1,
          child: DefaultTextStyle.merge(
            style: TextStyle(color: textColor),
            child: IconTheme.merge(
              data: IconThemeData(color: textColor),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border:
                      widget.settings.typeColorMode ==
                          TaskTypeColorMode.leftBorder
                      ? Border(left: BorderSide(color: typeColor, width: 3))
                      : null,
                ),
                child: Padding(
                  padding:
                      widget.settings.typeColorMode ==
                          TaskTypeColorMode.leftBorder
                      ? EdgeInsets.only(left: context.spacing.sm)
                      : EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TaskCardHeader(
                        task: widget.task,
                        taskType: widget.settings.showTaskType
                            ? widget.taskType
                            : null,
                        settings: widget.settings,
                        showActions: showActions,
                        showCompletionToggle: showCompletionToggle,
                        index: widget.index,
                        onToggle: widget.onToggle,
                        onDelete: widget.onDelete,
                        onAddSubtask: widget.onAddSubtask,
                      ),
                      if (widget.parentTask != null) ...[
                        SizedBox(height: context.spacing.xs),
                        _ParentTaskLabel(parent: widget.parentTask!),
                      ],
                      if (widget.settings.showDescription &&
                          (widget.task.description?.isNotEmpty ?? false)) ...[
                        SizedBox(height: context.spacing.sm),
                        Text(
                          widget.task.description!,
                          maxLines:
                              widget.settings.density ==
                                  TaskCardDensity.detailed
                              ? 4
                              : 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                      SizedBox(height: context.spacing.md),
                      Wrap(
                        spacing: context.spacing.xs,
                        runSpacing: context.spacing.xs,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          if (widget.settings.showPeriod)
                            TaskPeriodBadge(task: widget.task),
                          if (widget.settings.showPriority)
                            TaskPriorityBadge(priority: widget.task.priority),
                          if (widget.settings.showLabels)
                            for (final label in widget.task.labels.take(3))
                              Chip(
                                label: Text(label),
                                visualDensity: VisualDensity.compact,
                              ),
                          if (widget.settings.showAssignee)
                            ..._assigneeAvatars(),
                        ],
                      ),
                      if (widget.settings.showSubtaskProgress &&
                          stats.total > 0) ...[
                        SizedBox(height: context.spacing.md),
                        InkWell(
                          onTap: () => ref
                              .read(expandedTaskCardsProvider.notifier)
                              .toggle(widget.task.id),
                          child: TaskProgressIndicator(stats: stats),
                        ),
                      ],
                      if (expanded) ...[
                        SizedBox(height: context.spacing.sm),
                        SubtaskListPreview(
                          subtasks: widget.subtasks,
                          onToggle: widget.onToggleSubtask,
                        ),
                      ],
                      if (widget.settings.showCreatedAt) ...[
                        SizedBox(height: context.spacing.sm),
                        Text(
                          'Создано ${widget.task.createdAt.toLocal()}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showContextMenu(Offset position) {
    AppContextMenu.show(
      context,
      position: position,
      items: [
        if (widget.parentTask != null)
          AppContextMenuItem(
            label: widget.task.isCompleted ? 'Вернуть в работу' : 'Завершить',
            icon: Icons.task_alt_rounded,
            onSelected: widget.onToggle,
          ),
        AppContextMenuItem(
          label: 'Добавить подзадачу',
          icon: Icons.account_tree_outlined,
          onSelected: widget.onAddSubtask,
        ),
        AppContextMenuItem(
          label: 'Удалить',
          icon: Icons.delete_outline_rounded,
          isDanger: true,
          onSelected: widget.onDelete,
        ),
      ],
    );
  }

  void _showActions() {
    _showContextMenu(Offset.zero);
  }

  List<Widget> _assigneeAvatars() {
    final assignees = ref.watch(taskAssigneesProvider(widget.task.id));
    final values = assignees.maybeWhen(
      data: (value) => value,
      orElse: () => const <TaskAssigneeEntity>[],
    );
    if (values.isEmpty) {
      return [TaskAssigneeAvatar(name: widget.task.assigneeName)];
    }
    return [
      for (final assignee in values.take(4))
        TaskAssigneeAvatar(name: assignee.userId),
    ];
  }
}

class _ParentTaskLabel extends StatelessWidget {
  const _ParentTaskLabel({required this.parent});

  final TaskEntity parent;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(
          Icons.account_tree_outlined,
          size: 14,
          color: colorScheme.onSurfaceVariant,
        ),
        SizedBox(width: context.spacing.xs),
        Expanded(
          child: Text(
            'Подзадача: ${parent.title}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}

class TaskCardHeader extends StatelessWidget {
  const TaskCardHeader({
    required this.task,
    required this.taskType,
    required this.settings,
    required this.showActions,
    required this.showCompletionToggle,
    required this.index,
    required this.onToggle,
    required this.onDelete,
    required this.onAddSubtask,
    super.key,
  });

  final TaskEntity task;
  final TaskTypeEntity? taskType;
  final BoardCardSettings settings;
  final bool showActions;
  final bool showCompletionToggle;
  final int index;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final VoidCallback onAddSubtask;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (taskType != null &&
            settings.typeBadgePlacement == TaskTypeBadgePlacement.top) ...[
          TaskTypeBadge(
            type: taskType,
            background:
                settings.typeColorMode == TaskTypeColorMode.badgeBackground,
          ),
          SizedBox(height: context.spacing.sm),
        ],
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showCompletionToggle) ...[
              Checkbox(value: task.isCompleted, onChanged: (_) => onToggle()),
              SizedBox(width: context.spacing.sm),
            ],
            Expanded(
              child: Text(
                task.title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  decoration: task.isCompleted
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: showActions ? 1 : 0,
              duration: context.motion.hover,
              child: TaskQuickActions(
                index: index,
                onAddSubtask: onAddSubtask,
                onDelete: onDelete,
                onDragHandle: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}
