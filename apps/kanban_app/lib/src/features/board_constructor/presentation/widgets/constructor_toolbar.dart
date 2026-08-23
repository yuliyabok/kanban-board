import 'package:flutter/material.dart';

import '../../../../app/theme/app_design_tokens.dart';
import '../controllers/board_constructor_state.dart';

class ConstructorToolbar extends StatelessWidget {
  const ConstructorToolbar({
    required this.state,
    required this.onEnter,
    required this.onDone,
    required this.onSave,
    required this.onCancel,
    required this.onAddColumn,
    super.key,
  });

  final BoardConstructorState state;
  final VoidCallback onEnter;
  final VoidCallback onDone;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final VoidCallback onAddColumn;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    if (!state.isConstructorMode) {
      return OutlinedButton.icon(
        onPressed: onEnter,
        icon: const Icon(Icons.tune_rounded),
        label: const Text('Режим конструктора'),
      );
    }

    return Container(
      padding: EdgeInsets.all(context.spacing.sm),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withValues(alpha: 0.45),
        border: Border.all(color: colorScheme.primary.withValues(alpha: 0.24)),
        borderRadius: BorderRadius.circular(context.radii.lg),
      ),
      child: Wrap(
        spacing: context.spacing.sm,
        runSpacing: context.spacing.sm,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.spacing.sm),
            child: Text(
              'Конструктор доски',
              style: textTheme.labelLarge?.copyWith(color: colorScheme.primary),
            ),
          ),
          OutlinedButton.icon(
            onPressed: onAddColumn,
            icon: const Icon(Icons.add_rounded),
            label: const Text('Добавить столбец'),
          ),
          TextButton(
            onPressed: state.isSaving ? null : onCancel,
            child: const Text('Отменить'),
          ),
          FilledButton.icon(
            onPressed: state.hasUnsavedChanges && !state.isSaving
                ? onSave
                : null,
            icon: state.isSaving
                ? const SizedBox.square(
                    dimension: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.check_rounded),
            label: const Text('Сохранить'),
          ),
          TextButton(
            onPressed: state.isSaving ? null : onDone,
            child: const Text('Готово'),
          ),
        ],
      ),
    );
  }
}
