import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/app_breakpoints.dart';
import '../../../../../core/theme/app_task_type_color_palette.dart';
import '../../../../app/theme/app_design_tokens.dart';
import '../../../task_types/domain/entities/task_type_entity.dart';
import '../../../task_types/presentation/controllers/task_types_controller.dart';
import '../../../task_types/presentation/widgets/task_type_color_picker.dart';

class ConstructorTaskTypesPanel extends ConsumerStatefulWidget {
  const ConstructorTaskTypesPanel({
    required this.boardId,
    required this.taskTypes,
    super.key,
  });

  final String boardId;
  final List<TaskTypeEntity> taskTypes;

  @override
  ConsumerState<ConstructorTaskTypesPanel> createState() =>
      _ConstructorTaskTypesPanelState();
}

class _ConstructorTaskTypesPanelState
    extends ConsumerState<ConstructorTaskTypesPanel> {
  final _nameController = TextEditingController();
  String _selectedColor = AppTaskTypeColorPalette.colors.first.id;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final width = AppBreakpoints.of(context).isPhone ? double.infinity : 320.0;

    return Container(
      width: width,
      padding: EdgeInsets.all(context.spacing.md),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        border: Border.all(color: colorScheme.outlineVariant),
        borderRadius: context.radii.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Типы задач', style: textTheme.titleMedium),
          SizedBox(height: context.spacing.sm),
          Expanded(
            child: ListView.separated(
              itemCount: widget.taskTypes.length,
              separatorBuilder: (context, index) =>
                  SizedBox(height: context.spacing.xs),
              itemBuilder: (context, index) {
                final type = widget.taskTypes[index];
                return _TaskTypeRow(
                  type: type,
                  canDelete: widget.taskTypes.length > 1,
                  onEdit: () => unawaited(_edit(type)),
                  onDelete: () => unawaited(_delete(type)),
                );
              },
            ),
          ),
          Divider(color: colorScheme.outlineVariant),
          SizedBox(height: context.spacing.sm),
          TextField(
            controller: _nameController,
            maxLength: 50,
            decoration: const InputDecoration(
              counterText: '',
              hintText: 'Новый тип',
              prefixIcon: Icon(Icons.category_outlined),
            ),
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _create(),
          ),
          SizedBox(height: context.spacing.sm),
          TaskTypeColorPicker(
            selectedColorId: _selectedColor,
            onSelected: (value) => setState(() => _selectedColor = value),
          ),
          SizedBox(height: context.spacing.md),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _create,
              icon: const Icon(Icons.add_rounded),
              label: const Text('Добавить тип'),
            ),
          ),
        ],
      ),
    );
  }

  void _create() {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;
    unawaited(
      ref
          .read(taskTypesControllerProvider.notifier)
          .create(
            boardId: widget.boardId,
            name: name,
            color: _selectedColor,
            icon: 'task_alt',
          ),
    );
    _nameController.clear();
  }

  Future<void> _edit(TaskTypeEntity type) async {
    final updated = await showDialog<TaskTypeEntity>(
      context: context,
      builder: (context) => _TaskTypeEditDialog(type: type),
    );
    if (updated == null) return;
    unawaited(
      ref.read(taskTypesControllerProvider.notifier).updateType(updated),
    );
  }

  Future<void> _delete(TaskTypeEntity type) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Удалить «${type.name}»?'),
        content: const Text('У задач с этим типом тип будет сброшен.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Отмена'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    unawaited(ref.read(taskTypesControllerProvider.notifier).delete(type.id));
  }
}

class _TaskTypeRow extends StatelessWidget {
  const _TaskTypeRow({
    required this.type,
    required this.canDelete,
    required this.onEdit,
    required this.onDelete,
  });

  final TaskTypeEntity type;
  final bool canDelete;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final color = AppTaskTypeColorPalette.resolve(context, type.color);
    final colorScheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(context.radii.md),
      ),
      child: ListTile(
        dense: true,
        leading: CircleAvatar(radius: 8, backgroundColor: color),
        title: Text(type.name, maxLines: 1, overflow: TextOverflow.ellipsis),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              tooltip: 'Изменить тип',
              onPressed: onEdit,
              icon: const Icon(Icons.edit_rounded, size: 18),
            ),
            IconButton(
              tooltip: 'Удалить тип',
              onPressed: canDelete ? onDelete : null,
              icon: const Icon(Icons.delete_outline_rounded, size: 18),
            ),
          ],
        ),
      ),
    );
  }
}

class _TaskTypeEditDialog extends StatefulWidget {
  const _TaskTypeEditDialog({required this.type});

  final TaskTypeEntity type;

  @override
  State<_TaskTypeEditDialog> createState() => _TaskTypeEditDialogState();
}

class _TaskTypeEditDialogState extends State<_TaskTypeEditDialog> {
  late final TextEditingController _controller;
  late String _color;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.type.name);
    _color = widget.type.color;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Тип задачи'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _controller,
            maxLength: 50,
            decoration: const InputDecoration(
              counterText: '',
              labelText: 'Название',
            ),
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _submit(),
          ),
          SizedBox(height: context.spacing.md),
          TaskTypeColorPicker(
            selectedColorId: _color,
            onSelected: (value) => setState(() => _color = value),
          ),
        ],
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

  void _submit() {
    final name = _controller.text.trim();
    if (name.isEmpty) return;
    Navigator.of(context).pop(
      widget.type.copyWith(name: name, color: _color),
    );
  }
}
