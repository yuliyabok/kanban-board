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

class CalendarPage extends ConsumerWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final boardsState = ref.watch(watchBoardsProvider);
    final controller = ref.read(_calendarViewProvider.notifier);

    return AppShell(
      title: 'Календарь',
      subtitle: 'Сроки и задачи по дням',
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
            data: (boards) => _buildCalendarForBoards(context, ref, boards),
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarForBoards(
    BuildContext context,
    WidgetRef ref,
    List<BoardEntity> boards,
  ) {
    if (boards.isEmpty) {
      return const AppEmptyState(
        icon: AppIcons.calendar,
        title: 'Нет доступных досок',
        message: 'Календарь появится, когда у вас будут доски с задачами.',
      );
    }

    final calendarState = ref.watch(_calendarViewProvider);
    final controller = ref.read(_calendarViewProvider.notifier);
    final session = ref
        .watch(authControllerProvider)
        .maybeWhen(
          data: (value) => value,
          orElse: () => null,
        );
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
    if (calendarState.myTasksOnly && session != null) {
      for (final board in boards) {
        myTaskIdsByBoard[board.id] = ref
            .watch(
              myTaskAssigneeIdsProvider((
                boardId: board.id,
                userId: session.userId,
              )),
            )
            .maybeWhen(
              data: (value) => value,
              orElse: () => const <String>{},
            );
      }
    }

    final entries = <_CalendarTaskEntry>[];
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
        if (calendarState.myTasksOnly && !myTaskIds.contains(task.id)) {
          continue;
        }
        entries.add(_CalendarTaskEntry(board: board, task: task));
      }
    }

    final entriesByDay = _groupByDay(entries);
    final selectedEntries = entriesByDay[calendarState.selectedDay] ?? const [];
    final device = AppBreakpoints.of(context);

    if (device.isPhone) {
      return Column(
        children: [
          _CalendarHeader(
            focusedMonth: calendarState.focusedMonth,
            myTasksOnly: calendarState.myTasksOnly,
            onPreviousMonth: controller.previousMonth,
            onNextMonth: controller.nextMonth,
            onMyTasksChanged: controller.setMyTasksOnly,
          ),
          SizedBox(height: context.spacing.md),
          SizedBox(
            height: 420,
            child: _MonthGrid(
              focusedMonth: calendarState.focusedMonth,
              selectedDay: calendarState.selectedDay,
              entriesByDay: entriesByDay,
              onDaySelected: controller.selectDay,
            ),
          ),
          SizedBox(height: context.spacing.md),
          Expanded(
            child: _SelectedDayTasks(
              day: calendarState.selectedDay,
              entries: selectedEntries,
              onOpenTask: (entry) => _openTask(context, entry),
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        _CalendarHeader(
          focusedMonth: calendarState.focusedMonth,
          myTasksOnly: calendarState.myTasksOnly,
          onPreviousMonth: controller.previousMonth,
          onNextMonth: controller.nextMonth,
          onMyTasksChanged: controller.setMyTasksOnly,
        ),
        SizedBox(height: context.spacing.lg),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _MonthGrid(
                  focusedMonth: calendarState.focusedMonth,
                  selectedDay: calendarState.selectedDay,
                  entriesByDay: entriesByDay,
                  onDaySelected: controller.selectDay,
                ),
              ),
              SizedBox(width: context.spacing.lg),
              SizedBox(
                width: 380,
                child: _SelectedDayTasks(
                  day: calendarState.selectedDay,
                  entries: selectedEntries,
                  onOpenTask: (entry) => _openTask(context, entry),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _openTask(BuildContext context, _CalendarTaskEntry entry) {
    context.goNamed(
      AppRoute.boardTasks.name,
      pathParameters: {'boardId': entry.board.id},
    );
  }
}

final _calendarViewProvider =
    NotifierProvider<_CalendarViewController, _CalendarViewState>(
      _CalendarViewController.new,
    );

final class _CalendarViewState {
  const _CalendarViewState({
    required this.focusedMonth,
    required this.selectedDay,
    required this.myTasksOnly,
  });

  final DateTime focusedMonth;
  final DateTime selectedDay;
  final bool myTasksOnly;

  _CalendarViewState copyWith({
    DateTime? focusedMonth,
    DateTime? selectedDay,
    bool? myTasksOnly,
  }) {
    return _CalendarViewState(
      focusedMonth: focusedMonth ?? this.focusedMonth,
      selectedDay: selectedDay ?? this.selectedDay,
      myTasksOnly: myTasksOnly ?? this.myTasksOnly,
    );
  }
}

final class _CalendarViewController extends Notifier<_CalendarViewState> {
  @override
  _CalendarViewState build() {
    final today = _dateOnly(DateTime.now());
    return _CalendarViewState(
      focusedMonth: DateTime(today.year, today.month),
      selectedDay: today,
      myTasksOnly: false,
    );
  }

  void previousMonth() {
    final month = DateTime(
      state.focusedMonth.year,
      state.focusedMonth.month - 1,
    );
    state = state.copyWith(focusedMonth: month, selectedDay: month);
  }

  void nextMonth() {
    final month = DateTime(
      state.focusedMonth.year,
      state.focusedMonth.month + 1,
    );
    state = state.copyWith(focusedMonth: month, selectedDay: month);
  }

  void goToday() {
    final today = _dateOnly(DateTime.now());
    state = state.copyWith(
      focusedMonth: DateTime(today.year, today.month),
      selectedDay: today,
    );
  }

  void selectDay(DateTime day) {
    state = state.copyWith(
      focusedMonth: DateTime(day.year, day.month),
      selectedDay: day,
    );
  }

  // Riverpod controller method is passed directly to ValueChanged<bool>.
  // ignore: avoid_positional_boolean_parameters
  void setMyTasksOnly(bool value) {
    state = state.copyWith(myTasksOnly: value);
  }
}

class _CalendarHeader extends StatelessWidget {
  const _CalendarHeader({
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
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      runSpacing: context.spacing.md,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              tooltip: 'Предыдущий месяц',
              onPressed: onPreviousMonth,
              icon: const Icon(Icons.chevron_left_rounded),
            ),
            SizedBox(width: context.spacing.sm),
            Text(
              _monthTitle(focusedMonth),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(width: context.spacing.sm),
            IconButton(
              tooltip: 'Следующий месяц',
              onPressed: onNextMonth,
              icon: const Icon(Icons.chevron_right_rounded),
            ),
          ],
        ),
        SegmentedButton<bool>(
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
          onSelectionChanged: (selection) => onMyTasksChanged(selection.first),
        ),
      ],
    );
  }
}

class _MonthGrid extends StatelessWidget {
  const _MonthGrid({
    required this.focusedMonth,
    required this.selectedDay,
    required this.entriesByDay,
    required this.onDaySelected,
  });

  final DateTime focusedMonth;
  final DateTime selectedDay;
  final Map<DateTime, List<_CalendarTaskEntry>> entriesByDay;
  final ValueChanged<DateTime> onDaySelected;

  @override
  Widget build(BuildContext context) {
    final firstDay = DateTime(focusedMonth.year, focusedMonth.month);
    final gridStart = firstDay.subtract(Duration(days: firstDay.weekday - 1));
    final days = [
      for (var index = 0; index < 42; index++)
        gridStart.add(Duration(days: index)),
    ];

    return Column(
      children: [
        const Row(
          children: [
            _WeekdayLabel('Пн'),
            _WeekdayLabel('Вт'),
            _WeekdayLabel('Ср'),
            _WeekdayLabel('Чт'),
            _WeekdayLabel('Пт'),
            _WeekdayLabel('Сб'),
            _WeekdayLabel('Вс'),
          ],
        ),
        SizedBox(height: context.spacing.sm),
        Expanded(
          child: GridView.builder(
            itemCount: days.length,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              final day = days[index];
              final entries = entriesByDay[day] ?? const [];
              return _CalendarDayCell(
                day: day,
                isCurrentMonth: day.month == focusedMonth.month,
                isSelected: _isSameDay(day, selectedDay),
                isToday: _isSameDay(day, DateTime.now()),
                entries: entries,
                onTap: () => onDaySelected(day),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _WeekdayLabel extends StatelessWidget {
  const _WeekdayLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
    );
  }
}

class _CalendarDayCell extends StatelessWidget {
  const _CalendarDayCell({
    required this.day,
    required this.isCurrentMonth,
    required this.isSelected,
    required this.isToday,
    required this.entries,
    required this.onTap,
  });

  final DateTime day;
  final bool isCurrentMonth;
  final bool isSelected;
  final bool isToday;
  final List<_CalendarTaskEntry> entries;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final device = AppBreakpoints.of(context);
    final textColor = isCurrentMonth
        ? colorScheme.onSurface
        : colorScheme.onSurfaceVariant.withValues(alpha: 0.55);
    final background = isSelected
        ? colorScheme.primaryContainer
        : entries.isNotEmpty
        ? colorScheme.surfaceContainerHigh
        : colorScheme.surfaceContainerLowest;

    return Material(
      color: background,
      shape: RoundedRectangleBorder(
        borderRadius: context.radii.card,
        side: BorderSide(
          color: isToday ? colorScheme.primary : colorScheme.outlineVariant,
          width: isToday ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: context.radii.card,
        child: Padding(
          padding: EdgeInsets.all(context.spacing.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${day.day}',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: isSelected ? colorScheme.primary : textColor,
                ),
              ),
              SizedBox(height: context.spacing.xs),
              Expanded(
                child: entries.isEmpty
                    ? const SizedBox.shrink()
                    : device.isPhone
                    ? Align(
                        alignment: Alignment.bottomLeft,
                        child: _CalendarDayCount(count: entries.length),
                      )
                    : _CalendarDayTaskPreview(
                        entries: entries.take(3).toList(),
                      ),
              ),
              if (!device.isPhone && entries.length > 3)
                Text(
                  '+${entries.length - 3}',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CalendarDayCount extends StatelessWidget {
  const _CalendarDayCount({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.task_alt_rounded,
          size: 14,
          color: colorScheme.primary,
        ),
        SizedBox(width: context.spacing.xs),
        Text(
          '$count',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: colorScheme.primary,
          ),
        ),
      ],
    );
  }
}

class _CalendarDayTaskPreview extends StatelessWidget {
  const _CalendarDayTaskPreview({required this.entries});

  final List<_CalendarTaskEntry> entries;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        for (final entry in entries)
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: _CalendarDayTaskPill(entry: entry),
          ),
      ],
    );
  }
}

class _CalendarDayTaskPill extends StatelessWidget {
  const _CalendarDayTaskPill({required this.entry});

  final _CalendarTaskEntry entry;

  @override
  Widget build(BuildContext context) {
    final color = _priorityColor(context, entry.task.priority);
    return Container(
      constraints: const BoxConstraints(minHeight: 18),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: entry.task.isCompleted ? 0.10 : 0.16),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.34)),
      ),
      child: Row(
        children: [
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              color: entry.task.isCompleted
                  ? Theme.of(context).colorScheme.onSurfaceVariant
                  : color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              entry.task.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: entry.task.isCompleted
                    ? Theme.of(context).colorScheme.onSurfaceVariant
                    : Theme.of(context).colorScheme.onSurface,
                decoration: entry.task.isCompleted
                    ? TextDecoration.lineThrough
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectedDayTasks extends StatelessWidget {
  const _SelectedDayTasks({
    required this.day,
    required this.entries,
    required this.onOpenTask,
  });

  final DateTime day;
  final List<_CalendarTaskEntry> entries;
  final ValueChanged<_CalendarTaskEntry> onOpenTask;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        border: Border.all(color: colorScheme.outlineVariant),
        borderRadius: context.radii.card,
      ),
      child: Padding(
        padding: EdgeInsets.all(context.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _dateTitle(day),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: context.spacing.sm),
            Text(
              entries.isEmpty
                  ? 'Нет задач на этот день'
                  : 'Задач: ${entries.length}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: context.spacing.md),
            Expanded(
              child: entries.isEmpty
                  ? const AppEmptyState(
                      icon: AppIcons.calendar,
                      title: 'День свободен',
                      message: 'Выберите другой день или задайте срок задаче.',
                    )
                  : ListView.separated(
                      itemCount: entries.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: context.spacing.sm),
                      itemBuilder: (context, index) {
                        final entry = entries[index];
                        return _CalendarTaskTile(
                          entry: entry,
                          onTap: () => onOpenTask(entry),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CalendarTaskTile extends StatelessWidget {
  const _CalendarTaskTile({
    required this.entry,
    required this.onTap,
  });

  final _CalendarTaskEntry entry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: context.radii.card,
        child: Padding(
          padding: EdgeInsets.all(context.spacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.task.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: context.spacing.xs),
              Text(
                entry.board.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: context.spacing.sm),
              Wrap(
                spacing: context.spacing.xs,
                runSpacing: context.spacing.xs,
                children: [
                  Chip(
                    avatar: const Icon(Icons.flag_outlined, size: 16),
                    label: Text(_priorityLabel(entry.task.priority)),
                    visualDensity: VisualDensity.compact,
                  ),
                  Chip(
                    avatar: const Icon(Icons.schedule_rounded, size: 16),
                    label: Text(entry.task.periodLabel),
                    visualDensity: VisualDensity.compact,
                  ),
                  if (entry.task.isCompleted)
                    const Chip(
                      avatar: Icon(Icons.check_rounded, size: 16),
                      label: Text('Готово'),
                      visualDensity: VisualDensity.compact,
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

final class _CalendarTaskEntry {
  const _CalendarTaskEntry({
    required this.board,
    required this.task,
  });

  final BoardEntity board;
  final TaskEntity task;
}

Map<DateTime, List<_CalendarTaskEntry>> _groupByDay(
  List<_CalendarTaskEntry> entries,
) {
  final grouped = <DateTime, List<_CalendarTaskEntry>>{};

  for (final entry in entries) {
    for (final day in _taskDays(entry.task)) {
      grouped.putIfAbsent(day, () => []).add(entry);
    }
  }

  for (final items in grouped.values) {
    items.sort(_compareCalendarEntries);
  }

  return grouped;
}

int _compareCalendarEntries(_CalendarTaskEntry left, _CalendarTaskEntry right) {
  final priority = _priorityRank(right.task.priority).compareTo(
    _priorityRank(left.task.priority),
  );
  if (priority != 0) return priority;

  final leftDue = left.task.dueDate;
  final rightDue = right.task.dueDate;
  if (leftDue != null && rightDue != null) {
    final due = leftDue.compareTo(rightDue);
    if (due != 0) return due;
  } else if (leftDue != null) {
    return -1;
  } else if (rightDue != null) {
    return 1;
  }

  return left.task.title.compareTo(right.task.title);
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

Iterable<DateTime> _taskDays(TaskEntity task) sync* {
  final start = task.startDate == null ? null : _dateOnly(task.startDate!);
  final due = task.dueDate == null ? null : _dateOnly(task.dueDate!);

  if (start == null && due == null) return;
  if (start == null) {
    yield due!;
    return;
  }
  if (due == null) {
    yield start;
    return;
  }
  if (due.isBefore(start)) {
    yield start;
    yield due;
    return;
  }

  final span = due.difference(start).inDays.clamp(0, 90);
  for (var offset = 0; offset <= span; offset++) {
    yield start.add(Duration(days: offset));
  }
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

String _dateTitle(DateTime value) {
  return '${value.day}.${value.month.toString().padLeft(2, '0')}.${value.year}';
}

String _priorityLabel(TaskPriority priority) {
  return switch (priority) {
    TaskPriority.low => 'Низкий',
    TaskPriority.medium => 'Средний',
    TaskPriority.high => 'Высокий',
    TaskPriority.urgent => 'Срочный',
  };
}
