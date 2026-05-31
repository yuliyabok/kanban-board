import 'package:flutter/material.dart';

class TaskAssigneeAvatar extends StatelessWidget {
  const TaskAssigneeAvatar({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: CircleAvatar(
        radius: 12,
        child: Text(label.characters.first.toUpperCase()),
      ),
    );
  }
}
