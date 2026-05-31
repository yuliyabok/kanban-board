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

class CalendarPage extends ConsumerStatefulWidget {
  const CalendarPage({super.key});

  @override
  ConsumerState<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarPage> {
  late DateTime _focusedMonth;
  late DateTime _selectedDay;
  bool _myTasksOnly = false;

  @override
  void initState() {
    super.initState();
    final today = _dateOnly(DateTime.now());
    _selectedDay = today;
    _focusedMonth = DateTime(today.year, today.month);
  }

  @override
  Widget build(BuildContext context) {
    final boardsState = ref.watch(watchBoardsProvider);

    return AppShell(
      title: 'Календарь',
      subtitle: 'Сроки и задачи по дням',
      actions: [
        AppShellAction(
          label: 'Сегодня',
          icon: Icons.today_outlined,
          onPressed: _goToday,
        ),
      ],
      content: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.all(context.spacing.xl),
          child: boardsState.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(child: Text(error.toString())),
            data: _buildCalendarForBoards,
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarForBoards(List<BoardEntity> boards) {
    if (boards.isEmpty) {
      return const AppEmptyState(
        icon: AppIcons.calendar,
        title: 'Нет доступных досок',
        message: 'Календарь появится, когда у вас будут доски с задачами.',
      );
    }

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
    if (_myTasksOnly && session != null) {
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
        if (_myTasksOnly && !myTaskIds.contains(task.id)) continue;
        entries.add(_CalendarTaskEntry(board: board, task: task));
      }
    }

    final entriesByDay = _groupByDay(entries);
    final selectedEntries = entriesByDay[_selectedDay] ?? const [];
    final device = AppBreakpoints.of(context);

    if (device.isPhone) {
      return Column(
        children: [
          _CalendarHeader(
            focusedMonth: _focusedMonth,
            myTasksOnly: _myTasksOnly,
            onPreviousMonth: _previousMonth,
            onNextMonth: _nextMonth,
            onMyTasksChanged: (value) => setState(() => _myTasksOnly = value),
          ),
          SizedBox(height: context.spacing.md),
          SizedBox(
            height: 420,
            child: _MonthGrid(
              focusedMonth: _focusedMonth,
              selectedDay: _selectedDay,
              entriesByDay: entriesByDay,
              onDaySelected: _selectDay,
            ),
          ),
          SizedBox(height: context.spacing.md),
          Expanded(
            child: _SelectedDayTasks(
              day: _selectedDay,
              entries: selectedEntries,
              onOpenTask: _openTask,
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        _CalendarHeader(
          focusedMonth: _focusedMonth,
          myTasksOnly: _myTasksOnly,
          onPreviousMonth: _previousMonth,
          onNextMonth: _nextMonth,
          onMyTasksChanged: (value) => setState(() => _myTasksOnly = value),
        ),
        SizedBox(height: context.spacing.lg),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _MonthGrid(
                  focusedMonth: _focusedMonth,
                  selectedDay: _selectedDay,
                  entriesByDay: entriesByDay,
                  onDaySelected: _selectDay,
                ),
              ),
              SizedBox(width: context.spacing.lg),
              SizedBox(
                width: 380,
                child: _SelectedDayTasks(
                  day: _selectedDay,
                  entries: selectedEntries,
                  onOpenTask: _openTask,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _previousMonth() {
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1);
      _selectedDay = DateTime(_focusedMonth.year, _focusedMonth.month);
    });
  }

  void _nextMonth() {
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1);
      _selectedDay = DateTime(_focusedMonth.year, _focusedMonth.month);
    });
  }

  void _goToday() {
    final today = _dateOnly(DateTime.now());
    setState(() {
      _selectedDay = today;
      _focusedMonth = DateTime(today.year, today.month);
    });
  }

  void _selectDay(DateTime day) {
    setState(() {
      _selectedDay = day;
      _focusedMonth = DateTime(day.year, day.month);
    });
  }

  void _openTask(_CalendarTaskEntry entry) {
    context.goNamed(
      AppRoute.boardTasks.name,
      pathParameters: {'boardId': entry.board.id},
    );
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
              const Spacer(),
              if (entries.isNotEmpty)
                Row(
                  children: [
                    Icon(
                      Icons.task_alt_rounded,
                      size: 14,
                      color: colorScheme.primary,
                    ),
                    SizedBox(width: context.spacing.xs),
                    Text(
                      '${entries.length}',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: colorScheme.primary,
                      ),
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
    items.sort((a, b) => a.task.title.compareTo(b.task.title));
  }

  return grouped;
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
