import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/layout/app_shell.dart';
import '../../../../../core/theme/app_breakpoints.dart';
import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../app/routing/app_routes.dart';
import '../../../../shared/ui/app_empty_state.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../boards/domain/entities/board_entity.dart';
import '../../../boards/presentation/providers/board_providers.dart';
import '../../../task_assignees/presentation/providers/task_assignee_providers.dart';
import '../../../tasks/domain/entities/task_entity.dart';
import '../../../tasks/domain/value_objects/task_enums.dart';
import '../../../tasks/presentation/providers/task_providers.dart';
import '../../../tasks/presentation/widgets/task_card/task_card_models.dart';

class GanttPage extends ConsumerWidget {
  const GanttPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final boardsState = ref.watch(watchBoardsProvider);
    final controller = ref.read(_ganttViewProvider.notifier);

    return AppShell(
      title: 'Гант',
      subtitle: 'План работ по срокам',
      actions: [
        AppShellAction(
          label: 'Сегодня',
          icon: Icons.today_outlined,
          onPressed: controller.goToday,
        ),
      ],
      content: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.all(context.spacing.xl),
          child: boardsState.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(child: Text(error.toString())),
            data: (boards) => _buildForBoards(context, ref, boards),
          ),
        ),
      ),
    );
  }

  Widget _buildForBoards(
    BuildContext context,
    WidgetRef ref,
    List<BoardEntity> boards,
  ) {
    if (boards.isEmpty) {
      return const AppEmptyState(
        icon: AppIcons.gantt,
        title: 'Нет доступных досок',
        message: 'Диаграмма появится, когда будут доски с задачами.',
      );
    }

    final viewState = ref.watch(_ganttViewProvider);
    final controller = ref.read(_ganttViewProvider.notifier);
    final session = ref
        .watch(authControllerProvider)
        .maybeWhen(data: (value) => value, orElse: () => null);
    final taskStates = {
      for (final board in boards)
        board.id: ref.watch(boardTasksProvider(board.id)),
    };
    final isLoading = taskStates.values.any(
      (state) => state.maybeWhen(loading: () => true, orElse: () => false),
    );
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final myTaskIdsByBoard = <String, Set<String>>{};
    if (viewState.myTasksOnly && session != null) {
      for (final board in boards) {
        myTaskIdsByBoard[board.id] = ref
            .watch(
              myTaskAssigneeIdsProvider((
                boardId: board.id,
                userId: session.userId,
              )),
            )
            .maybeWhen(data: (value) => value, orElse: () => const <String>{});
      }
    }

    final entries = <_GanttEntry>[];
    for (final board in boards) {
      final tasks =
          taskStates[board.id]?.maybeWhen(
            data: (value) => value,
            orElse: () => const <TaskEntity>[],
          ) ??
          const <TaskEntity>[];
      final myTaskIds = myTaskIdsByBoard[board.id] ?? const <String>{};

      for (final task in tasks) {
        if (task.deletedAt != null) continue;
        if (task.startDate == null && task.dueDate == null) continue;
        if (viewState.myTasksOnly && !myTaskIds.contains(task.id)) continue;
        entries.add(_GanttEntry(board: board, task: task));
      }
    }
    entries.sort(_compareEntries);

    final device = AppBreakpoints.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _GanttHeader(
          focusedMonth: viewState.focusedMonth,
          myTasksOnly: viewState.myTasksOnly,
          onPreviousMonth: controller.previousMonth,
          onNextMonth: controller.nextMonth,
          onMyTasksChanged: controller.setMyTasksOnly,
        ),
        SizedBox(height: context.spacing.lg),
        Expanded(
          child: entries.isEmpty
              ? const AppEmptyState(
                  icon: AppIcons.gantt,
                  title: 'Нет задач со сроками',
                  message:
                      'Задайте дату начала или дедлайн, чтобы увидеть задачи на диаграмме.',
                )
              : _GanttChart(
                  focusedMonth: viewState.focusedMonth,
                  entries: entries,
                  compact: device.isPhone,
                  onOpenTask: (entry) => _openTask(context, entry),
                ),
        ),
      ],
    );
  }

  void _openTask(BuildContext context, _GanttEntry entry) {
    context.goNamed(
      AppRoute.boardTasks.name,
      pathParameters: {'boardId': entry.board.id},
    );
  }
}

final _ganttViewProvider =
    NotifierProvider<_GanttViewController, _GanttViewState>(
      _GanttViewController.new,
    );

final class _GanttViewState {
  const _GanttViewState({
    required this.focusedMonth,
    required this.myTasksOnly,
  });

  final DateTime focusedMonth;
  final bool myTasksOnly;

  _GanttViewState copyWith({
    DateTime? focusedMonth,
    bool? myTasksOnly,
  }) {
    return _GanttViewState(
      focusedMonth: focusedMonth ?? this.focusedMonth,
      myTasksOnly: myTasksOnly ?? this.myTasksOnly,
    );
  }
}

final class _GanttViewController extends Notifier<_GanttViewState> {
  @override
  _GanttViewState build() {
    final today = _dateOnly(DateTime.now());
    return _GanttViewState(
      focusedMonth: DateTime(today.year, today.month),
      myTasksOnly: false,
    );
  }

  void previousMonth() {
    state = state.copyWith(
      focusedMonth: DateTime(
        state.focusedMonth.year,
        state.focusedMonth.month - 1,
      ),
    );
  }

  void nextMonth() {
    state = state.copyWith(
      focusedMonth: DateTime(
        state.focusedMonth.year,
        state.focusedMonth.month + 1,
      ),
    );
  }

  void goToday() {
    final today = DateTime.now();
    state = state.copyWith(focusedMonth: DateTime(today.year, today.month));
  }

  // Riverpod controller method is passed directly to ValueChanged<bool>.
  // ignore: avoid_positional_boolean_parameters
  void setMyTasksOnly(bool value) {
    state = state.copyWith(myTasksOnly: value);
  }
}

class _GanttHeader extends StatelessWidget {
  const _GanttHeader({
    required this.focusedMonth,
    required this.myTasksOnly,
    required this.onPreviousMonth,
    required this.onNextMonth,
    required this.onMyTasksChanged,
  });

  final DateTime focusedMonth;
  final bool myTasksOnly;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;
  final ValueChanged<bool> onMyTasksChanged;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 560;
        final monthControls = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              tooltip: 'Предыдущий месяц',
              onPressed: onPreviousMonth,
              icon: const Icon(Icons.chevron_left_rounded),
            ),
            Flexible(
              child: Text(
                _monthTitle(focusedMonth),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            IconButton(
              tooltip: 'Следующий месяц',
              onPressed: onNextMonth,
              icon: const Icon(Icons.chevron_right_rounded),
            ),
          ],
        );
        final filter = SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SegmentedButton<bool>(
            segments: const [
              ButtonSegment<bool>(
                value: false,
                label: Text('Все задачи'),
                icon: Icon(Icons.view_list_outlined),
              ),
              ButtonSegment<bool>(
                value: true,
                label: Text('Мои задачи'),
                icon: Icon(Icons.person_outline_rounded),
              ),
            ],
            selected: {myTasksOnly},
            onSelectionChanged: (selection) =>
                onMyTasksChanged(selection.first),
          ),
        );

        if (compact) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: constraints.maxWidth, child: monthControls),
              SizedBox(height: context.spacing.sm),
              filter,
            ],
          );
        }

        return Row(
          children: [
            Expanded(child: monthControls),
            SizedBox(width: context.spacing.md),
            filter,
          ],
        );
      },
    );
  }
}

class _GanttChart extends StatefulWidget {
  const _GanttChart({
    required this.focusedMonth,
    required this.entries,
    required this.compact,
    required this.onOpenTask,
  });

  final DateTime focusedMonth;
  final List<_GanttEntry> entries;
  final bool compact;
  final ValueChanged<_GanttEntry> onOpenTask;

  @override
  State<_GanttChart> createState() => _GanttChartState();
}

class _GanttChartState extends State<_GanttChart> {
  final _verticalController = ScrollController();
  final _horizontalController = ScrollController();

  @override
  void dispose() {
    _verticalController.dispose();
    _horizontalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final days = _daysInMonth(widget.focusedMonth);
    final dayWidth = widget.compact ? 34.0 : 42.0;
    final labelWidth = widget.compact ? 240.0 : 320.0;
    final rowHeight = widget.compact ? 54.0 : 62.0;
    final chartWidth = days.length * dayWidth;
    final totalWidth = labelWidth + chartWidth;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        border: Border.all(color: colorScheme.outlineVariant),
        borderRadius: context.radii.card,
      ),
      child: Column(
        children: [
          Expanded(
            child: Scrollbar(
              controller: _horizontalController,
              thumbVisibility: true,
              notificationPredicate: (notification) =>
                  notification.metrics.axis == Axis.horizontal,
              child: SingleChildScrollView(
                controller: _horizontalController,
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: totalWidth,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 48,
                        child: Row(
                          children: [
                            SizedBox(
                              width: labelWidth,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: context.spacing.md,
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Задача',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.labelLarge,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: chartWidth,
                              child: Row(
                                children: [
                                  for (final day in days)
                                    _GanttDayHeader(
                                      day: day,
                                      width: dayWidth,
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 1, color: colorScheme.outlineVariant),
                      Expanded(
                        child: Scrollbar(
                          controller: _verticalController,
                          thumbVisibility: !widget.compact,
                          child: ListView.builder(
                            controller: _verticalController,
                            itemCount: widget.entries.length,
                            itemBuilder: (context, index) {
                              final entry = widget.entries[index];
                              return SizedBox(
                                height: rowHeight,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: labelWidth,
                                      child: _GanttTaskLabel(
                                        entry: entry,
                                        onTap: () => widget.onOpenTask(entry),
                                      ),
                                    ),
                                    SizedBox(
                                      width: chartWidth,
                                      child: _GanttTimelineRow(
                                        focusedMonth: widget.focusedMonth,
                                        entry: entry,
                                        dayWidth: dayWidth,
                                        onTap: () => widget.onOpenTask(entry),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GanttDayHeader extends StatelessWidget {
  const _GanttDayHeader({required this.day, required this.width});

  final DateTime day;
  final double width;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isToday = _isSameDay(day, DateTime.now());
    return SizedBox(
      width: width,
      child: Center(
        child: Text(
          '${day.day}',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: isToday ? colorScheme.primary : colorScheme.onSurfaceVariant,
            fontWeight: isToday ? FontWeight.w800 : null,
          ),
        ),
      ),
    );
  }
}

class _GanttTaskLabel extends StatelessWidget {
  const _GanttTaskLabel({
    required this.entry,
    required this.onTap,
  });

  final _GanttEntry entry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.spacing.md),
        child: Row(
          children: [
            Container(
              width: 8,
              height: 28,
              decoration: BoxDecoration(
                color: _priorityColor(context, entry.task.priority),
                borderRadius: BorderRadius.circular(99),
              ),
            ),
            SizedBox(width: context.spacing.sm),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.task.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      height: 1.1,
                    ),
                  ),
                  Text(
                    '${entry.board.title} · ${entry.task.periodLabel}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      height: 1.1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GanttTimelineRow extends StatelessWidget {
  const _GanttTimelineRow({
    required this.focusedMonth,
    required this.entry,
    required this.dayWidth,
    required this.onTap,
  });

  final DateTime focusedMonth;
  final _GanttEntry entry;
  final double dayWidth;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final monthStart = DateTime(focusedMonth.year, focusedMonth.month);
    final monthEnd = DateTime(focusedMonth.year, focusedMonth.month + 1, 0);
    final taskStart = _dateOnly(entry.task.startDate ?? entry.task.dueDate!);
    final taskEnd = _dateOnly(entry.task.dueDate ?? entry.task.startDate!);
    final visibleStart = taskStart.isBefore(monthStart)
        ? monthStart
        : taskStart;
    final visibleEnd = taskEnd.isAfter(monthEnd) ? monthEnd : taskEnd;
    final hidden =
        visibleEnd.isBefore(monthStart) || visibleStart.isAfter(monthEnd);
    final days = _daysInMonth(focusedMonth);
    final rowColor = colorScheme.outlineVariant.withValues(alpha: 0.36);

    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Row(
          children: [
            for (final day in days)
              Container(
                width: dayWidth,
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(color: rowColor),
                    bottom: BorderSide(color: rowColor),
                  ),
                  color: _isSameDay(day, DateTime.now())
                      ? colorScheme.primary.withValues(alpha: 0.06)
                      : null,
                ),
              ),
          ],
        ),
        if (!hidden)
          Positioned(
            left: visibleStart.difference(monthStart).inDays * dayWidth + 4,
            width:
                (visibleEnd.difference(visibleStart).inDays + 1) * dayWidth - 8,
            height: 28,
            child: _GanttTaskBar(entry: entry, onTap: onTap),
          ),
      ],
    );
  }
}

class _GanttTaskBar extends StatelessWidget {
  const _GanttTaskBar({required this.entry, required this.onTap});

  final _GanttEntry entry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = _priorityColor(context, entry.task.priority);
    return Tooltip(
      message: '${entry.task.title}\n${_priorityLabel(entry.task.priority)}',
      child: Material(
        color: color.withValues(alpha: entry.task.isCompleted ? 0.28 : 0.82),
        borderRadius: BorderRadius.circular(6),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                entry.task.isCompleted ? 'Готово' : entry.task.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final class _GanttEntry {
  const _GanttEntry({
    required this.board,
    required this.task,
  });

  final BoardEntity board;
  final TaskEntity task;
}

int _compareEntries(_GanttEntry left, _GanttEntry right) {
  final start = _entryStart(left).compareTo(_entryStart(right));
  if (start != 0) return start;
  final priority = _priorityRank(right.task.priority).compareTo(
    _priorityRank(left.task.priority),
  );
  if (priority != 0) return priority;
  return left.task.title.compareTo(right.task.title);
}

DateTime _entryStart(_GanttEntry entry) {
  return _dateOnly(entry.task.startDate ?? entry.task.dueDate!);
}

List<DateTime> _daysInMonth(DateTime month) {
  final count = DateTime(month.year, month.month + 1, 0).day;
  return [
    for (var day = 1; day <= count; day++)
      DateTime(month.year, month.month, day),
  ];
}

DateTime _dateOnly(DateTime value) {
  final local = value.toLocal();
  return DateTime(local.year, local.month, local.day);
}

bool _isSameDay(DateTime left, DateTime right) {
  return left.year == right.year &&
      left.month == right.month &&
      left.day == right.day;
}

String _monthTitle(DateTime value) {
  const months = [
    'Январь',
    'Февраль',
    'Март',
    'Апрель',
    'Май',
    'Июнь',
    'Июль',
    'Август',
    'Сентябрь',
    'Октябрь',
    'Ноябрь',
    'Декабрь',
  ];
  return '${months[value.month - 1]} ${value.year}';
}

int _priorityRank(TaskPriority priority) {
  return switch (priority) {
    TaskPriority.low => 0,
    TaskPriority.medium => 1,
    TaskPriority.high => 2,
    TaskPriority.urgent => 3,
  };
}

Color _priorityColor(BuildContext context, TaskPriority priority) {
  final colorScheme = Theme.of(context).colorScheme;
  return switch (priority) {
    TaskPriority.low => colorScheme.secondary,
    TaskPriority.medium => colorScheme.primary,
    TaskPriority.high => colorScheme.tertiary,
    TaskPriority.urgent => colorScheme.error,
  };
}

String _priorityLabel(TaskPriority priority) {
  return switch (priority) {
    TaskPriority.low => 'Низкий',
    TaskPriority.medium => 'Средний',
    TaskPriority.high => 'Высокий',
    TaskPriority.urgent => 'Срочный',
  };
}
