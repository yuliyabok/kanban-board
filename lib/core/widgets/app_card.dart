import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AppCard extends StatefulWidget {
  const AppCard({
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(14),
    this.selected = false,
    this.width,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 1,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final bool selected;
  final double? width;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  bool _hovered = false;
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final borderColor =
        widget.borderColor ??
        (widget.selected
            ? colorScheme.primary
            : _hovered || _focused
            ? colorScheme.outline
            : colorScheme.outlineVariant);

    return FocusableActionDetector(
      onShowFocusHighlight: (value) => setState(() => _focused = value),
      mouseCursor: widget.onTap == null
          ? MouseCursor.defer
          : SystemMouseCursors.click,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: AnimatedContainer(
          duration: context.motion.hover,
          curve: context.motion.emphasized,
          width: widget.width,
          transform: Matrix4.translationValues(0, _hovered ? -1 : 0, 0),
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? colorScheme.surfaceContainerLowest,
            border: Border.all(color: borderColor, width: widget.borderWidth),
            borderRadius: context.radii.card,
            boxShadow: _focused
                ? context.shadows.focus
                : _hovered
                ? context.shadows.card
                : const [],
          ),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: widget.onTap,
              borderRadius: context.radii.card,
              child: Padding(
                padding: widget.padding,
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
