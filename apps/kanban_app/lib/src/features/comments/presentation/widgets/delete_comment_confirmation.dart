import 'package:flutter/material.dart';

class DeleteCommentConfirmation extends StatelessWidget {
  const DeleteCommentConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Удалить комментарий?'),
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
    );
  }
}
