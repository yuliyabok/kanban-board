import 'package:flutter/widgets.dart';

import '../theme/app_breakpoints.dart';

typedef ResponsiveWidgetBuilder =
    Widget Function(BuildContext context, AppDeviceClass device);

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    required this.builder,
    super.key,
  });

  final ResponsiveWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return builder(
          context,
          AppBreakpoints.fromWidth(constraints.maxWidth),
        );
      },
    );
  }
}
