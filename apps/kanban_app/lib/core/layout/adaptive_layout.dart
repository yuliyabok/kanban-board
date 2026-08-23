import 'package:flutter/material.dart';

import '../theme/app_breakpoints.dart';
import '../theme/app_theme.dart';

class AdaptiveLayout extends StatelessWidget {
  const AdaptiveLayout({
    required this.content,
    this.sidebar,
    this.toolbar,
    this.bottomNavigationBar,
    this.drawer,
    this.floatingActionButton,
    super.key,
  });

  final Widget content;
  final Widget? sidebar;
  final PreferredSizeWidget? toolbar;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    final device = AppBreakpoints.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    if (device.isPhone) {
      return Scaffold(
        appBar: toolbar,
        drawer: drawer ?? (sidebar == null ? null : Drawer(child: sidebar)),
        body: content,
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
      );
    }

    return Scaffold(
      appBar: toolbar,
      body: Row(
        children: [
          if (sidebar != null)
            AnimatedContainer(
              duration: context.motion.page,
              curve: context.motion.emphasized,
              width: device == AppDeviceClass.tablet ? 84 : 268,
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerLowest,
                border: Border(
                  right: BorderSide(color: colorScheme.outlineVariant),
                ),
              ),
              child: sidebar,
            ),
          Expanded(child: content),
        ],
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
