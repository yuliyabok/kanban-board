import 'package:flutter/material.dart';

class EditCommentDialog extends StatefulWidget {
  const EditCommentDialog({required this.initialContent, super.key});

  final String initialContent;

  @override
  State<EditCommentDialog> createState() => _EditCommentDialogState();
}

class _EditCommentDialogState extends State<EditCommentDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialContent);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Редактировать комментарий'),
      content: TextField(
        controller: _controller,
        autofocus: true,
        minLines: 3,
        maxLines: 8,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop<String>(),
          child: const Text('Отмена'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(_controller.text),
          child: const Text('Сохранить'),
        ),
      ],
    );
  }
}
