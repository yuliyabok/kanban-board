import 'package:flutter/material.dart';

import '../../../../app/theme/app_design_tokens.dart';
import '../../../../shared/ui/premium_card.dart';
import '../../domain/entities/board_entity.dart';

class BoardCard extends StatelessWidget {
  const BoardCard({
    super.key,
    required this.board,
    required this.onTap,
  });

  final BoardEntity board;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return PremiumCard(
      onTap: onTap,
      padding: EdgeInsets.all(context.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(context.radii.md),
                ),
                child: Icon(
                  Icons.view_kanban_outlined,
                  size: 18,
                  color: colorScheme.primary,
                ),
              ),
              SizedBox(width: context.spacing.md),
              Expanded(
                child: Text(
                  board.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleMedium,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
          SizedBox(height: context.spacing.lg),
          Expanded(
            child: Text(
              board.description?.isNotEmpty ?? false
                  ? board.description!
                  : 'Рабочее пространство для задач, статусов и командной синхронизации.',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          SizedBox(height: context.spacing.lg),
          Row(
            children: [
              _StatusDot(
                color: board.isSynced
                    ? colorScheme.tertiary
                    : colorScheme.error,
              ),
              SizedBox(width: context.spacing.sm),
              Text(
                board.isSynced ? 'Синхронизировано' : 'Ожидает синхронизации',
                style: textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusDot extends StatelessWidget {
  const _StatusDot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: const SizedBox.square(dimension: 7),
    );
  }
}
