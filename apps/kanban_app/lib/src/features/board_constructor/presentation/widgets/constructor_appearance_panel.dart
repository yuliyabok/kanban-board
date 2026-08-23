import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/app_board_background_palette.dart';
import '../../../../app/theme/app_design_tokens.dart';
import '../../../board_settings/domain/entities/board_card_settings.dart';
import '../../../board_settings/presentation/controllers/board_card_settings_controller.dart';

class ConstructorAppearancePanel extends ConsumerWidget {
  const ConstructorAppearancePanel({
    required this.settings,
    super.key,
  });

  final BoardCardSettings settings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.all(context.spacing.md),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        border: Border.all(color: colorScheme.outlineVariant),
        borderRadius: context.radii.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Фоны', style: textTheme.titleMedium),
          SizedBox(height: context.spacing.md),
          Text('Карточки задач', style: textTheme.labelLarge),
          SizedBox(height: context.spacing.sm),
          _BackgroundPicker(
            selectedId: settings.cardBackgroundColor,
            mode: _BackgroundPickerMode.card,
            onSelected: (value) {
              _save(ref, settings.copyWith(cardBackgroundColor: value));
            },
          ),
          SizedBox(height: context.spacing.lg),
          Text('Столбцы', style: textTheme.labelLarge),
          SizedBox(height: context.spacing.sm),
          _BackgroundPicker(
            selectedId: settings.columnBackgroundColor,
            mode: _BackgroundPickerMode.column,
            onSelected: (value) {
              _save(ref, settings.copyWith(columnBackgroundColor: value));
            },
          ),
        ],
      ),
    );
  }

  void _save(WidgetRef ref, BoardCardSettings value) {
    unawaited(
      ref
          .read(boardCardSettingsControllerProvider.notifier)
          .saveSettings(value),
    );
  }
}

enum _BackgroundPickerMode { card, column }

class _BackgroundPicker extends StatelessWidget {
  const _BackgroundPicker({
    required this.selectedId,
    required this.mode,
    required this.onSelected,
  });

  final String selectedId;
  final _BackgroundPickerMode mode;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: context.spacing.sm,
      runSpacing: context.spacing.sm,
      children: [
        for (final color in AppBoardBackgroundPalette.colors)
          Tooltip(
            message: color.label,
            child: InkWell(
              onTap: () => onSelected(color.id),
              borderRadius: BorderRadius.circular(context.radii.sm),
              child: Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: mode == _BackgroundPickerMode.card
                      ? color.resolveCard(Theme.of(context).brightness)
                      : color.resolveColumn(Theme.of(context).brightness),
                  borderRadius: BorderRadius.circular(context.radii.sm),
                  border: Border.all(
                    color: selectedId == color.id
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.outlineVariant,
                    width: selectedId == color.id ? 2 : 1,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
