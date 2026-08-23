import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.selected = false,
    super.key,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      style: IconButton.styleFrom(
        backgroundColor: selected
            ? colorScheme.primaryContainer.withValues(alpha: 0.7)
            : Colors.transparent,
        foregroundColor: selected
            ? colorScheme.primary
            : colorScheme.onSurfaceVariant,
      ),
      icon: Icon(icon, size: 20),
    );
  }
}
