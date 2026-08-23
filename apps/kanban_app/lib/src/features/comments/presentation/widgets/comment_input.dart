import 'package:flutter/material.dart';

class CommentInput extends StatefulWidget {
  const CommentInput({required this.onSubmit, super.key});

  final ValueChanged<String> onSubmit;

  @override
  State<CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
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
            minLines: 1,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Комментарий',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton.filled(
          tooltip: 'Отправить',
          onPressed: () {
            if (_controller.text.trim().isEmpty) return;
            widget.onSubmit(_controller.text);
            _controller.clear();
          },
          icon: const Icon(Icons.send),
        ),
      ],
    );
  }
}
