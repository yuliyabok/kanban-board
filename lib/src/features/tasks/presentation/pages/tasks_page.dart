import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/layout/app_shell.dart';
import '../../../../../core/theme/app_board_background_palette.dart';
import '../../../../../core/theme/app_breakpoints.dart';
import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/theme/app_task_text_color_palette.dart';
import '../../../../app/theme/app_design_tokens.dart';
import '../../../../core/error/result.dart';
import '../../../../shared/ui/app_empty_state.dart';
import '../../../../shared/ui/loading_skeleton.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../board_constructor/presentation/controllers/board_constructor_controller.dart';
import '../../../board_constructor/presentation/controllers/board_constructor_state.dart';
import '../../../board_constructor/presentation/widgets/constructor_appearance_panel.dart';
import '../../../board_constructor/presentation/widgets/constructor_column_card.dart';
import '../../../board_constructor/presentation/widgets/constructor_task_types_panel.dart';
import '../../../board_constructor/presentation/widgets/constructor_toolbar.dart';
import '../../../board_settings/domain/entities/board_card_settings.dart';
import '../../../board_settings/presentation/providers/board_card_settings_providers.dart';
import '../../../board_settings/presentation/widgets/task_card_settings_panel.dart';
import '../../../columns/domain/entities/board_column_entity.dart';
import '../../../columns/presentation/providers/column_providers.dart';
import '../../../task_types/domain/entities/task_type_entity.dart';
import '../../../task_types/presentation/controllers/task_types_controller.dart';
import '../../../task_types/presentation/providers/task_type_providers.dart';
import '../../domain/entities/task_entity.dart';
import '../controllers/tasks_controller.dart';
import '../providers/task_providers.dart';
import '../widgets/board_column_view.dart';
import '../widgets/task_card/subtask_editor.dart';
import '../widgets/task_card/subtask_list.dart';
import '../widgets/task_card/task_card.dart';

class TasksPage extends ConsumerStatefulWidget {
  const TasksPage({
    required this.boardId,
    super.key,
  });

  final String boardId;

  @override
  ConsumerState<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends ConsumerState<TasksPage> {
  final _titleController = TextEditingController();
  final _searchController = TextEditingController();
  final _createTaskFocusNode = FocusNode();
  String _query = '';
  String? _createColumnId;
  TaskEntity? _selectedTask;

  @override
  void dispose() {
    _titleController.dispose();
    _searchController.dispose();
    _createTaskFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tasksState = ref.watch(boardTasksProvider(widget.boardId));
    final columnsState = ref.watch(boardColumnsProvider(widget.boardId));
    final settingsState = ref.watch(boardCardSettingsProvider(widget.boardId));
    final taskTypesState = ref.watch(taskTypesProvider(widget.boardId));
    final constructorState = ref.watch(
      boardConstructorControllerProvider(widget.boardId),
    );
    ref
      ..listen(tasksControllerProvider, (previous, next) {
        if (next case AsyncError(:final error)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.toString())),
          );
        }
      })
      ..listen(taskTypesControllerProvider, (previous, next) {
        if (next case AsyncError(:final error)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.toString())),
          );
        }
      });

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyS, control: true): () {
          unawaited(_saveConstructorChanges());
        },
        const SingleActivator(LogicalKeyboardKey.keyS, meta: true): () {
          unawaited(_saveConstructorChanges());
        },
        const SingleActivator(LogicalKeyboardKey.escape): () {
          unawaited(_handleEscape());
        },
      },
      child: Focus(
        autofocus: true,
        child: constructorState.when(
          loading: () => _buildShell(content: const _TasksSkeleton()),
          error: (error, stackTrace) =>
              _buildShell(content: Center(child: Text(error.toString()))),
          data: (constructor) => settingsState.when(
            loading: () => _buildShell(content: const _TasksSkeleton()),
            error: (error, stackTrace) =>
                _buildShell(content: Center(child: Text(error.toString()))),
            data: (settings) => taskTypesState.when(
              loading: () => _buildShell(content: const _TasksSkeleton()),
              error: (error, stackTrace) =>
                  _buildShell(content: Center(child: Text(error.toString()))),
              data: (taskTypes) => columnsState.when(
                loading: () => _buildShell(content: const _TasksSkeleton()),
                error: (error, stackTrace) =>
                    _buildShell(content: Center(child: Text(error.toString()))),
                data: (columns) => tasksState.when(
                  loading: () => _buildShell(content: const _TasksSkeleton()),
                  error: (error, stackTrace) => _buildShell(
                    content: Center(child: Text(error.toString())),
                  ),
                  data: (tasks) {
                    final filteredTasks = _filterTasks(tasks);
                    return _buildShell(
                      constructor: constructor,
                      firstColumnId: columns.firstOrNull?.id,
                      settings: settings,
                      taskTypes: taskTypes,
                      content: _buildContent(
                        context: context,
                        constructor: constructor,
                        columns: columns,
                        tasks: filteredTasks,
                        allTasks: tasks,
                        settings: settings,
                        taskTypes: taskTypes,
                        hasActiveSearch: _query.trim().isNotEmpty,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShell({
    required Widget content,
    BoardConstructorState? constructor,
    BoardCardSettings? settings,
    String? firstColumnId,
    List<TaskTypeEntity> taskTypes = const [],
  }) {
    final device = AppBreakpoints.of(context);

    return AppShell(
      title: 'Канбан',
      boardName: 'Планирование',
      subtitle: constructor?.isConstructorMode ?? false
          ? 'Режим конструктора: настройка структуры'
          : 'Доска задач и командный workflow',
      searchController: _searchController,
      onSearchChanged: (value) => setState(() => _query = value),
      actions: [
        AppShellAction(
          label: 'Новая задача',
          icon: AppIcons.add,
          isPrimary: !device.isPhone,
          onPressed: constructor?.isConstructorMode ?? false
              ? null
              : () => _openCreateTask(firstColumnId, taskTypes),
        ),
        AppShellAction(
          label: 'Режим конструктора',
          icon: AppIcons.constructor,
          selected: constructor?.isConstructorMode ?? false,
          pinOnMobile: true,
          onPressed: constructor == null
              ? null
              : () {
                  if (constructor.isConstructorMode) {
                    unawaited(_leaveConstructorMode());
                  } else {
                    unawaited(
                      ref
                          .read(
                            boardConstructorControllerProvider(
                              widget.boardId,
                            ).notifier,
                          )
                          .enterConstructorMode(),
                    );
                  }
                },
        ),
        AppShellAction(
          label: 'Настройки карточек',
          icon: Icons.dashboard_customize_outlined,
          onPressed: settings == null
              ? null
              : () => _openCardSettings(settings),
        ),
        AppShellAction(
          label: 'Выйти',
          icon: Icons.logout_rounded,
          onPressed: () {
            unawaited(ref.read(authControllerProvider.notifier).signOut());
          },
        ),
      ],
      content: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1600),
            child: Padding(
              padding: EdgeInsets.all(context.spacing.xl),
              child: content,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent({
    required BuildContext context,
    required BoardConstructorState constructor,
    required List<BoardColumnEntity> columns,
    required List<TaskEntity> tasks,
    required List<TaskEntity> allTasks,
    required BoardCardSettings settings,
    required List<TaskTypeEntity> taskTypes,
    required bool hasActiveSearch,
  }) {
    final constructorController = ref.read(
      boardConstructorControllerProvider(widget.boardId).notifier,
    );
    final firstColumnId = columns.firstOrNull?.id;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Планирование',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: context.spacing.xs),
            Wrap(
              spacing: context.spacing.sm,
              runSpacing: context.spacing.sm,
              children: [
                _FilterChip(label: 'Все', selected: !hasActiveSearch),
                const _FilterChip(label: 'В работе', selected: false),
                const _FilterChip(label: 'Мои задачи', selected: false),
                if (hasActiveSearch)
                  ActionChip(
                    label: const Text('Сбросить поиск'),
                    onPressed: () {
                      _searchController.clear();
                      setState(() => _query = '');
                    },
                  ),
              ],
            ),
          ],
        ),
        if (constructor.isConstructorMode) ...[
          SizedBox(height: context.spacing.md),
          ConstructorToolbar(
            state: constructor,
            onEnter: () =>
                unawaited(constructorController.enterConstructorMode()),
            onDone: () => unawaited(_leaveConstructorMode()),
            onSave: () => unawaited(_saveConstructorChanges()),
            onCancel: () => unawaited(_cancelConstructorChanges()),
            onAddColumn: constructorController.addColumn,
          ),
        ],
        SizedBox(height: context.spacing.lg),
        if (!constructor.isConstructorMode) ...[
          _CreateTaskBar(
            boardId: widget.boardId,
            columnId: _createColumnId ?? firstColumnId,
            controller: _titleController,
            focusNode: _createTaskFocusNode,
            taskTypes: taskTypes,
          ),
          SizedBox(height: context.spacing.lg),
        ],
        Expanded(
          child: constructor.isConstructorMode
              ? _buildConstructorBoard(
                  constructor,
                  allTasks,
                  taskTypes,
                  settings,
                )
              : tasks.isEmpty && hasActiveSearch
              ? AppEmptyState(
                  icon: AppIcons.search,
                  title: 'Ничего не найдено',
                  message: 'Попробуйте изменить запрос или сбросить фильтры.',
                  action: FilledButton(
                    onPressed: () {
                      _searchController.clear();
                      setState(() => _query = '');
                    },
                    child: const Text('Сбросить'),
                  ),
                )
              : Row(
                  children: [
                    Expanded(
                      child: _buildBoard(
                        columns,
                        tasks,
                        allTasks,
                        settings,
                        taskTypes,
                      ),
                    ),
                    if (_selectedTask != null &&
                        AppBreakpoints.of(context).isDesktop) ...[
                      SizedBox(width: context.spacing.lg),
                      _TaskDetailsPanel(
                        task:
                            allTasks
                                .where((task) => task.id == _selectedTask!.id)
                                .firstOrNull ??
                            _selectedTask!,
                        subtasks: allTasks
                            .where(
                              (task) => task.parentTaskId == _selectedTask!.id,
                            )
                            .toList(growable: false),
                        taskTypes: taskTypes,
                        onClose: () => setState(() => _selectedTask = null),
                      ),
                    ],
                  ],
                ),
        ),
      ],
    );
  }

  List<TaskEntity> _filterTasks(List<TaskEntity> tasks) {
    final query = _query.trim().toLowerCase();
    if (query.isEmpty) return tasks;

    return tasks
        .where((task) {
          final description = task.description?.toLowerCase() ?? '';
          return task.title.toLowerCase().contains(query) ||
              description.contains(query);
        })
        .toList(growable: false);
  }

  Future<void> _openCreateTask(
    String? columnId,
    List<TaskTypeEntity> taskTypes,
  ) async {
    final device = AppBreakpoints.of(context);
    if (device.isPhone) {
      await showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.fromLTRB(
              context.spacing.lg,
              0,
              context.spacing.lg,
              MediaQuery.viewInsetsOf(context).bottom + context.spacing.xl,
            ),
            child: _CreateTaskBar(
              boardId: widget.boardId,
              columnId: columnId,
              controller: _titleController,
              taskTypes: taskTypes,
              autofocus: true,
              onSubmitted: () => Navigator.of(context).pop(),
            ),
          );
        },
      );
      return;
    }

    setState(() => _createColumnId = columnId);
    _createTaskFocusNode.requestFocus();
  }

  Future<void> _openCreateTaskForColumn(
    String? columnId,
    List<TaskTypeEntity> taskTypes,
  ) async {
    final controller = TextEditingController();
    try {
      final content = _CreateTaskBar(
        boardId: widget.boardId,
        columnId: columnId,
        controller: controller,
        taskTypes: taskTypes,
        autofocus: true,
        onSubmitted: () => Navigator.of(context).pop(),
      );

      if (AppBreakpoints.of(context).isPhone) {
        await showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          showDragHandle: true,
          builder: (context) {
            return Padding(
              padding: EdgeInsets.fromLTRB(
                context.spacing.lg,
                0,
                context.spacing.lg,
                MediaQuery.viewInsetsOf(context).bottom + context.spacing.xl,
              ),
              child: content,
            );
          },
        );
        return;
      }

      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Добавить задачу'),
          content: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: content,
          ),
        ),
      );
    } finally {
      controller.dispose();
    }
  }

  Widget _buildConstructorBoard(
    BoardConstructorState constructor,
    List<TaskEntity> tasks,
    List<TaskTypeEntity> taskTypes,
    BoardCardSettings settings,
  ) {
    final controller = ref.read(
      boardConstructorControllerProvider(widget.boardId).notifier,
    );
    final typePanel = ConstructorTaskTypesPanel(
      boardId: widget.boardId,
      taskTypes: taskTypes,
    );
    final appearancePanel = ConstructorAppearancePanel(settings: settings);
    final columns = ReorderableListView.builder(
      scrollDirection: Axis.horizontal,
      buildDefaultDragHandles: false,
      itemCount: constructor.draftColumns.length,
      onReorder: (oldIndex, newIndex) {
        controller.reorder(oldIndex: oldIndex, newIndex: newIndex);
      },
      proxyDecorator: (child, index, animation) {
        return AnimatedBuilder(
          animation: animation,
          child: child,
          builder: (context, child) {
            return Transform.scale(
              scale: 1 + animation.value * 0.02,
              child: Material(
                type: MaterialType.transparency,
                child: child,
              ),
            );
          },
        );
      },
      itemBuilder: (context, index) {
        final column = constructor.draftColumns[index];
        final taskCount = tasks
            .where((task) => task.columnId == column.id)
            .length;
        return Padding(
          key: ValueKey(column.id),
          padding: EdgeInsets.only(right: context.spacing.lg),
          child: ConstructorColumnCard(
            column: column,
            index: index,
            taskCount: taskCount,
            isSelected: constructor.selectedColumnId == column.id,
            isEditing: constructor.editingColumnId == column.id,
            errorText: constructor.validationErrors[column.id],
            onSelected: () => controller.selectColumn(column.id),
            onStartEditing: () => controller.startEditing(column.id),
            onTitleChanged: (title) {
              controller.updateTitle(columnId: column.id, title: title);
            },
            onFinishEditing: () => controller.finishEditing(column.id),
            onCancelEditing: controller.cancelEditing,
            onDelete: () => unawaited(
              _confirmColumnDelete(
                column: column,
                constructor: constructor,
                tasks: tasks,
              ),
            ),
          ),
        );
      },
    );
    final board = constructor.draftColumns.isEmpty
        ? AppEmptyState(
            icon: Icons.view_column_outlined,
            title: 'Структура доски пуста',
            message: 'Добавьте первый столбец, чтобы собрать рабочий процесс.',
            action: FilledButton.icon(
              onPressed: controller.addColumn,
              icon: const Icon(Icons.add_rounded),
              label: const Text('Добавить столбец'),
            ),
          )
        : columns;

    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 980;
        if (compact) {
          final panelWidth = constraints.maxWidth.clamp(280, 360).toDouble();
          return Column(
            children: [
              SizedBox(
                height: 360,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(width: panelWidth, child: typePanel),
                    SizedBox(width: context.spacing.lg),
                    SizedBox(width: panelWidth, child: appearancePanel),
                  ],
                ),
              ),
              SizedBox(height: context.spacing.lg),
              Expanded(child: board),
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 340,
              child: ListView(
                children: [
                  SizedBox(height: 360, child: typePanel),
                  SizedBox(height: context.spacing.lg),
                  appearancePanel,
                ],
              ),
            ),
            SizedBox(width: context.spacing.lg),
            Expanded(child: board),
          ],
        );
      },
    );
  }

  Widget _buildBoard(
    List<BoardColumnEntity> columns,
    List<TaskEntity> tasks,
    List<TaskEntity> allTasks,
    BoardCardSettings settings,
    List<TaskTypeEntity> taskTypes,
  ) {
    if (tasks.isEmpty && columns.isEmpty) {
      return const _EmptyTasks();
    }

    if (columns.isEmpty) {
      return _buildFlatTaskList(tasks);
    }

    final unassignedTasks = tasks
        .where((task) => task.columnId == null)
        .toList(growable: false);

    final columnItems = [
      for (final column in columns)
        (
          title: column.title,
          columnId: column.id,
          tasks: tasks
              .where((task) => task.columnId == column.id)
              .toList(growable: false),
        ),
      if (unassignedTasks.isNotEmpty)
        (title: 'Без статуса', columnId: null, tasks: unassignedTasks),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final device = AppBreakpoints.fromWidth(constraints.maxWidth);
        final gap = context.spacing.lg;
        final count = columnItems.length;
        final availableWidth = constraints.maxWidth - gap * (count - 1);
        final fillColumns = device.isDesktop && count <= 4;
        final columnWidth = fillColumns
            ? (availableWidth / count).clamp(280.0, constraints.maxWidth)
            : null;

        Widget buildColumn(
          ({
            String title,
            String? columnId,
            List<TaskEntity> tasks,
          })
          item,
        ) {
          return BoardColumnView(
            title: item.title,
            tasks: item.tasks,
            allTasks: allTasks,
            settings: settings,
            taskTypes: taskTypes,
            width: columnWidth,
            onToggleTask: _toggleTask,
            onDeleteTask: _deleteTask,
            onAddTask: () => unawaited(
              _openCreateTaskForColumn(item.columnId, taskTypes),
            ),
            onMoveTaskHere: (task) {
              unawaited(
                ref
                    .read(tasksControllerProvider.notifier)
                    .moveToColumn(
                      boardId: widget.boardId,
                      task: task,
                      columnId: item.columnId,
                    ),
              );
            },
            onAddSubtask: _openAddSubtask,
            onToggleSubtask: _toggleSubtask,
            onOpenTask: _openTaskDetails,
            onReorderTask: (oldIndex, newIndex) {
              unawaited(
                ref
                    .read(tasksControllerProvider.notifier)
                    .reorderInColumn(
                      boardId: widget.boardId,
                      columnId: item.columnId,
                      oldIndex: oldIndex,
                      newIndex: newIndex,
                    ),
              );
            },
          );
        }

        if (fillColumns) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var index = 0; index < columnItems.length; index++) ...[
                if (index > 0) SizedBox(width: gap),
                Expanded(child: buildColumn(columnItems[index])),
              ],
            ],
          );
        }

        return ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: columnItems.length,
          separatorBuilder: (context, index) => SizedBox(width: gap),
          itemBuilder: (context, index) => buildColumn(columnItems[index]),
        );
      },
    );
  }

  Widget _buildFlatTaskList(List<TaskEntity> tasks) {
    final settings =
        ref.watch(boardCardSettingsProvider(widget.boardId)).asData?.value ??
        BoardCardSettings.defaults(widget.boardId);
    final taskTypes =
        ref.watch(taskTypesProvider(widget.boardId)).asData?.value ?? const [];
    return ReorderableListView.builder(
      buildDefaultDragHandles: false,
      itemCount: tasks.length,
      onReorder: (oldIndex, newIndex) {
        unawaited(
          ref
              .read(tasksControllerProvider.notifier)
              .reorder(
                boardId: widget.boardId,
                oldIndex: oldIndex,
                newIndex: newIndex,
              ),
        );
      },
      itemBuilder: (context, index) {
        final task = tasks[index];
        final parentTask = task.parentTaskId == null
            ? null
            : tasks.where((item) => item.id == task.parentTaskId).firstOrNull;
        return Padding(
          key: ValueKey(task.id),
          padding: EdgeInsets.only(bottom: context.spacing.sm),
          child: TaskCard(
            index: index,
            task: task,
            parentTask: parentTask,
            subtasks: tasks
                .where((item) => item.parentTaskId == task.id)
                .toList(growable: false),
            settings: settings,
            taskType: taskTypes
                .where((type) => type.id == task.taskTypeId)
                .firstOrNull,
            onOpen: () => _openTaskDetails(task),
            onToggle: () => _toggleTask(task.id),
            onDelete: () => _deleteTask(task.id),
            onAddSubtask: () => _openAddSubtask(task),
            onToggleSubtask: _toggleSubtask,
          ),
        );
      },
    );
  }

  Future<void> _openCardSettings(BoardCardSettings settings) {
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => TaskCardSettingsPanel(settings: settings),
    );
  }

  void _toggleTask(String taskId) {
    unawaited(
      ref
          .read(tasksControllerProvider.notifier)
          .toggleComplete(
            boardId: widget.boardId,
            taskId: taskId,
          ),
    );
  }

  void _deleteTask(String taskId) {
    unawaited(ref.read(tasksControllerProvider.notifier).delete(taskId));
  }

  Future<void> _openTaskDetails(TaskEntity task) async {
    final tasks =
        ref.read(boardTasksProvider(widget.boardId)).asData?.value ??
        const <TaskEntity>[];
    final subtasks = tasks
        .where((item) => item.parentTaskId == task.id)
        .toList(growable: false);
    final taskTypes =
        ref.read(taskTypesProvider(widget.boardId)).asData?.value ?? const [];
    if (!AppBreakpoints.of(context).isDesktop) {
      await showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (context) => Padding(
          padding: EdgeInsets.fromLTRB(
            context.spacing.lg,
            0,
            context.spacing.lg,
            context.spacing.xl,
          ),
          child: _TaskDetailsPanel(
            task: task,
            subtasks: subtasks,
            taskTypes: taskTypes,
          ),
        ),
      );
      return;
    }

    setState(() => _selectedTask = task);
  }

  Future<void> _openAddSubtask(TaskEntity parent) {
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            context.spacing.lg,
            0,
            context.spacing.lg,
            MediaQuery.viewInsetsOf(context).bottom + context.spacing.xl,
          ),
          child: SubtaskEditor(parent: parent),
        );
      },
    );
  }

  void _toggleSubtask(TaskEntity subtask) {
    unawaited(
      ref.read(tasksControllerProvider.notifier).toggleSubtask(subtask),
    );
  }

  Future<void> _saveConstructorChanges() async {
    final constructor = ref
        .read(boardConstructorControllerProvider(widget.boardId))
        .asData
        ?.value;
    if (constructor == null ||
        !constructor.isConstructorMode ||
        !constructor.hasUnsavedChanges ||
        constructor.isSaving) {
      return;
    }

    final result = await ref
        .read(boardConstructorControllerProvider(widget.boardId).notifier)
        .save();
    if (!mounted) return;

    switch (result) {
      case Success<void>():
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Структура доски сохранена')),
        );
      case Error<void>(:final failure):
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(failure.message)),
        );
    }
  }

  Future<void> _cancelConstructorChanges() async {
    final constructor = ref
        .read(boardConstructorControllerProvider(widget.boardId))
        .asData
        ?.value;
    if (constructor == null) return;
    if (!constructor.hasUnsavedChanges) {
      ref
          .read(boardConstructorControllerProvider(widget.boardId).notifier)
          .exitWithoutChanges();
      return;
    }

    final shouldCancel = await _confirmDiscardChanges();
    if (!mounted || !shouldCancel) return;

    ref
        .read(boardConstructorControllerProvider(widget.boardId).notifier)
        .exitWithoutChanges();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Изменения конструктора отменены')),
    );
  }

  Future<void> _leaveConstructorMode() async {
    final constructor = ref
        .read(boardConstructorControllerProvider(widget.boardId))
        .asData
        ?.value;
    if (constructor == null) return;
    if (constructor.hasUnsavedChanges) {
      final shouldDiscard = await _confirmDiscardChanges();
      if (!mounted || !shouldDiscard) return;
    }
    ref
        .read(boardConstructorControllerProvider(widget.boardId).notifier)
        .exitWithoutChanges();
  }

  Future<void> _handleEscape() async {
    final constructor = ref
        .read(boardConstructorControllerProvider(widget.boardId))
        .asData
        ?.value;
    if (constructor == null || !constructor.isConstructorMode) return;

    final controller = ref.read(
      boardConstructorControllerProvider(widget.boardId).notifier,
    );
    if (constructor.editingColumnId != null) {
      controller.cancelEditing();
      return;
    }

    await _leaveConstructorMode();
  }

  Future<bool> _confirmDiscardChanges() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Отменить изменения?'),
        content: const Text(
          'Несохраненные изменения структуры доски будут потеряны.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Назад'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Отменить изменения'),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  Future<void> _confirmColumnDelete({
    required BoardColumnEntity column,
    required BoardConstructorState constructor,
    required List<TaskEntity> tasks,
  }) async {
    final taskCount = tasks.where((task) => task.columnId == column.id).length;
    final targetColumns = constructor.draftColumns
        .where((item) => item.id != column.id)
        .toList(growable: false);

    final plan = await showDialog<DeletedColumnTaskPlan?>(
      context: context,
      builder: (context) {
        if (taskCount == 0) {
          return AlertDialog(
            title: Text('Удалить «${column.title}»?'),
            content: const Text('Столбец будет удален из черновика доски.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Отмена'),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(
                  const DeletedColumnTaskPlan.deleteTasks(),
                ),
                child: const Text('Удалить'),
              ),
            ],
          );
        }

        var deleteTasks = true;
        String? transferTargetId = targetColumns.firstOrNull?.id;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Удалить «${column.title}»?'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'В столбце есть задачи: $taskCount. Выберите, что с ними сделать.',
                  ),
                  SizedBox(height: context.spacing.md),
                  SegmentedButton<bool>(
                    segments: const [
                      ButtonSegment<bool>(
                        value: true,
                        label: Text('Удалить задачи'),
                        icon: Icon(Icons.delete_outline_rounded),
                      ),
                      ButtonSegment<bool>(
                        value: false,
                        label: Text('Перенести'),
                        icon: Icon(Icons.move_down_rounded),
                      ),
                    ],
                    selected: {deleteTasks},
                    onSelectionChanged: targetColumns.isEmpty
                        ? null
                        : (selection) {
                            setState(() => deleteTasks = selection.first);
                          },
                  ),
                  if (!deleteTasks)
                    DropdownButtonFormField<String>(
                      initialValue: transferTargetId,
                      items: [
                        for (final target in targetColumns)
                          DropdownMenuItem(
                            value: target.id,
                            child: Text(target.title),
                          ),
                      ],
                      onChanged: (value) {
                        setState(() => transferTargetId = value);
                      },
                      decoration: const InputDecoration(
                        hintText: 'Куда перенести задачи',
                      ),
                    ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Отмена'),
                ),
                FilledButton(
                  onPressed: () {
                    if (deleteTasks) {
                      Navigator.of(context).pop(
                        const DeletedColumnTaskPlan.deleteTasks(),
                      );
                    } else if (transferTargetId != null) {
                      Navigator.of(context).pop(
                        DeletedColumnTaskPlan.transferTasks(transferTargetId),
                      );
                    }
                  },
                  child: const Text('Удалить столбец'),
                ),
              ],
            );
          },
        );
      },
    );

    if (!mounted || plan == null) return;
    ref
        .read(boardConstructorControllerProvider(widget.boardId).notifier)
        .removeColumn(columnId: column.id, taskPlan: plan);
  }
}

class _CreateTaskBar extends ConsumerStatefulWidget {
  const _CreateTaskBar({
    required this.boardId,
    required this.columnId,
    required this.controller,
    required this.taskTypes,
    this.autofocus = false,
    this.focusNode,
    this.onSubmitted,
  });

  final String boardId;
  final String? columnId;
  final TextEditingController controller;
  final List<TaskTypeEntity> taskTypes;
  final bool autofocus;
  final FocusNode? focusNode;
  final VoidCallback? onSubmitted;

  @override
  ConsumerState<_CreateTaskBar> createState() => _CreateTaskBarState();
}

class _CreateTaskBarState extends ConsumerState<_CreateTaskBar> {
  String? _selectedTaskTypeId;

  @override
  void didUpdateWidget(_CreateTaskBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_selectedTaskTypeId != null &&
        !widget.taskTypes.any((type) => type.id == _selectedTaskTypeId)) {
      _selectedTaskTypeId = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final titleField = TextField(
      controller: widget.controller,
      autofocus: widget.autofocus,
      focusNode: widget.focusNode,
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        hintText: 'Добавить задачу',
        prefixIcon: Icon(Icons.add_task_rounded),
      ),
      onSubmitted: (_) => _submit(ref),
    );
    final typeField = DropdownButtonFormField<String?>(
      initialValue: _selectedTaskTypeId,
      items: [
        const DropdownMenuItem<String?>(
          child: Text('Без типа'),
        ),
        for (final type in widget.taskTypes)
          DropdownMenuItem<String?>(
            value: type.id,
            child: Text(type.name, overflow: TextOverflow.ellipsis),
          ),
      ],
      onChanged: (value) => setState(() => _selectedTaskTypeId = value),
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.category_outlined),
        hintText: 'Тип',
      ),
    );
    final submitButton = FilledButton.icon(
      onPressed: () => _submit(ref),
      icon: const Icon(Icons.add_rounded),
      label: const Text('Добавить'),
    );

    if (AppBreakpoints.of(context).isPhone) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleField,
          SizedBox(height: context.spacing.sm),
          typeField,
          SizedBox(height: context.spacing.sm),
          submitButton,
        ],
      );
    }

    return Row(
      children: [
        Expanded(child: titleField),
        const SizedBox(width: 10),
        SizedBox(width: 220, child: typeField),
        const SizedBox(width: 10),
        submitButton,
      ],
    );
  }

  Future<void> _submit(WidgetRef ref) async {
    final title = widget.controller.text;
    await ref
        .read(tasksControllerProvider.notifier)
        .create(
          boardId: widget.boardId,
          columnId: widget.columnId,
          title: title,
          taskTypeId: _selectedTaskTypeId,
        );
    widget.controller.clear();
    widget.onSubmitted?.call();
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
  });

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      selected: selected,
      onSelected: (_) {},
      label: Text(label),
    );
  }
}

class _TaskDetailsPanel extends ConsumerWidget {
  const _TaskDetailsPanel({
    required this.task,
    required this.subtasks,
    required this.taskTypes,
    this.onClose,
  });

  final TaskEntity task;
  final List<TaskEntity> subtasks;
  final List<TaskTypeEntity> taskTypes;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final selectedTypeId = taskTypes.any((type) => type.id == task.taskTypeId)
        ? task.taskTypeId
        : null;

    return Container(
      width: AppBreakpoints.of(context).isPhone ? double.infinity : 360,
      constraints: const BoxConstraints(maxHeight: 720),
      padding: EdgeInsets.all(context.spacing.lg),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        border: Border.all(color: colorScheme.outlineVariant),
        borderRadius: context.radii.sheet,
        boxShadow: context.shadows.popover,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Детали задачи',
                  style: textTheme.titleLarge,
                ),
              ),
              IconButton(
                tooltip: 'Редактировать оформление',
                onPressed: () => unawaited(_editAppearance(context, ref)),
                icon: const Icon(Icons.palette_outlined),
              ),
              if (onClose != null)
                IconButton(
                  tooltip: 'Закрыть',
                  onPressed: onClose,
                  icon: const Icon(AppIcons.close),
                ),
            ],
          ),
          SizedBox(height: context.spacing.lg),
          Text(task.title, style: textTheme.headlineSmall),
          SizedBox(height: context.spacing.md),
          CheckboxListTile(
            value: task.isCompleted,
            onChanged: (_) {
              unawaited(
                ref
                    .read(tasksControllerProvider.notifier)
                    .toggleComplete(
                      boardId: task.boardId,
                      taskId: task.id,
                    ),
              );
            },
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(task.isCompleted ? 'Завершена' : 'В работе'),
          ),
          SizedBox(height: context.spacing.md),
          Text(
            task.description?.isNotEmpty ?? false
                ? task.description!
                : 'Описание пока не добавлено.',
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: context.spacing.xl),
          DropdownButtonFormField<String?>(
            initialValue: selectedTypeId,
            items: [
              const DropdownMenuItem<String?>(
                child: Text('Без типа'),
              ),
              for (final type in taskTypes)
                DropdownMenuItem<String?>(
                  value: type.id,
                  child: Text(type.name, overflow: TextOverflow.ellipsis),
                ),
            ],
            onChanged: (value) {
              unawaited(
                ref
                    .read(tasksControllerProvider.notifier)
                    .updateTaskType(
                      task: task,
                      taskTypeId: value,
                    ),
              );
            },
            decoration: const InputDecoration(
              labelText: 'Тип задачи',
              prefixIcon: Icon(Icons.category_outlined),
            ),
          ),
          SizedBox(height: context.spacing.lg),
          Wrap(
            spacing: context.spacing.sm,
            runSpacing: context.spacing.sm,
            children: const [
              Chip(
                avatar: Icon(Icons.flag_outlined, size: 16),
                label: Text('Medium priority'),
                visualDensity: VisualDensity.compact,
              ),
              Chip(
                avatar: Icon(Icons.schedule_rounded, size: 16),
                label: Text('Сегодня'),
                visualDensity: VisualDensity.compact,
              ),
              Chip(
                avatar: Icon(Icons.comment_outlined, size: 16),
                label: Text('0 комментариев'),
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
          SizedBox(height: context.spacing.xl),
          Text('Подзадачи', style: textTheme.titleMedium),
          SizedBox(height: context.spacing.sm),
          SubtaskList(
            subtasks: subtasks,
            onToggle: (subtask) {
              // Details panel is presentation-only; task mutation is wired from cards.
            },
          ),
          SizedBox(height: context.spacing.md),
          SubtaskEditor(parent: task),
          SizedBox(height: context.spacing.xl),
          Divider(color: colorScheme.outlineVariant),
          SizedBox(height: context.spacing.md),
          Text('Активность', style: textTheme.titleMedium),
          SizedBox(height: context.spacing.sm),
          Text(
            'Обновлено ${task.updatedAt.toLocal()}',
            style: textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Future<void> _editAppearance(BuildContext context, WidgetRef ref) async {
    final updated = await showDialog<TaskEntity>(
      context: context,
      builder: (context) => _TaskAppearanceDialog(task: task),
    );
    if (updated == null) return;
    unawaited(ref.read(tasksControllerProvider.notifier).updateTask(updated));
  }
}

class _TaskAppearanceDialog extends StatefulWidget {
  const _TaskAppearanceDialog({required this.task});

  final TaskEntity task;

  @override
  State<_TaskAppearanceDialog> createState() => _TaskAppearanceDialogState();
}

class _TaskAppearanceDialogState extends State<_TaskAppearanceDialog> {
  String? _backgroundColor;
  String? _textColor;

  @override
  void initState() {
    super.initState();
    _backgroundColor = widget.task.cardBackgroundColor;
    _textColor = widget.task.cardTextColor;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Оформление карточки'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Фон', style: Theme.of(context).textTheme.labelLarge),
          SizedBox(height: context.spacing.sm),
          _TaskBackgroundPicker(
            selectedId: _backgroundColor,
            onSelected: (value) => setState(() => _backgroundColor = value),
          ),
          SizedBox(height: context.spacing.lg),
          Text('Шрифт', style: Theme.of(context).textTheme.labelLarge),
          SizedBox(height: context.spacing.sm),
          _TaskTextColorPicker(
            selectedId: _textColor,
            onSelected: (value) => setState(() => _textColor = value),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(
            widget.task.copyWith(
              cardBackgroundColor: null,
              cardTextColor: null,
            ),
          ),
          child: const Text('Сбросить'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(
            widget.task.copyWith(
              cardBackgroundColor: _backgroundColor,
              cardTextColor: _textColor,
            ),
          ),
          child: const Text('Сохранить'),
        ),
      ],
    );
  }
}

class _TaskBackgroundPicker extends StatelessWidget {
  const _TaskBackgroundPicker({
    required this.selectedId,
    required this.onSelected,
  });

  final String? selectedId;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: context.spacing.sm,
      runSpacing: context.spacing.sm,
      children: [
        _ColorChoice(
          selected: selectedId == null,
          color: Theme.of(context).colorScheme.surfaceContainerLowest,
          label: 'Default',
          onTap: () => onSelected(null),
        ),
        for (final color in AppBoardBackgroundPalette.colors)
          _ColorChoice(
            selected: selectedId == color.id,
            color: color.resolveCard(Theme.of(context).brightness),
            label: color.label,
            onTap: () => onSelected(color.id),
          ),
      ],
    );
  }
}

class _TaskTextColorPicker extends StatelessWidget {
  const _TaskTextColorPicker({
    required this.selectedId,
    required this.onSelected,
  });

  final String? selectedId;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: context.spacing.sm,
      runSpacing: context.spacing.sm,
      children: [
        _ColorChoice(
          selected: selectedId == null,
          color: Theme.of(context).colorScheme.onSurface,
          label: 'Default',
          onTap: () => onSelected(null),
        ),
        for (final color in AppTaskTextColorPalette.colors)
          _ColorChoice(
            selected: selectedId == color.id,
            color: color.resolve(Theme.of(context).brightness),
            label: color.label,
            onTap: () => onSelected(color.id),
          ),
      ],
    );
  }
}

class _ColorChoice extends StatelessWidget {
  const _ColorChoice({
    required this.selected,
    required this.color,
    required this.label,
    required this.onTap,
  });

  final bool selected;
  final Color color;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(context.radii.sm),
        child: Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(context.radii.sm),
            border: Border.all(
              color: selected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.outlineVariant,
              width: selected ? 2 : 1,
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyTasks extends StatelessWidget {
  const _EmptyTasks();

  @override
  Widget build(BuildContext context) {
    return const AppEmptyState(
      icon: Icons.task_alt_rounded,
      title: 'Здесь пока тихо',
      message:
          'Добавьте первую задачу или включите режим конструктора, чтобы создать структуру доски.',
    );
  }
}

class _TasksSkeleton extends StatelessWidget {
  const _TasksSkeleton();

  @override
  Widget build(BuildContext context) {
    return LoadingSkeleton(
      child: ListView.separated(
        itemCount: 8,
        separatorBuilder: (context, index) =>
            SizedBox(height: context.spacing.sm),
        itemBuilder: (context, index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: context.radii.card,
            ),
            child: Padding(
              padding: EdgeInsets.all(context.spacing.lg),
              child: const Row(
                children: [
                  SkeletonBlock(width: 22, height: 22, radius: 6),
                  SizedBox(width: 14),
                  Expanded(child: SkeletonBlock(height: 16)),
                  SizedBox(width: 14),
                  SkeletonBlock(width: 56, height: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
