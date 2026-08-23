import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/layout/app_shell.dart';
import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../app/routing/app_routes.dart';
import '../../../../core/providers/core_providers.dart';
import '../../../../shared/ui/app_empty_state.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../boards/domain/entities/board_entity.dart';
import '../../../boards/presentation/providers/board_providers.dart';
import '../../../tasks/domain/entities/task_entity.dart';
import '../../../tasks/domain/entities/task_history_entry.dart';
import '../../../tasks/presentation/providers/task_providers.dart';
import '../../../users/presentation/providers/user_providers.dart';

class WhatsNewPage extends ConsumerWidget {
  const WhatsNewPage({super.key});

  static const _fallbackWindow = Duration(hours: 24);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref
        .watch(authControllerProvider)
        .maybeWhen(data: (value) => value, orElse: () => null);
    final lastSeenState = ref.watch(_whatsNewLastSeenProvider);

    return AppShell(
      title: 'Что нового',
      subtitle: 'Что изменилось, пока вас не было',
      actions: [
        AppShellAction(
          label: 'Отметить просмотренным',
          icon: Icons.done_all_rounded,
          onPressed: session == null
              ? null
              : () => _markSeen(context, ref, session.userId),
        ),
      ],
      content: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.all(context.spacing.xl),
          child: lastSeenState.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(child: Text(error.toString())),
            data: (lastSeen) => _WhatsNewBody(
              since: lastSeen ?? DateTime.now().subtract(_fallbackWindow),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _markSeen(
    BuildContext context,
    WidgetRef ref,
    String userId,
  ) async {
    await ref
        .read(secureStorageProvider)
        .write(
          key: _lastSeenKey(userId),
          value: DateTime.now().toUtc().toIso8601String(),
        );
    ref.invalidate(_whatsNewLastSeenProvider);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Обновления отмечены просмотренными')),
    );
  }
}

class _WhatsNewBody extends ConsumerWidget {
  const _WhatsNewBody({required this.since});

  final DateTime since;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final boardsState = ref.watch(watchBoardsProvider);
    final historyState = ref.watch(taskHistorySinceProvider(since));

    return boardsState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text(error.toString())),
      data: (boards) {
        if (boards.isEmpty) {
          return const AppEmptyState(
            icon: AppIcons.whatsNew,
            title: 'Пока нечего показывать',
            message:
                'Когда появятся доски и задачи, здесь будет сводка изменений.',
          );
        }

        final taskStates = {
          for (final board in boards)
            board.id: ref.watch(boardTasksProvider(board.id)),
        };
        final tasksLoading = taskStates.values.any(
          (state) => state.maybeWhen(loading: () => true, orElse: () => false),
        );
        if (tasksLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final tasks = <TaskEntity>[];
        for (final state in taskStates.values) {
          tasks.addAll(
            state.maybeWhen(
              data: (items) => items,
              orElse: () => const <TaskEntity>[],
            ),
          );
        }
        final boardIds = boards.map((board) => board.id).toSet();
        final tasksById = {for (final task in tasks) task.id: task};
        final boardsById = {for (final board in boards) board.id: board};

        return historyState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          data: (history) {
            final visibleHistory = history
                .where((entry) => boardIds.contains(entry.boardId))
                .toList(growable: false);
            final summary = _WhatsNewSummary.from(
              history: visibleHistory,
              tasks: tasks,
              since: since,
            );

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Пока вас не было',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: context.spacing.xs),
                Text(
                  'С ${_formatDateTime(since)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: context.spacing.lg),
                _SummaryGrid(summary: summary),
                SizedBox(height: context.spacing.xl),
                Expanded(
                  child: visibleHistory.isEmpty && summary.overdueTasks == 0
                      ? const AppEmptyState(
                          icon: AppIcons.whatsNew,
                          title: 'Все спокойно',
                          message:
                              'Новых изменений с последнего просмотра нет.',
                        )
                      : _RecentActivityList(
                          history: visibleHistory,
                          tasksById: tasksById,
                          boardsById: boardsById,
                        ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _SummaryGrid extends StatelessWidget {
  const _SummaryGrid({required this.summary});

  final _WhatsNewSummary summary;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth < 360
            ? 1
            : constraints.maxWidth < 860
            ? 2
            : 4;
        final tileWidth =
            (constraints.maxWidth - context.spacing.md * (columns - 1)) /
            columns;
        return Wrap(
          spacing: context.spacing.md,
          runSpacing: context.spacing.md,
          children: [
            SizedBox(
              width: tileWidth,
              child: _SummaryTile(
                icon: Icons.edit_note_rounded,
                value: summary.changedTasks,
                label: 'задач изменено',
              ),
            ),
            SizedBox(
              width: tileWidth,
              child: _SummaryTile(
                icon: Icons.comment_outlined,
                value: summary.comments,
                label: 'комментариев',
              ),
            ),
            SizedBox(
              width: tileWidth,
              child: _SummaryTile(
                icon: Icons.add_task_rounded,
                value: summary.newTasks,
                label: 'новые задачи',
              ),
            ),
            SizedBox(
              width: tileWidth,
              child: _SummaryTile(
                icon: Icons.warning_amber_rounded,
                value: summary.overdueTasks,
                label: 'задач просрочено',
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SummaryTile extends StatelessWidget {
  const _SummaryTile({
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 126),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLowest,
          border: Border.all(color: colorScheme.outlineVariant),
          borderRadius: context.radii.card,
        ),
        child: Padding(
          padding: EdgeInsets.all(context.spacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: colorScheme.primary),
              SizedBox(height: context.spacing.sm),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  '$value',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Text(
                label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecentActivityList extends StatelessWidget {
  const _RecentActivityList({
    required this.history,
    required this.tasksById,
    required this.boardsById,
  });

  final List<TaskHistoryEntry> history;
  final Map<String, TaskEntity> tasksById;
  final Map<String, BoardEntity> boardsById;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: history.take(40).length,
      separatorBuilder: (context, index) =>
          SizedBox(height: context.spacing.sm),
      itemBuilder: (context, index) {
        final entry = history[index];
        return _ActivityTile(
          entry: entry,
          task: tasksById[entry.taskId],
          board: boardsById[entry.boardId],
        );
      },
    );
  }
}

class _ActivityTile extends ConsumerWidget {
  const _ActivityTile({
    required this.entry,
    required this.task,
    required this.board,
  });

  final TaskHistoryEntry entry;
  final TaskEntity? task;
  final BoardEntity? board;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final actor = entry.actorUserId == null
        ? null
        : ref
              .watch(userByIdProvider(entry.actorUserId!))
              .maybeWhen(data: (value) => value, orElse: () => null);
    final actorLabel = actor?.fullName ?? entry.actorUserId ?? 'Система';

    return Material(
      color: colorScheme.surfaceContainerLowest,
      shape: RoundedRectangleBorder(
        borderRadius: context.radii.card,
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: ListTile(
        minLeadingWidth: 36,
        contentPadding: EdgeInsets.symmetric(
          horizontal: context.spacing.md,
          vertical: context.spacing.sm,
        ),
        leading: CircleAvatar(
          backgroundColor: colorScheme.primaryContainer,
          child: Icon(_actionIcon(entry.action), color: colorScheme.primary),
        ),
        title: Text(
          entry.summary,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          '${task?.title ?? entry.taskId} · ${board?.title ?? 'Доска'} · $actorLabel · ${_formatDateTime(entry.changedAt)}',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: board == null
            ? null
            : () => context.goNamed(
                AppRoute.boardTasks.name,
                pathParameters: {'boardId': board!.id},
              ),
      ),
    );
  }
}

final class _WhatsNewSummary {
  const _WhatsNewSummary({
    required this.changedTasks,
    required this.comments,
    required this.newTasks,
    required this.overdueTasks,
  });

  factory _WhatsNewSummary.from({
    required List<TaskHistoryEntry> history,
    required List<TaskEntity> tasks,
    required DateTime since,
  }) {
    final changedTaskIds = history
        .where(
          (entry) => {
            'update',
            'assign',
            'unassign',
            'delete',
          }.contains(entry.action),
        )
        .map((entry) => entry.taskId)
        .toSet();
    final comments = history
        .where((entry) => entry.action.startsWith('comment_'))
        .length;
    final newTasks = history.where((entry) => entry.action == 'create').length;
    final today = _dateOnly(DateTime.now());
    final sinceDay = _dateOnly(since);
    final overdueTasks = tasks.where((task) {
      final dueDate = task.dueDate;
      if (dueDate == null || task.isCompleted || task.deletedAt != null) {
        return false;
      }
      final dueDay = _dateOnly(dueDate);
      return !dueDay.isBefore(sinceDay) && dueDay.isBefore(today);
    }).length;

    return _WhatsNewSummary(
      changedTasks: changedTaskIds.length,
      comments: comments,
      newTasks: newTasks,
      overdueTasks: overdueTasks,
    );
  }

  final int changedTasks;
  final int comments;
  final int newTasks;
  final int overdueTasks;
}

final _whatsNewLastSeenProvider = FutureProvider.autoDispose<DateTime?>((ref) {
  final session = ref
      .watch(authControllerProvider)
      .maybeWhen(data: (value) => value, orElse: () => null);
  if (session == null) return Future.value();
  return ref
      .watch(secureStorageProvider)
      .read(_lastSeenKey(session.userId))
      .then((value) => value == null ? null : DateTime.tryParse(value));
});

String _lastSeenKey(String userId) => 'whats_new_last_seen_at_$userId';

DateTime _dateOnly(DateTime value) {
  final local = value.toLocal();
  return DateTime(local.year, local.month, local.day);
}

String _formatDateTime(DateTime value) {
  final local = value.toLocal();
  final day = local.day.toString().padLeft(2, '0');
  final month = local.month.toString().padLeft(2, '0');
  final hour = local.hour.toString().padLeft(2, '0');
  final minute = local.minute.toString().padLeft(2, '0');
  return '$day.$month.${local.year} $hour:$minute';
}

IconData _actionIcon(String action) {
  return switch (action) {
    'create' => Icons.add_task_rounded,
    'assign' || 'unassign' => Icons.person_outline_rounded,
    'delete' => Icons.delete_outline_rounded,
    String() when action.startsWith('comment_') => Icons.comment_outlined,
    _ => Icons.edit_note_rounded,
  };
}
