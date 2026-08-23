import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../domain/entities/board_card_settings.dart';
import '../controllers/board_card_settings_controller.dart';

class TaskCardSettingsPanel extends ConsumerWidget {
  const TaskCardSettingsPanel({
    required this.settings,
    super.key,
  });

  final BoardCardSettings settings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 420),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(context.spacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Настройки карточек',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: context.spacing.lg),
              _SwitchRow(
                label: 'Описание',
                value: settings.showDescription,
                onChanged: (value) =>
                    _update(ref, settings.copyWith(showDescription: value)),
              ),
              _SwitchRow(
                label: 'Тип задачи',
                value: settings.showTaskType,
                onChanged: (value) =>
                    _update(ref, settings.copyWith(showTaskType: value)),
              ),
              _SwitchRow(
                label: 'Период',
                value: settings.showPeriod,
                onChanged: (value) =>
                    _update(ref, settings.copyWith(showPeriod: value)),
              ),
              _SwitchRow(
                label: 'Прогресс подзадач',
                value: settings.showSubtaskProgress,
                onChanged: (value) =>
                    _update(ref, settings.copyWith(showSubtaskProgress: value)),
              ),
              _SwitchRow(
                label: 'Приоритет',
                value: settings.showPriority,
                onChanged: (value) =>
                    _update(ref, settings.copyWith(showPriority: value)),
              ),
              _SwitchRow(
                label: 'Исполнитель',
                value: settings.showAssignee,
                onChanged: (value) =>
                    _update(ref, settings.copyWith(showAssignee: value)),
              ),
              _SwitchRow(
                label: 'Labels',
                value: settings.showLabels,
                onChanged: (value) =>
                    _update(ref, settings.copyWith(showLabels: value)),
              ),
              _SwitchRow(
                label: 'Quick actions',
                value: settings.showQuickActions,
                onChanged: (value) =>
                    _update(ref, settings.copyWith(showQuickActions: value)),
              ),
              SizedBox(height: context.spacing.lg),
              DropdownButtonFormField<TaskCardDensity>(
                initialValue: settings.density,
                decoration: const InputDecoration(labelText: 'Плотность'),
                items: TaskCardDensity.values
                    .map(
                      (value) => DropdownMenuItem(
                        value: value,
                        child: Text(value.name),
                      ),
                    )
                    .toList(growable: false),
                onChanged: (value) {
                  if (value != null) {
                    _update(ref, settings.copyWith(density: value));
                  }
                },
              ),
              SizedBox(height: context.spacing.md),
              DropdownButtonFormField<TaskCardStyle>(
                initialValue: settings.style,
                decoration: const InputDecoration(labelText: 'Стиль'),
                items: TaskCardStyle.values
                    .map(
                      (value) => DropdownMenuItem(
                        value: value,
                        child: Text(value.name),
                      ),
                    )
                    .toList(growable: false),
                onChanged: (value) {
                  if (value != null) {
                    _update(ref, settings.copyWith(style: value));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _update(WidgetRef ref, BoardCardSettings value) {
    return ref
        .read(boardCardSettingsControllerProvider.notifier)
        .saveSettings(value);
  }
}

class _SwitchRow extends StatelessWidget {
  const _SwitchRow({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      value: value,
      onChanged: onChanged,
    );
  }
}
