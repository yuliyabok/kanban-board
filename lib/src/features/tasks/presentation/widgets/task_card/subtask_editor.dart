import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/theme/app_theme.dart';
import '../../../domain/entities/task_entity.dart';
import '../../controllers/tasks_controller.dart';

class SubtaskEditor extends ConsumerStatefulWidget {
  const SubtaskEditor({
    required this.parent,
    super.key,
  });

  final TaskEntity parent;

  @override
  ConsumerState<SubtaskEditor> createState() => _SubtaskEditorState();
}

class _SubtaskEditorState extends ConsumerState<SubtaskEditor> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: 'Новая подзадача'),
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _submit(),
          ),
        ),
        SizedBox(width: context.spacing.sm),
        IconButton(
          tooltip: 'Добавить',
          onPressed: _submit,
          icon: const Icon(Icons.add_rounded),
        ),
      ],
    );
  }

  Future<void> _submit() async {
    final title = _controller.text.trim();
    if (title.isEmpty) return;
    await ref
        .read(tasksControllerProvider.notifier)
        .addSubtask(
          parent: widget.parent,
          title: title,
        );
    _controller.clear();
  }
}
