import 'package:flutter/material.dart';

class TaskAssigneeAvatar extends StatelessWidget {
  const TaskAssigneeAvatar({
    required this.label,
    this.avatarUrl,
    this.radius = 12,
    super.key,
  });

  final String? label;
  final String? avatarUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final resolvedLabel = label?.trim();
    if (resolvedLabel == null || resolvedLabel.isEmpty) {
      return const SizedBox.shrink();
    }
    final resolvedAvatarUrl = avatarUrl?.trim();

    return Tooltip(
      message: resolvedLabel,
      child: CircleAvatar(
        radius: radius,
        backgroundImage: resolvedAvatarUrl == null || resolvedAvatarUrl.isEmpty
            ? null
            : NetworkImage(resolvedAvatarUrl),
        child: resolvedAvatarUrl == null || resolvedAvatarUrl.isEmpty
            ? Text(
                resolvedLabel.characters.first.toUpperCase(),
                style: TextStyle(fontSize: radius * 0.9),
              )
            : null,
      ),
    );
  }
}
