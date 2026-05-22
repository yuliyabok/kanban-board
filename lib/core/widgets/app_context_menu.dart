import 'package:flutter/material.dart';

class AppContextMenuItem {
  const AppContextMenuItem({
    required this.label,
    required this.icon,
    required this.onSelected,
    this.isDanger = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback onSelected;
  final bool isDanger;
}

class AppContextMenu extends StatelessWidget {
  const AppContextMenu({
    required this.items,
    super.key,
  });

  final List<AppContextMenuItem> items;

  static Future<void> show(
    BuildContext context, {
    required Offset position,
    required List<AppContextMenuItem> items,
  }) async {
    final selected = await showMenu<int>(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        position.dx,
        position.dy,
      ),
      items: [
        for (var index = 0; index < items.length; index++)
          PopupMenuItem<int>(
            value: index,
            child: Row(
              children: [
                Icon(
                  items[index].icon,
                  size: 18,
                  color: items[index].isDanger
                      ? Theme.of(context).colorScheme.error
                      : null,
                ),
                const SizedBox(width: 10),
                Text(items[index].label),
              ],
            ),
          ),
      ],
    );
    if (selected != null) {
      items[selected].onSelected();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      menuChildren: [
        for (final item in items)
          MenuItemButton(
            leadingIcon: Icon(item.icon),
            onPressed: item.onSelected,
            child: Text(item.label),
          ),
      ],
      builder: (context, controller, child) {
        return IconButton(
          tooltip: 'Действия',
          onPressed: () =>
              controller.isOpen ? controller.close() : controller.open(),
          icon: const Icon(Icons.more_horiz_rounded),
        );
      },
    );
  }
}
