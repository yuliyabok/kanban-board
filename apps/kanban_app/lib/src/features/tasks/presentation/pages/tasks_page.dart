import 'dart:async';
import 'dart:convert';

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
import '../../../../core/providers/core_providers.dart';
import '../../../../shared/ui/app_empty_state.dart';
import '../../../../shared/ui/loading_skeleton.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../board_members/presentation/widgets/board_members_panel.dart';
import '../../../board_constructor/presentation/controllers/board_constructor_controller.dart';
import '../../../board_constructor/presentation/controllers/board_constructor_state.dart';
import '../../../board_constructor/application/deleted_column_task_plan.dart';
import '../../../board_constructor/presentation/widgets/constructor_appearance_panel.dart';
import '../../../board_constructor/presentation/widgets/constructor_column_card.dart';
import '../../../board_constructor/presentation/widgets/constructor_task_types_panel.dart';
import '../../../board_constructor/presentation/widgets/constructor_toolbar.dart';
import '../../../board_settings/domain/entities/board_card_settings.dart';
import '../../../board_settings/presentation/widgets/task_card_settings_panel.dart';
import '../../../columns/domain/entities/board_column_entity.dart';
import '../../../task_assignees/domain/entities/task_assignee_entity.dart';
import '../../../task_types/domain/entities/task_type_entity.dart';
import '../../../task_types/presentation/controllers/task_types_controller.dart';
import '../../../task_assignees/presentation/providers/task_assignee_providers.dart';
import '../../../task_assignees/presentation/widgets/assigned_users_section.dart';
import '../../../task_assignees/presentation/widgets/my_tasks_filter.dart';
import '../../../comments/presentation/widgets/task_comments_section.dart';
import '../../../comments/presentation/providers/task_comment_providers.dart';
import '../../../users/presentation/providers/user_providers.dart';
import '../../application/queries/board_view_query.dart';
import '../../application/state/board_view_state.dart';
import '../../application/state/task_view_model.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/value_objects/task_filter.dart';
import '../../domain/value_objects/task_enums.dart';
import '../controllers/tasks_controller.dart';
import '../providers/board_view_providers.dart';
import '../providers/task_providers.dart';
import '../widgets/board_column_view.dart';
import '../widgets/task_card/subtask_editor.dart';
import '../widgets/task_card/subtask_list.dart';
import '../widgets/task_card/task_card.dart';
import '../widgets/task_card/task_card_models.dart';

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
  final _boardHorizontalController = ScrollController();
  final _createTaskFocusNode = FocusNode();
  String _query = '';
  bool _myTasksOnly = false;
  bool _inProgressOnly = false;
  TaskPriority? _priorityFilter;
  String? _createColumnId;

  @override
  void initState() {
    super.initState();
    unawaited(
      ref
          .read(secureStorageProvider)
          .write(key: 'last_board_id', value: widget.boardId),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _searchController.dispose();
    _boardHorizontalController.dispose();
    _createTaskFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session = ref
        .watch(authControllerProvider)
        .maybeWhen(data: (value) => value, orElse: () => null);
    final myTaskIds = session == null
        ? const <String>{}
        : ref
              .watch(
                myTaskAssigneeIdsProvider((
                  boardId: widget.boardId,
                  userId: session.userId,
                )),
              )
              .maybeWhen(
                data: (value) => value,
                orElse: () => const <String>{},
              );
    final boardViewState = ref.watch(
      boardViewProvider(
        BoardViewArgs(
          boardId: widget.boardId,
          filters: TaskFilter(
            query: _query,
            myTaskIds: myTaskIds,
            myTasksOnly: _myTasksOnly,
            inProgressOnly: _inProgressOnly,
            priority: _priorityFilter,
          ),
        ),
      ),
    );
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
          data: (constructor) => boardViewState.when(
            loading: () => _buildShell(content: const _TasksSkeleton()),
            error: (error, stackTrace) =>
                _buildShell(content: Center(child: Text(error.toString()))),
            data: (boardView) => _buildShell(
              constructor: constructor,
              firstColumnId: boardView.rawColumns.firstOrNull?.id,
              settings: boardView.settings,
              taskTypes: boardView.taskTypes,
              content: _buildContent(
                context: context,
                constructor: constructor,
                boardView: boardView,
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
          isPrimary: true,
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
          label: 'Участники',
          icon: Icons.group_outlined,
          onPressed: _openBoardMembers,
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
    required BoardViewState boardView,
  }) {
    final constructorController = ref.read(
      boardConstructorControllerProvider(widget.boardId).notifier,
    );
    final firstColumnId = boardView.rawColumns.firstOrNull?.id;
    final device = AppBreakpoints.of(context);
    final isPhone = device.isPhone;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hide filters and title on mobile to maximize board space
        if (!isPhone)
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
                  _FilterChip(
                    label: 'Все',
                    selected: !boardView.hasActiveFilters,
                    onSelected: (_) => _resetFilters(),
                  ),
                  _FilterChip(
                    label: 'В работе',
                    selected: _inProgressOnly,
                    onSelected: (selected) {
                      setState(() => _inProgressOnly = selected);
                    },
                  ),
                  MyTasksFilter(
                    selected: _myTasksOnly,
                    onSelected: (selected) {
                      setState(() => _myTasksOnly = selected);
                    },
                  ),
                  _PriorityFilterButton(
                    selectedPriority: _priorityFilter,
                    onSelected: (priority) {
                      setState(() => _priorityFilter = priority);
                    },
                  ),
                  if (boardView.hasActiveSearch)
                    ActionChip(
                      label: const Text('Сбросить поиск'),
                      onPressed: () {
                        _searchController.clear();
                        setState(() => _query = '');
                      },
                    ),
                  if (boardView.hasActiveFilters)
                    ActionChip(
                      avatar: const Icon(Icons.filter_alt_off_outlined),
                      label: const Text('Сбросить фильтры'),
                      onPressed: _resetFilters,
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
        if (!isPhone)
          SizedBox(height: context.spacing.lg),
        // Hide create task bar on mobile to maximize board space
        if (!isPhone && !constructor.isConstructorMode) ...[
          _CreateTaskBar(
            boardId: widget.boardId,
            columnId: _createColumnId ?? firstColumnId,
            controller: _titleController,
            focusNode: _createTaskFocusNode,
            taskTypes: boardView.taskTypes,
          ),
          SizedBox(height: context.spacing.lg),
        ],
        Expanded(
          child: constructor.isConstructorMode
              ? _buildConstructorBoard(
                  constructor,
                  boardView.allTasks,
                  boardView.taskTypes,
                  boardView.settings,
                )
              : boardView.filteredTasks.isEmpty && boardView.hasActiveSearch
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
              : boardView.filteredTasks.isEmpty && boardView.hasActiveFilters
              ? AppEmptyState(
                  icon: Icons.filter_alt_off_outlined,
                  title: 'Нет задач по фильтрам',
                  message: 'Сбросьте фильтры или выберите другой приоритет.',
                  action: FilledButton(
                    onPressed: _resetFilters,
                    child: const Text('Сбросить'),
                  ),
                )
              : _buildBoard(boardView),
        ),
      ],
    );
  }

  void _resetFilters() {
    _searchController.clear();
    setState(() {
      _query = '';
      _myTasksOnly = false;
      _inProgressOnly = false;
      _priorityFilter = null;
    });
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

  Widget _buildBoard(BoardViewState boardView) {
    if (boardView.isEmpty) {
      return const _EmptyTasks();
    }

    if (boardView.rawColumns.isEmpty) {
      return _buildFlatTaskList(boardView);
    }

    final columnItems = [
      for (final column in boardView.columns)
        (title: column.title, columnId: column.columnId, tasks: column.tasks),
      if (boardView.unassignedTasks.isNotEmpty)
        (
          title: 'Без статуса',
          columnId: null,
          tasks: boardView.unassignedTasks,
        ),
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
            List<TaskViewModel> tasks,
          })
          item,
        ) {
          return BoardColumnView(
            title: item.title,
            tasks: item.tasks,
            settings: boardView.settings,
            width: columnWidth,
            onToggleTask: _toggleTask,
            onDeleteTask: _deleteTask,
            onAddTask: () => unawaited(
              _openCreateTaskForColumn(item.columnId, boardView.taskTypes),
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
            onOpenTask: (viewModel) {
              unawaited(_openTaskDetails(viewModel, boardView.taskTypes));
            },
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

        return Scrollbar(
          controller: _boardHorizontalController,
          thumbVisibility: device.isDesktop,
          notificationPredicate: (notification) =>
              notification.metrics.axis == Axis.horizontal,
          child: SingleChildScrollView(
            controller: _boardHorizontalController,
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var index = 0; index < columnItems.length; index++) ...[
                  if (index > 0) SizedBox(width: gap),
                  buildColumn(columnItems[index]),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFlatTaskList(BoardViewState boardView) {
    final tasks = [
      for (final task in boardView.filteredTasks)
        TaskViewModel(
          task: task,
          parentTask: task.parentTaskId == null
              ? null
              : boardView.allTasks
                    .where((item) => item.id == task.parentTaskId)
                    .firstOrNull,
          subtasks: boardView.allTasks
              .where((item) => item.parentTaskId == task.id)
              .toList(growable: false),
          taskType: boardView.taskTypes
              .where((type) => type.id == task.taskTypeId)
              .firstOrNull,
        ),
    ];
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
        final viewModel = tasks[index];
        final task = viewModel.task;
        return Padding(
          key: ValueKey(task.id),
          padding: EdgeInsets.only(bottom: context.spacing.sm),
          child: TaskCard(
            index: index,
            task: task,
            parentTask: viewModel.parentTask,
            subtasks: viewModel.subtasks,
            settings: boardView.settings,
            taskType: viewModel.taskType,
            onOpen: () => unawaited(
              _openTaskDetails(viewModel, boardView.taskTypes),
            ),
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

  Future<void> _openBoardMembers() {
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        content: SizedBox(
          width: 420,
          height: 520,
          child: BoardMembersPanel(boardId: widget.boardId),
        ),
      ),
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

  Future<void> _openTaskDetails(
    TaskViewModel viewModel,
    List<TaskTypeEntity> taskTypes,
  ) async {
    final task = viewModel.task;
    if (AppBreakpoints.of(context).isPhone) {
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
            subtasks: viewModel.subtasks,
            taskTypes: taskTypes,
          ),
        ),
      );
      return;
    }

    await showDialog<void>(
      context: context,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.all(context.spacing.xl),
        child: _TaskDetailsPanel(
          task: task,
          subtasks: viewModel.subtasks,
          taskTypes: taskTypes,
          onClose: () => Navigator.of(context).pop(),
        ),
      ),
    );
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
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

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
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        hintText: 'Добавить задачу',
        prefixIcon: Icon(Icons.add_task_rounded),
      ),
      onSubmitted: (_) => _submit(ref),
    );
    
    final descriptionField = TextField(
      controller: _descriptionController,
      maxLines: 3,
      minLines: 1,
      decoration: const InputDecoration(
        hintText: 'Описание (опционально)',
        prefixIcon: Icon(Icons.description_outlined),
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
          descriptionField,
          SizedBox(height: context.spacing.sm),
          typeField,
          SizedBox(height: context.spacing.sm),
          submitButton,
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(child: titleField),
            const SizedBox(width: 10),
            SizedBox(width: 220, child: typeField),
            const SizedBox(width: 10),
            submitButton,
          ],
        ),
        SizedBox(height: context.spacing.sm),
        descriptionField,
      ],
    );
  }

  Future<void> _submit(WidgetRef ref) async {
    final title = widget.controller.text;
    final description = _descriptionController.text.isEmpty
        ? null
        : _descriptionController.text;
    
    await ref
        .read(tasksControllerProvider.notifier)
        .create(
          boardId: widget.boardId,
          columnId: widget.columnId,
          title: title,
          taskTypeId: _selectedTaskTypeId,
          description: description,
        );
    widget.controller.clear();
    _descriptionController.clear();
    widget.onSubmitted?.call();
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      selected: selected,
      onSelected: onSelected,
      label: Text(label),
    );
  }
}

class _PriorityFilterButton extends StatelessWidget {
  const _PriorityFilterButton({
    required this.selectedPriority,
    required this.onSelected,
  });

  final TaskPriority? selectedPriority;
  final ValueChanged<TaskPriority?> onSelected;

  @override
  Widget build(BuildContext context) {
    final selected = selectedPriority != null;
    final colorScheme = Theme.of(context).colorScheme;

    return PopupMenuButton<TaskPriority?>(
      tooltip: 'Фильтр по приоритету',
      onSelected: onSelected,
      itemBuilder: (context) => [
        PopupMenuItem<TaskPriority?>(
          child: Row(
            children: [
              Icon(
                selectedPriority == null
                    ? Icons.check_rounded
                    : Icons.flag_outlined,
                size: 18,
              ),
              SizedBox(width: context.spacing.sm),
              const Text('Любой приоритет'),
            ],
          ),
        ),
        for (final priority in TaskPriority.values)
          PopupMenuItem<TaskPriority?>(
            value: priority,
            child: Row(
              children: [
                Icon(
                  selectedPriority == priority
                      ? Icons.check_rounded
                      : Icons.flag_outlined,
                  size: 18,
                ),
                SizedBox(width: context.spacing.sm),
                Text(_priorityLabel(priority)),
              ],
            ),
          ),
      ],
      child: Chip(
        avatar: Icon(
          Icons.flag_outlined,
          size: 18,
          color: selected ? colorScheme.onSecondaryContainer : null,
        ),
        label: Text(
          selectedPriority == null
              ? 'Приоритет'
              : 'Приоритет: ${_priorityLabel(selectedPriority!)}',
        ),
        backgroundColor: selected ? colorScheme.secondaryContainer : null,
        labelStyle: selected
            ? TextStyle(color: colorScheme.onSecondaryContainer)
            : null,
        side: BorderSide(
          color: selected ? colorScheme.secondary : colorScheme.outlineVariant,
        ),
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}

String _priorityLabel(TaskPriority priority) {
  return switch (priority) {
    TaskPriority.low => 'Низкий',
    TaskPriority.medium => 'Средний',
    TaskPriority.high => 'Высокий',
    TaskPriority.urgent => 'Срочный',
  };
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
    final currentTask = task;
    final currentSubtasks = subtasks;
    final commentCount =
        ref
            .watch(taskCommentsProvider(currentTask.id))
            .maybeWhen(data: (items) => items.length, orElse: () => null) ??
        0;
    final currentTaskType = taskTypes
        .where((type) => type.id == currentTask.taskTypeId)
        .firstOrNull;

    final device = AppBreakpoints.of(context);

    return Container(
      width: device.isPhone ? double.infinity : 760,
      constraints: BoxConstraints(
        maxWidth: device.isPhone ? double.infinity : 860,
        maxHeight: device.isPhone ? 720 : 780,
      ),
      padding: EdgeInsets.all(context.spacing.lg),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        border: Border.all(color: colorScheme.outlineVariant),
        borderRadius: context.radii.sheet,
        boxShadow: context.shadows.popover,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return Wrap(
                spacing: context.spacing.xs,
                runSpacing: context.spacing.xs,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  SizedBox(
                    width: constraints.maxWidth,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Детали задачи',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.titleLarge,
                          ),
                        ),
                        if (onClose != null)
                          IconButton(
                            tooltip: 'Закрыть',
                            onPressed: onClose,
                            icon: const Icon(AppIcons.close),
                          ),
                      ],
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => unawaited(
                      _editTask(context, ref, currentTask),
                    ),
                    icon: const Icon(Icons.edit_outlined),
                    label: const Text('Редактировать'),
                  ),
                  TextButton.icon(
                    onPressed: () =>
                        unawaited(_showHistory(context, currentTask)),
                    icon: const Icon(Icons.history_rounded),
                    label: const Text('История'),
                  ),
                  IconButton(
                    tooltip: 'Редактировать оформление',
                    onPressed: () => unawaited(
                      _editAppearance(context, ref, currentTask),
                    ),
                    icon: const Icon(Icons.palette_outlined),
                  ),
                ],
              );
            },
          ),
          SizedBox(height: context.spacing.md),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(currentTask.title, style: textTheme.headlineSmall),
                  SizedBox(height: context.spacing.sm),
                  _TaskIdRow(task: currentTask),
                  SizedBox(height: context.spacing.md),
                  CheckboxListTile(
                    value: currentTask.isCompleted,
                    onChanged: (_) {
                      unawaited(
                        ref
                            .read(tasksControllerProvider.notifier)
                            .toggleComplete(
                              boardId: currentTask.boardId,
                              taskId: currentTask.id,
                            ),
                      );
                    },
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(
                      currentTask.isCompleted ? 'Завершена' : 'В работе',
                    ),
                  ),
                  SizedBox(height: context.spacing.md),
                  if (currentTask.description?.isNotEmpty ?? false)
                    Text(
                      currentTask.description!,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    )
                  else
                    TextButton.icon(
                      onPressed: () => unawaited(
                        _editTask(context, ref, currentTask),
                      ),
                      icon: const Icon(Icons.notes_outlined),
                      label: const Text('Добавить описание'),
                    ),
                  SizedBox(height: context.spacing.xl),
                  _TaskMetaSummary(
                    task: currentTask,
                    taskType: currentTaskType,
                    commentCount: commentCount,
                  ),
                  SizedBox(height: context.spacing.xl),
                  AssignedUsersSection(taskId: currentTask.id),
                  SizedBox(height: context.spacing.xl),
                  Text('Подзадачи', style: textTheme.titleMedium),
                  SizedBox(height: context.spacing.sm),
                  SubtaskList(
                    subtasks: currentSubtasks,
                    onToggle: (subtask) {
                      // Details panel is presentation-only; task mutation is wired from cards.
                    },
                  ),
                  SizedBox(height: context.spacing.md),
                  SubtaskEditor(parent: currentTask),
                  SizedBox(height: context.spacing.xl),
                  Divider(color: colorScheme.outlineVariant),
                  SizedBox(height: context.spacing.md),
                  Text('Активность', style: textTheme.titleMedium),
                  SizedBox(height: context.spacing.sm),
                  Text(
                    'Обновлено ${currentTask.updatedAt.toLocal()}',
                    style: textTheme.bodySmall,
                  ),
                  SizedBox(height: context.spacing.xl),
                  TaskCommentsSection(taskId: currentTask.id),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _editTask(
    BuildContext context,
    WidgetRef ref,
    TaskEntity currentTask,
  ) async {
    final updated = await showDialog<TaskEntity>(
      context: context,
      builder: (context) => _TaskEditDialog(
        task: currentTask,
        taskTypes: taskTypes,
      ),
    );
    if (updated == null) return;
    unawaited(ref.read(tasksControllerProvider.notifier).updateTask(updated));
  }

  Future<void> _editAppearance(
    BuildContext context,
    WidgetRef ref,
    TaskEntity currentTask,
  ) async {
    final updated = await showDialog<TaskEntity>(
      context: context,
      builder: (context) => _TaskAppearanceDialog(task: currentTask),
    );
    if (updated == null) return;
    unawaited(ref.read(tasksControllerProvider.notifier).updateTask(updated));
  }

  Future<void> _showHistory(
    BuildContext context,
    TaskEntity currentTask,
  ) async {
    final content = _TaskHistoryPanel(task: currentTask);
    if (AppBreakpoints.of(context).isPhone) {
      await showModalBottomSheet<void>(
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (context) => Padding(
          padding: EdgeInsets.fromLTRB(
            context.spacing.lg,
            0,
            context.spacing.lg,
            context.spacing.xl,
          ),
          child: content,
        ),
      );
      return;
    }

    await showDialog<void>(
      context: context,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.all(context.spacing.xl),
        child: content,
      ),
    );
  }
}

class _TaskHistoryPanel extends ConsumerWidget {
  const _TaskHistoryPanel({required this.task});

  final TaskEntity task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final historyState = ref.watch(taskHistoryProvider(task.id));

    return Container(
      width: AppBreakpoints.of(context).isPhone ? double.infinity : 520,
      constraints: const BoxConstraints(maxHeight: 620),
      padding: EdgeInsets.all(context.spacing.lg),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        border: Border.all(color: colorScheme.outlineVariant),
        borderRadius: context.radii.sheet,
        boxShadow: context.shadows.popover,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'История задачи',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              IconButton(
                tooltip: 'Закрыть',
                onPressed: () => Navigator.of(context).maybePop(),
                icon: const Icon(AppIcons.close),
              ),
            ],
          ),
          SizedBox(height: context.spacing.xs),
          Text(
            '${task.shortDisplayId} · ${task.title}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: context.spacing.lg),
          Expanded(
            child: historyState.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) =>
                  Center(child: Text(error.toString())),
              data: (entries) {
                final visibleEntries = entries.isEmpty
                    ? [
                        _SyntheticTaskHistoryEntry(
                          action: 'create',
                          summary: 'Задача создана',
                          changedAt: task.createdAt,
                          actorUserId: null,
                          changes: const [],
                        ),
                        if (task.updatedAt != task.createdAt)
                          _SyntheticTaskHistoryEntry(
                            action: 'update',
                            summary: 'Задача обновлена',
                            changedAt: task.updatedAt,
                            actorUserId: null,
                            changes: const [],
                          ),
                      ]
                    : entries
                          .map(
                            (entry) => _SyntheticTaskHistoryEntry(
                              action: entry.action,
                              summary: entry.summary,
                              changedAt: entry.changedAt,
                              actorUserId: entry.actorUserId,
                              changes: _decodeHistoryChanges(
                                entry.detailsJson,
                              ),
                            ),
                          )
                          .toList(growable: false);

                return ListView.separated(
                  itemCount: visibleEntries.length,
                  separatorBuilder: (context, index) =>
                      SizedBox(height: context.spacing.sm),
                  itemBuilder: (context, index) {
                    final entry = visibleEntries[index];
                    return _TaskHistoryItem(entry: entry);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

final class _SyntheticTaskHistoryEntry {
  const _SyntheticTaskHistoryEntry({
    required this.action,
    required this.summary,
    required this.changedAt,
    required this.actorUserId,
    required this.changes,
  });

  final String action;
  final String summary;
  final DateTime changedAt;
  final String? actorUserId;
  final List<_TaskHistoryChange> changes;
}

final class _TaskHistoryChange {
  const _TaskHistoryChange({
    required this.label,
    this.from,
    this.to,
  });

  final String label;
  final Object? from;
  final Object? to;
}

class _TaskHistoryItem extends StatelessWidget {
  const _TaskHistoryItem({required this.entry});

  final _SyntheticTaskHistoryEntry entry;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: colorScheme.primaryContainer,
          child: Icon(
            _historyIcon(entry.action),
            size: 17,
            color: colorScheme.onPrimaryContainer,
          ),
        ),
        SizedBox(width: context.spacing.md),
        Expanded(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHigh,
              border: Border.all(color: colorScheme.outlineVariant),
              borderRadius: BorderRadius.circular(context.radii.sm),
            ),
            child: Padding(
              padding: EdgeInsets.all(context.spacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.summary,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: context.spacing.xs),
                  Text(
                    _formatHistoryDate(entry.changedAt),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: context.spacing.xs),
                  _TaskHistoryActor(userId: entry.actorUserId),
                  if (entry.changes.isNotEmpty) ...[
                    SizedBox(height: context.spacing.sm),
                    for (final change in entry.changes)
                      Padding(
                        padding: EdgeInsets.only(bottom: context.spacing.xs),
                        child: Text(
                          _formatHistoryChange(change),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TaskHistoryActor extends ConsumerWidget {
  const _TaskHistoryActor({required this.userId});

  final String? userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = userId;
    if (id == null || id.isEmpty) {
      return Text(
        'Автор: не указан',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      );
    }

    final user = ref
        .watch(userByIdProvider(id))
        .maybeWhen(data: (value) => value, orElse: () => null);
    final label = user?.fullName ?? id;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 10,
          backgroundImage: user?.avatarUrl == null || user!.avatarUrl!.isEmpty
              ? null
              : NetworkImage(user.avatarUrl!),
          child: user?.avatarUrl == null || user!.avatarUrl!.isEmpty
              ? Text(
                  label.characters.first.toUpperCase(),
                  style: const TextStyle(fontSize: 10),
                )
              : null,
        ),
        SizedBox(width: context.spacing.xs),
        Flexible(
          child: Text(
            'Автор: $label',
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}

IconData _historyIcon(String action) {
  return switch (action) {
    'create' => Icons.add_task_rounded,
    'delete' => Icons.delete_outline_rounded,
    _ => Icons.edit_note_rounded,
  };
}

List<_TaskHistoryChange> _decodeHistoryChanges(String? raw) {
  if (raw == null || raw.isEmpty) return const [];
  try {
    final decoded = jsonDecode(raw);
    if (decoded is! List) return const [];
    return [
      for (final item in decoded)
        if (item is Map)
          _TaskHistoryChange(
            label: item['label']?.toString() ?? 'изменение',
            from: item['from'],
            to: item['to'],
          ),
    ];
  } on FormatException {
    return const [];
  }
}

String _formatHistoryChange(_TaskHistoryChange change) {
  final from = _formatHistoryValue(change.from);
  final to = _formatHistoryValue(change.to);
  if (from == null && to == null) return change.label;
  if (from == null) return '${change.label}: $to';
  if (to == null) return '${change.label}: было $from';
  return '${change.label}: $from -> $to';
}

String? _formatHistoryValue(Object? value) {
  if (value == null) return null;
  if (value is List) return value.join(', ');
  if (value is bool) return value ? 'да' : 'нет';
  final text = value.toString();
  if (text.isEmpty) return null;
  return text;
}

class _TaskMetaSummary extends ConsumerWidget {
  const _TaskMetaSummary({
    required this.task,
    required this.taskType,
    required this.commentCount,
  });

  final TaskEntity task;
  final TaskTypeEntity? taskType;
  final int commentCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assignees = ref
        .watch(taskAssigneesProvider(task.id))
        .maybeWhen(
          data: (items) => items,
          orElse: () => const <TaskAssigneeEntity>[],
        );

    return Wrap(
      spacing: context.spacing.sm,
      runSpacing: context.spacing.sm,
      children: [
        _MetaChip(
          icon: Icons.category_outlined,
          label: taskType?.name ?? 'Без типа',
        ),
        _MetaChip(
          icon: Icons.flag_outlined,
          label: _priorityLabel(task.priority),
        ),
        _MetaChip(
          icon: Icons.event_available_outlined,
          label: task.startDate == null
              ? 'Не поставлена'
              : 'Поставлена ${_formatShortDate(task.startDate!)}',
        ),
        _MetaChip(
          icon: Icons.event_busy_outlined,
          label: task.dueDate == null
              ? 'Без дедлайна'
              : 'Дедлайн ${_formatShortDate(task.dueDate!)}',
        ),
        _MetaChip(
          icon: Icons.comment_outlined,
          label: '$commentCount комментариев',
        ),
        if (assignees.isEmpty)
          const _MetaChip(
            icon: Icons.people_outline_rounded,
            label: 'Без исполнителей',
          )
        else
          for (final assignee in assignees.take(3))
            _AssigneeSummaryChip(userId: assignee.userId),
        if (assignees.length > 3)
          _MetaChip(
            icon: Icons.people_outline_rounded,
            label: '+${assignees.length - 3}',
          ),
      ],
    );
  }
}

class _TaskIdRow extends StatelessWidget {
  const _TaskIdRow({required this.task});

  final TaskEntity task;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHigh,
        border: Border.all(color: colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(context.radii.sm),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.spacing.sm,
          vertical: context.spacing.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.tag_rounded,
              size: 16,
              color: colorScheme.onSurfaceVariant,
            ),
            SizedBox(width: context.spacing.xs),
            Tooltip(
              message: task.id,
              child: Text(
                task.shortDisplayId,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            SizedBox(width: context.spacing.xs),
            IconButton(
              tooltip: 'Скопировать полный ID',
              visualDensity: VisualDensity.compact,
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: task.id));
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('ID задачи скопирован')),
                );
              },
              icon: const Icon(Icons.copy_rounded, size: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 16),
      label: Text(label),
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}

class _AssigneeSummaryChip extends ConsumerWidget {
  const _AssigneeSummaryChip({required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref
        .watch(userByIdProvider(userId))
        .maybeWhen(
          data: (value) => value,
          orElse: () => null,
        );
    final label = user?.fullName ?? userId;

    return Chip(
      avatar: CircleAvatar(
        backgroundImage: user?.avatarUrl == null || user!.avatarUrl!.isEmpty
            ? null
            : NetworkImage(user.avatarUrl!),
        child: user?.avatarUrl == null || user!.avatarUrl!.isEmpty
            ? Text(label.characters.first.toUpperCase())
            : null,
      ),
      label: Text(label),
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}

class _TaskEditDialog extends StatefulWidget {
  const _TaskEditDialog({
    required this.task,
    required this.taskTypes,
  });

  final TaskEntity task;
  final List<TaskTypeEntity> taskTypes;

  @override
  State<_TaskEditDialog> createState() => _TaskEditDialogState();
}

class _TaskEditDialogState extends State<_TaskEditDialog> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late TaskPriority _priority;
  String? _taskTypeId;
  String? _titleError;
  String? _dateError;
  DateTime? _startDate;
  DateTime? _dueDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController = TextEditingController(
      text: widget.task.description ?? '',
    );
    _priority = widget.task.priority;
    _startDate = widget.task.startDate;
    _dueDate = widget.task.dueDate;
    _taskTypeId =
        widget.taskTypes.any(
          (type) => type.id == widget.task.taskTypeId,
        )
        ? widget.task.taskTypeId
        : null;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Редактировать задачу'),
      content: SizedBox(
        width: 520,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                autofocus: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Название',
                  prefixIcon: const Icon(Icons.task_alt_outlined),
                  errorText: _titleError,
                ),
                onChanged: (_) {
                  if (_titleError != null) {
                    setState(() => _titleError = null);
                  }
                },
              ),
              SizedBox(height: context.spacing.md),
              TextField(
                controller: _descriptionController,
                minLines: 3,
                maxLines: 6,
                decoration: const InputDecoration(
                  labelText: 'Описание',
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.notes_outlined),
                ),
              ),
              SizedBox(height: context.spacing.md),
              DropdownButtonFormField<TaskPriority>(
                initialValue: _priority,
                items: [
                  for (final priority in TaskPriority.values)
                    DropdownMenuItem<TaskPriority>(
                      value: priority,
                      child: Text(_priorityLabel(priority)),
                    ),
                ],
                onChanged: (value) {
                  if (value == null) return;
                  setState(() => _priority = value);
                },
                decoration: const InputDecoration(
                  labelText: 'Приоритет',
                  prefixIcon: Icon(Icons.flag_outlined),
                ),
              ),
              SizedBox(height: context.spacing.md),
              DropdownButtonFormField<String?>(
                initialValue: _taskTypeId,
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
                onChanged: (value) => setState(() => _taskTypeId = value),
                decoration: const InputDecoration(
                  labelText: 'Тип задачи',
                  prefixIcon: Icon(Icons.category_outlined),
                ),
              ),
              SizedBox(height: context.spacing.md),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Даты',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              SizedBox(height: context.spacing.sm),
              Wrap(
                spacing: context.spacing.sm,
                runSpacing: context.spacing.sm,
                children: [
                  OutlinedButton.icon(
                    onPressed: () => _pickDate(isStartDate: true),
                    icon: const Icon(Icons.event_available_outlined),
                    label: Text(
                      _startDate == null
                          ? 'Дата постановки'
                          : 'Поставлена: ${_formatShortDate(_startDate!)}',
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => _pickDate(isStartDate: false),
                    icon: const Icon(Icons.event_busy_outlined),
                    label: Text(
                      _dueDate == null
                          ? 'Дедлайн'
                          : 'Дедлайн: ${_formatShortDate(_dueDate!)}',
                    ),
                  ),
                  if (_startDate != null || _dueDate != null)
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          _startDate = null;
                          _dueDate = null;
                          _dateError = null;
                        });
                      },
                      icon: const Icon(Icons.clear_rounded),
                      label: const Text('Очистить'),
                    ),
                ],
              ),
              if (_dateError != null) ...[
                SizedBox(height: context.spacing.xs),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _dateError!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ],
              SizedBox(height: context.spacing.md),
              Divider(color: Theme.of(context).colorScheme.outlineVariant),
              SizedBox(height: context.spacing.sm),
              AssignedUsersSection(taskId: widget.task.id),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Отмена'),
        ),
        FilledButton(
          onPressed: _submit,
          child: const Text('Сохранить'),
        ),
      ],
    );
  }

  Future<void> _pickDate({required bool isStartDate}) async {
    final now = DateTime.now();
    final initialDate = isStartDate
        ? _startDate ?? _dueDate ?? now
        : _dueDate ?? _startDate ?? now;
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 10),
      helpText: isStartDate ? 'Дата постановки задачи' : 'Дедлайн',
    );
    if (picked == null) return;
    if (!mounted) return;

    setState(() {
      if (isStartDate) {
        _startDate = picked;
      } else {
        _dueDate = picked;
      }
      _dateError = null;
    });
  }

  void _submit() {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      setState(() => _titleError = 'Введите название задачи');
      return;
    }
    if (_startDate != null &&
        _dueDate != null &&
        _dateOnly(_dueDate!).isBefore(_dateOnly(_startDate!))) {
      setState(() {
        _dateError = 'Дедлайн не может быть раньше даты постановки';
      });
      return;
    }

    final description = _descriptionController.text.trim();
    Navigator.of(context).pop(
      widget.task.copyWith(
        title: title,
        description: description.isEmpty ? null : description,
        priority: _priority,
        taskTypeId: _taskTypeId,
        startDate: _startDate == null ? null : _dateOnly(_startDate!),
        dueDate: _dueDate == null ? null : _dateOnly(_dueDate!),
      ),
    );
  }
}

DateTime _dateOnly(DateTime value) {
  final local = value.toLocal();
  return DateTime(local.year, local.month, local.day);
}

String _formatShortDate(DateTime value) {
  final date = _dateOnly(value);
  return '${date.day}.${date.month.toString().padLeft(2, '0')}.${date.year}';
}

String _formatHistoryDate(DateTime value) {
  final local = value.toLocal();
  final day = local.day.toString().padLeft(2, '0');
  final month = local.month.toString().padLeft(2, '0');
  final hour = local.hour.toString().padLeft(2, '0');
  final minute = local.minute.toString().padLeft(2, '0');
  return '$day.$month.${local.year} $hour:$minute';
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
