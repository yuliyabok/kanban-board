import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routing/app_routes.dart';
import '../../../../app/theme/app_design_tokens.dart';
import '../../../../shared/ui/app_adaptive.dart';
import '../../../../shared/ui/app_empty_state.dart';
import '../../../../shared/ui/loading_skeleton.dart';
import '../controllers/boards_controller.dart';
import '../providers/board_providers.dart';
import '../widgets/board_card.dart';

class BoardsPage extends ConsumerWidget {
  const BoardsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final boardsState = ref.watch(watchBoardsProvider);
    final commandState = ref.watch(boardsControllerProvider);

    ref.listen(boardsControllerProvider, (previous, next) {
      if (next case AsyncError(:final error)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.toString())),
        );
      }
    });

    final padding = AppAdaptive.pagePadding(context);

    return Scaffold(
      body: boardsState.when(
        loading: () => const _BoardsSkeleton(),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        data: (boards) {
          if (boards.isEmpty) {
            return AppEmptyState(
              icon: Icons.space_dashboard_outlined,
              title: 'Создайте первую доску',
              message:
                  'Начните с легкой структуры: Backlog, In progress, Review и Done. Позже ее можно расширить под командный процесс.',
              action: FilledButton.icon(
                onPressed: () => _showCreateBoardDialog(context, ref),
                icon: const Icon(Icons.add_rounded),
                label: const Text('Новая доска'),
              ),
            );
          }

          return SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: AppAdaptive.contentMaxWidth(context),
                ),
                child: CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(
                        padding,
                        padding,
                        padding,
                        context.spacing.lg,
                      ),
                      sliver: SliverToBoxAdapter(
                        child: _BoardsHeader(
                          isLoading: commandState.isLoading,
                          onCreate: () => _showCreateBoardDialog(context, ref),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(
                        padding,
                        0,
                        padding,
                        padding,
                      ),
                      sliver: SliverGrid.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: AppAdaptive.boardGridColumns(context),
                          childAspectRatio: AppAdaptive.of(context).isPhone
                              ? 1.72
                              : 1.32,
                          crossAxisSpacing: context.spacing.lg,
                          mainAxisSpacing: context.spacing.lg,
                        ),
                        itemCount: boards.length,
                        itemBuilder: (context, index) {
                          final board = boards[index];
                          return BoardCard(
                            board: board,
                            onTap: () {
                              context.goNamed(
                                AppRoute.boardTasks.name,
                                pathParameters: {'boardId': board.id},
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateBoardDialog(context, ref);
        },
        child: const Icon(Icons.add_rounded),
      ),
    );
  }

  Future<void> _showCreateBoardDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    final shouldCreate = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Создать доску'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Название доски',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                hintText: 'Описание',
              ),
              minLines: 2,
              maxLines: 4,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Отмена'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Создать'),
          ),
        ],
      ),
    );

    if (shouldCreate ?? false) {
      await ref
          .read(boardsControllerProvider.notifier)
          .create(
            title: titleController.text,
            description: descriptionController.text,
          );
    }

    titleController.dispose();
    descriptionController.dispose();
  }
}

class _BoardsHeader extends StatelessWidget {
  const _BoardsHeader({
    required this.isLoading,
    required this.onCreate,
  });

  final bool isLoading;
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Доски', style: textTheme.headlineMedium),
              SizedBox(height: context.spacing.xs),
              Text(
                'Все рабочие пространства, быстрый доступ и offline-first синхронизация.',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        if (isLoading) ...[
          const SizedBox.square(
            dimension: 18,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          SizedBox(width: context.spacing.md),
        ],
        FilledButton.icon(
          onPressed: onCreate,
          icon: const Icon(Icons.add_rounded),
          label: const Text('Новая доска'),
        ),
      ],
    );
  }
}

class _BoardsSkeleton extends StatelessWidget {
  const _BoardsSkeleton();

  @override
  Widget build(BuildContext context) {
    final padding = AppAdaptive.pagePadding(context);

    return SafeArea(
      child: LoadingSkeleton(
        child: GridView.builder(
          padding: EdgeInsets.all(padding),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: AppAdaptive.boardGridColumns(context),
            childAspectRatio: 1.32,
            crossAxisSpacing: context.spacing.lg,
            mainAxisSpacing: context.spacing.lg,
          ),
          itemCount: 8,
          itemBuilder: (context, index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: context.radii.card,
              ),
              child: Padding(
                padding: EdgeInsets.all(context.spacing.lg),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonBlock(width: 160, height: 18),
                    SizedBox(height: 18),
                    SkeletonBlock(width: double.infinity),
                    SizedBox(height: 10),
                    SkeletonBlock(width: 220),
                    Spacer(),
                    SkeletonBlock(width: 120, height: 12),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
