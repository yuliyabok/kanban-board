import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/theme/app_breakpoints.dart';
import '../../../../../core/theme/app_icons.dart';
import '../../../../app/theme/app_design_tokens.dart';
import '../../../columns/domain/entities/board_column_entity.dart';

class ConstructorColumnCard extends StatefulWidget {
  const ConstructorColumnCard({
    required this.column,
    required this.index,
    required this.taskCount,
    required this.isSelected,
    required this.isEditing,
    required this.errorText,
    required this.onSelected,
    required this.onStartEditing,
    required this.onTitleChanged,
    required this.onFinishEditing,
    required this.onCancelEditing,
    required this.onDelete,
    super.key,
  });

  final BoardColumnEntity column;
  final int index;
  final int taskCount;
  final bool isSelected;
  final bool isEditing;
  final String? errorText;
  final VoidCallback onSelected;
  final VoidCallback onStartEditing;
  final ValueChanged<String> onTitleChanged;
  final VoidCallback onFinishEditing;
  final VoidCallback onCancelEditing;
  final VoidCallback onDelete;

  @override
  State<ConstructorColumnCard> createState() => _ConstructorColumnCardState();
}

class _ConstructorColumnCardState extends State<ConstructorColumnCard> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.column.title);
    _focusNode = FocusNode();
  }

  @override
  void didUpdateWidget(ConstructorColumnCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.column.title != widget.column.title &&
        _controller.text != widget.column.title) {
      _controller.text = widget.column.title;
    }
    if (!oldWidget.isEditing && widget.isEditing) {
      _focusNode.requestFocus();
      _controller.selection = TextSelection(
        baseOffset: 0,
        extentOffset: _controller.text.length,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final device = AppBreakpoints.of(context);
    final showActions = _hovered || widget.isSelected || !device.isDesktop;
    final width = switch (device) {
      AppDeviceClass.phone => MediaQuery.sizeOf(context).width * 0.84,
      AppDeviceClass.tablet => 292.0,
      AppDeviceClass.desktop => 304.0,
      AppDeviceClass.largeDesktop => 324.0,
    };
    final borderColor = widget.errorText != null
        ? colorScheme.error
        : widget.isSelected
        ? colorScheme.primary
        : _hovered
        ? colorScheme.outline
        : colorScheme.outlineVariant;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onSelected,
        child: AnimatedContainer(
          duration: context.motion.base,
          curve: context.motion.emphasized,
          width: width.clamp(280, 340).toDouble(),
          padding: EdgeInsets.all(context.spacing.md),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerLowest,
            border: Border.all(color: borderColor),
            borderRadius: context.radii.card,
            boxShadow: _hovered ? context.shadows.card : const [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ReorderableDragStartListener(
                    index: widget.index,
                    child: Icon(
                      AppIcons.drag,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(width: context.spacing.sm),
                  Expanded(child: _buildTitle(context)),
                  AnimatedOpacity(
                    opacity: showActions ? 1 : 0,
                    duration: context.motion.fast,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          tooltip: 'Переименовать',
                          onPressed: widget.onStartEditing,
                          icon: const Icon(AppIcons.edit, size: 18),
                        ),
                        IconButton(
                          tooltip: 'Удалить столбец',
                          onPressed: widget.onDelete,
                          icon: const Icon(
                            AppIcons.delete,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (widget.errorText != null) ...[
                SizedBox(height: context.spacing.sm),
                Text(
                  widget.errorText!,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.error,
                  ),
                ),
              ],
              SizedBox(height: context.spacing.lg),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(context.spacing.md),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(context.radii.md),
                  border: Border.all(color: colorScheme.outlineVariant),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.task_alt_rounded,
                      size: 18,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    SizedBox(width: context.spacing.sm),
                    Text(
                      '${widget.taskCount} задач',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                'Позиция ${widget.index + 1}',
                style: textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    if (!widget.isEditing) {
      return InkWell(
        onDoubleTap: widget.onStartEditing,
        borderRadius: BorderRadius.circular(context.radii.sm),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: context.spacing.sm),
          child: Text(
            widget.column.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      );
    }

    return Focus(
      onKeyEvent: (node, event) {
        if (event is! KeyDownEvent) return KeyEventResult.ignored;
        if (event.logicalKey == LogicalKeyboardKey.enter) {
          widget.onFinishEditing();
          return KeyEventResult.handled;
        }
        if (event.logicalKey == LogicalKeyboardKey.escape) {
          widget.onCancelEditing();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        maxLength: 50,
        decoration: const InputDecoration(
          counterText: '',
          isDense: true,
        ),
        textInputAction: TextInputAction.done,
        onChanged: widget.onTitleChanged,
        onSubmitted: (_) => widget.onFinishEditing(),
      ),
    );
  }
}
