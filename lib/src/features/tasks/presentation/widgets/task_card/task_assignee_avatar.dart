import 'package:flutter/material.dart';

class TaskAssigneeAvatar extends StatelessWidget {
  const TaskAssigneeAvatar({
    required this.name,
    super.key,
  });

  final String? name;

  @override
  Widget build(BuildContext context) {
    final assigneeName = name;
    if (assigneeName == null || assigneeName.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return Tooltip(
      message: assigneeName,
      child: CircleAvatar(
        radius: 12,
        child: Text(
          assigneeName.trim().characters.first.toUpperCase(),
          style: const TextStyle(fontSize: 11),
        ),
      ),
    );
  }
}
