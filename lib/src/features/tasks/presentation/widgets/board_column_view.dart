import 'package:flutter/material.dart';

import '../../../../../core/theme/app_board_background_palette.dart';
import '../../../../../core/theme/app_breakpoints.dart';
import '../../../../../core/theme/app_icons.dart';
import '../../../../app/theme/app_design_tokens.dart';
import '../../../board_settings/domain/entities/board_card_settings.dart';
import '../../../task_types/domain/entities/task_type_entity.dart';
import '../../domain/entities/task_entity.dart';
import 'task_card/task_card.dart';

class BoardColumnView extends StatelessWidget {
  const BoardColumnView({
    required this.title,
    required this.tasks,
    required this.allTasks,
    required this.settings,
    required this.taskTypes,
    required this.onToggleTask,
    required this.onDeleteTask,
    required this.onAddSubtask,
    required this.onToggleSubtask,
    required this.onReorderTask,
    required this.onOpenTask,
    required this.onAddTask,
    required this.onMoveTaskHere,
    this.width,
    super.key,
  });

  final String title;
  final List<TaskEntity> tasks;
  final List<TaskEntity> allTasks;
  final BoardCardSettings settings;
  final List<TaskTypeEntity> taskTypes;
  final ValueChanged<String> onToggleTask;
  final ValueChanged<String> onDeleteTask;
  final ValueChanged<TaskEntity> onAddSubtask;
  final ValueChanged<TaskEntity> onToggleSubtask;
  final ValueChanged<TaskEntity> onOpenTask;
  final VoidCallback onAddTask;
  final ValueChanged<TaskEntity> onMoveTaskHere;
  final void Function(int oldIndex, int newIndex) onReorderTask;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final device = AppBreakpoints.of(context);
    final backgroundColor = AppBoardBackgroundPalette.resolveColumn(
      context,
      settings.columnBackgroundColor,
    );
    final defaultWidth = switch (device) {
      AppDeviceClass.phone => MediaQuery.sizeOf(context).width * 0.86,
      AppDeviceClass.tablet => 300.0,
      AppDeviceClass.desktop => 320.0,
      AppDeviceClass.largeDesktop => 340.0,
    };
    final resolvedWidth = width ?? defaultWidth.clamp(280, 360).toDouble();

    return DragTarget<TaskEntity>(
      onWillAcceptWithDetails: (details) => true,
      onAcceptWithDetails: (details) => onMoveTaskHere(details.data),
      builder: (context, candidateData, rejectedData) {
        final isDropTarget = candidateData.isNotEmpty;
        return AnimatedContainer(
          duration: context.motion.hover,
          width: resolvedWidth,
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(
              color: isDropTarget
                  ? colorScheme.primary
                  : colorScheme.outlineVariant,
              width: isDropTarget ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(context.radii.lg),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  context.spacing.lg,
                  context.spacing.md,
                  context.spacing.md,
                  context.spacing.sm,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.titleMedium,
                      ),
                    ),
                    IconButton(
                      tooltip: 'Добавить задачу',
                      onPressed: onAddTask,
                      icon: const Icon(AppIcons.add, size: 18),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.spacing.sm,
                        vertical: context.spacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(context.radii.sm),
                      ),
                      child: Text(
                        '${tasks.length}',
                        style: textTheme.labelMedium,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: tasks.isEmpty
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.all(context.spacing.lg),
                          child: Text(
                            isDropTarget
                                ? 'Отпустите задачу здесь'
                                : 'Перетащите задачу сюда или создайте новую',
                            textAlign: TextAlign.center,
                            style: textTheme.bodyMedium?.copyWith(
                              color: isDropTarget
                                  ? colorScheme.primary
                                  : colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.all(context.spacing.sm),
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          final task = tasks[index];
                          final parentTask = task.parentTaskId == null
                              ? null
                              : allTasks
                                    .where(
                                      (item) => item.id == task.parentTaskId,
                                    )
                                    .firstOrNull;
                          final subtasks = allTasks
                              .where((item) => item.parentTaskId == task.id)
                              .toList(growable: false);
                          final taskType = taskTypes
                              .where((type) => type.id == task.taskTypeId)
                              .firstOrNull;
                          final card = Padding(
                            key: ValueKey(task.id),
                            padding: EdgeInsets.only(
                              bottom: context.spacing.sm,
                            ),
                            child: TaskCard(
                              index: index,
                              task: task,
                              parentTask: parentTask,
                              subtasks: subtasks,
                              settings: settings,
                              taskType: taskType,
                              onOpen: () => onOpenTask(task),
                              onToggle: () => onToggleTask(task.id),
                              onDelete: () => onDeleteTask(task.id),
                              onAddSubtask: () => onAddSubtask(task),
                              onToggleSubtask: onToggleSubtask,
                            ),
                          );

                          return Draggable<TaskEntity>(
                            key: ValueKey('drag-${task.id}'),
                            data: task,
                            feedback: Material(
                              color: Colors.transparent,
                              child: SizedBox(
                                width: resolvedWidth - context.spacing.lg,
                                child: Opacity(opacity: 0.92, child: card),
                              ),
                            ),
                            childWhenDragging: Opacity(
                              opacity: 0.35,
                              child: card,
                            ),
                            child: card,
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
