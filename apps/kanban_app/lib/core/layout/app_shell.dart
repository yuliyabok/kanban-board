import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../src/app/routing/app_routes.dart';
import '../../src/core/providers/core_providers.dart';
import '../../src/features/boards/domain/entities/board_entity.dart';
import '../../src/features/boards/presentation/providers/board_providers.dart';
import '../theme/app_breakpoints.dart';
import '../theme/app_icons.dart';
import '../theme/app_theme.dart';
import '../theme/theme_controller.dart';
import '../widgets/app_icon_button.dart';
import '../widgets/app_text_field.dart';

class AppShellAction {
  const AppShellAction({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.isPrimary = false,
    this.selected = false,
    this.pinOnMobile = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final bool selected;
  final bool pinOnMobile;
}

class AppShell extends ConsumerWidget {
  const AppShell({
    required this.title,
    required this.content,
    this.subtitle,
    this.boardName,
    this.searchController,
    this.onSearchChanged,
    this.actions = const [],
    this.bottomNavigationBar,
    super.key,
  });

  final String title;
  final String? subtitle;
  final String? boardName;
  final TextEditingController? searchController;
  final ValueChanged<String>? onSearchChanged;
  final List<AppShellAction> actions;
  final Widget? bottomNavigationBar;
  final Widget content;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final device = AppBreakpoints.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final shellContent = Column(
      children: [
        _ShellToolbar(
          title: title,
          subtitle: subtitle,
          boardName: boardName,
          searchController: searchController,
          onSearchChanged: onSearchChanged,
          actions: actions,
          showSearch: !device.isPhone,
        ),
        Expanded(child: content),
      ],
    );

    if (device.isPhone) {
      final pinnedActions = actions
          .where((action) => action.pinOnMobile)
          .toList(growable: false);
      final menuActions = actions
          .where((action) => !action.pinOnMobile)
          .toList(growable: false);

      AppShellAction? primaryAction;
      for (final action in actions) {
        if (action.isPrimary) {
          primaryAction = action;
          break;
        }
      }

      return Scaffold(
        appBar: AppBar(
          title: Text(title),
          toolbarHeight: 48,
          elevation: 0,
          actions: [
            for (final action in pinnedActions)
              AppIconButton(
                icon: action.icon,
                tooltip: action.label,
                selected: action.selected,
                onPressed: action.onPressed,
              ),
            if (menuActions.isNotEmpty)
              PopupMenuButton<AppShellAction>(
                tooltip: 'Действия',
                icon: const Icon(Icons.more_vert_rounded),
                onSelected: (action) => action.onPressed?.call(),
                itemBuilder: (context) => [
                  for (final action in menuActions)
                    PopupMenuItem(
                      value: action,
                      enabled: action.onPressed != null,
                      child: Row(
                        children: [
                          Icon(action.icon, size: 18),
                          SizedBox(width: context.spacing.sm),
                          Text(action.label),
                        ],
                      ),
                    ),
                ],
              ),
            AppIconButton(
              icon: AppIcons.search,
              tooltip: 'Поиск',
              onPressed: () => _showMobileSearch(context),
            ),
            AppIconButton(
              icon: Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
              tooltip: 'Сменить тему',
              onPressed: () =>
                  ref.read(themeControllerProvider.notifier).toggleLightDark(),
            ),
            const SizedBox(width: 8),
          ],
        ),
        drawer: Drawer(child: _ShellSidebar(compact: false, title: title)),
        body: Column(
          children: [
            // Hide the toolbar on mobile to maximize space for board
            Expanded(child: content),
          ],
        ),
        floatingActionButton:
            primaryAction != null && primaryAction.onPressed != null
            ? FloatingActionButton(
                onPressed: primaryAction.onPressed,
                tooltip: primaryAction.label,
                child: Icon(primaryAction.icon),
              )
            : null,
        bottomNavigationBar: bottomNavigationBar ?? const _MobileNavBar(),
      );
    }

    final compactSidebar = device == AppDeviceClass.tablet;

    return Scaffold(
      body: Row(
        children: [
          AnimatedContainer(
            duration: context.motion.page,
            curve: context.motion.emphasized,
            width: compactSidebar ? 84 : 268,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerLowest,
              border: Border(
                right: BorderSide(color: colorScheme.outlineVariant),
              ),
            ),
            child: _ShellSidebar(compact: compactSidebar, title: title),
          ),
          Expanded(child: shellContent),
        ],
      ),
    );
  }

  Future<void> _showMobileSearch(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            context.spacing.lg,
            0,
            context.spacing.lg,
            context.spacing.xl,
          ),
          child: AppTextField(
            controller: searchController,
            prefixIcon: AppIcons.search,
            hintText: 'Поиск по задачам',
            autofocus: true,
            onChanged: onSearchChanged,
          ),
        );
      },
    );
  }
}

class _ShellToolbar extends ConsumerWidget {
  const _ShellToolbar({
    required this.title,
    required this.actions,
    required this.showSearch,
    this.subtitle,
    this.boardName,
    this.searchController,
    this.onSearchChanged,
  });

  final String title;
  final String? subtitle;
  final String? boardName;
  final TextEditingController? searchController;
  final ValueChanged<String>? onSearchChanged;
  final List<AppShellAction> actions;
  final bool showSearch;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    if (!showSearch) {
      return const SizedBox.shrink();
    }

    return Container(
      height: 72,
      padding: EdgeInsets.symmetric(horizontal: context.spacing.xl),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(bottom: BorderSide(color: colorScheme.outlineVariant)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 980;
          return Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      boardName ?? title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleLarge,
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodySmall,
                      ),
                  ],
                ),
              ),
              SizedBox(width: context.spacing.md),
              Flexible(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  child: Row(
                    children: [
                      if (showSearch && !compact) ...[
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 320),
                          child: AppTextField(
                            controller: searchController,
                            prefixIcon: AppIcons.search,
                            hintText: 'Поиск задач',
                            onChanged: onSearchChanged,
                          ),
                        ),
                        SizedBox(width: context.spacing.md),
                      ],
                      for (final action in actions) ...[
                        if (action.isPrimary && !compact)
                          FilledButton.icon(
                            onPressed: action.onPressed,
                            icon: Icon(action.icon),
                            label: Text(action.label),
                          )
                        else
                          AppIconButton(
                            icon: action.icon,
                            tooltip: action.label,
                            selected: action.selected,
                            onPressed: action.onPressed,
                          ),
                        SizedBox(width: context.spacing.sm),
                      ],
                      AppIconButton(
                        icon: Theme.of(context).brightness == Brightness.dark
                            ? Icons.light_mode_outlined
                            : Icons.dark_mode_outlined,
                        tooltip: 'Сменить тему',
                        onPressed: () => ref
                            .read(themeControllerProvider.notifier)
                            .toggleLightDark(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ShellSidebar extends ConsumerWidget {
  const _ShellSidebar({
    required this.compact,
    required this.title,
  });

  final bool compact;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(context.spacing.md),
        child: Column(
          crossAxisAlignment: compact
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            _WorkspaceSelector(compact: compact),
            SizedBox(height: context.spacing.xl),
            _SidebarItem(
              icon: AppIcons.boards,
              label: 'Доски',
              compact: compact,
              selected: title == 'Доски',
              onTap: () => context.go(AppRoute.boards.path),
            ),
            _SidebarItem(
              icon: AppIcons.board,
              label: 'Канбан',
              compact: compact,
              selected: title == 'Канбан',
              onTap: () => unawaited(_openLastBoard(context, ref)),
            ),
            _SidebarItem(
              icon: AppIcons.whatsNew,
              label: 'Что нового',
              compact: compact,
              selected: title == 'Что нового',
              onTap: () => context.go(AppRoute.whatsNew.path),
            ),
            _SidebarItem(
              icon: AppIcons.calendar,
              label: 'Календарь',
              compact: compact,
              selected: title == 'Календарь',
              onTap: () => context.go(AppRoute.calendar.path),
            ),
            _SidebarItem(
              icon: AppIcons.gantt,
              label: 'Гант',
              compact: compact,
              selected: title == 'Гант',
              onTap: () => context.go(AppRoute.gantt.path),
            ),
            _SidebarItem(
              icon: AppIcons.activity,
              label: 'Активность',
              compact: compact,
            ),
            const Spacer(),
            _SidebarItem(
              icon: AppIcons.settings,
              label: 'Настройки',
              compact: compact,
              selected: title == 'Настройки',
              onTap: () {
                if (GoRouterState.of(context).uri.path !=
                    AppRoute.settings.path) {
                  context.push(AppRoute.settings.path);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _WorkspaceSelector extends StatelessWidget {
  const _WorkspaceSelector({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 44,
      padding: EdgeInsets.symmetric(horizontal: context.spacing.sm),
      decoration: BoxDecoration(
        borderRadius: context.radii.control,
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Row(
        mainAxisAlignment: compact
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: colorScheme.primaryContainer,
            child: Text(
              'K',
              style: TextStyle(color: colorScheme.primary, fontSize: 12),
            ),
          ),
          if (!compact) ...[
            SizedBox(width: context.spacing.sm),
            Expanded(
              child: Text(
                'Kanban Workspace',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            const Icon(Icons.expand_more_rounded, size: 18),
          ],
        ],
      ),
    );
  }
}

class _SidebarItem extends StatefulWidget {
  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.compact,
    this.selected = false,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool compact;
  final bool selected;
  final VoidCallback? onTap;

  @override
  State<_SidebarItem> createState() => _SidebarItemState();
}

class _SidebarItemState extends State<_SidebarItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final active = widget.selected || _hovered;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: context.radii.control,
        child: AnimatedContainer(
          duration: context.motion.hover,
          height: 40,
          margin: EdgeInsets.only(bottom: context.spacing.xs),
          padding: EdgeInsets.symmetric(horizontal: context.spacing.sm),
          decoration: BoxDecoration(
            color: widget.selected
                ? colorScheme.primaryContainer.withValues(alpha: 0.55)
                : active
                ? colorScheme.surfaceContainer
                : Colors.transparent,
            borderRadius: context.radii.control,
          ),
          child: Row(
            mainAxisAlignment: widget.compact
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              Icon(
                widget.icon,
                size: 20,
                color: widget.selected
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
              ),
              if (!widget.compact) ...[
                SizedBox(width: context.spacing.md),
                Expanded(
                  child: Text(
                    widget.label,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: widget.selected
                          ? colorScheme.primary
                          : colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileNavBar extends ConsumerWidget {
  const _MobileNavBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).uri.path;
    final selectedIndex = location == AppRoute.settings.path
        ? 5
        : location == AppRoute.gantt.path
        ? 3
        : location == AppRoute.whatsNew.path
        ? 1
        : location == AppRoute.calendar.path
        ? 2
        : location.startsWith('/boards/')
        ? 4
        : 0;
    return NavigationBar(
      selectedIndex: selectedIndex,
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      onDestinationSelected: (index) {
        if (index == 0) {
          context.go(AppRoute.boards.path);
        }
        if (index == 1) {
          context.go(AppRoute.whatsNew.path);
        }
        if (index == 2) {
          context.go(AppRoute.calendar.path);
        }
        if (index == 3) {
          context.go(AppRoute.gantt.path);
        }
        if (index == 4) {
          unawaited(_openLastBoard(context, ref));
        }
        if (index == 5) {
          if (location != AppRoute.settings.path) {
            context.push(AppRoute.settings.path);
          }
        }
      },
      destinations: const [
        NavigationDestination(icon: Icon(AppIcons.boards), label: 'Доски'),
        NavigationDestination(icon: Icon(AppIcons.whatsNew), label: 'Новое'),
        NavigationDestination(
          icon: Icon(AppIcons.calendar),
          label: 'Кал.',
        ),
        NavigationDestination(icon: Icon(AppIcons.gantt), label: 'Гант'),
        NavigationDestination(icon: Icon(AppIcons.board), label: 'Канбан'),
        NavigationDestination(icon: Icon(AppIcons.settings), label: 'Еще'),
      ],
    );
  }
}

Future<void> _openLastBoard(BuildContext context, WidgetRef ref) async {
  final cachedBoards = ref.read(watchBoardsProvider).asData?.value;
  final loadedBoards = cachedBoards == null
      ? await ref.read(watchBoardsProvider.future)
      : null;
  final List<BoardEntity> boards =
      cachedBoards ?? loadedBoards ?? const <BoardEntity>[];
  final lastBoardId = await ref
      .read(secureStorageProvider)
      .read(
        'last_board_id',
      );
  if (!context.mounted) return;

  final fallbackBoardId = boards.isEmpty ? null : boards.first.id;
  final boardId = boards.any((board) => board.id == lastBoardId)
      ? lastBoardId
      : fallbackBoardId;

  if (boardId == null) {
    context.go(AppRoute.boards.path);
    return;
  }

  context.goNamed(
    AppRoute.boardTasks.name,
    pathParameters: {'boardId': boardId},
  );
}
