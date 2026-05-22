import '../../../core/theme/app_breakpoints.dart';
import '../../../core/theme/app_spacing.dart';
import 'package:flutter/widgets.dart';

typedef AppBreakpoint = AppDeviceClass;

final class AppAdaptive {
  const AppAdaptive._();

  static AppDeviceClass breakpointFor(double width) {
    return AppBreakpoints.fromWidth(width);
  }

  static AppDeviceClass of(BuildContext context) {
    return AppBreakpoints.of(context);
  }

  static double pagePadding(BuildContext context) {
    return AppInsets.page(of(context)).left;
  }

  static int boardGridColumns(BuildContext context) {
    return switch (of(context)) {
      AppDeviceClass.phone => 1,
      AppDeviceClass.tablet => 2,
      AppDeviceClass.desktop => 3,
      AppDeviceClass.largeDesktop => 4,
    };
  }

  static double contentMaxWidth(BuildContext context) {
    return switch (of(context)) {
      AppDeviceClass.phone => double.infinity,
      AppDeviceClass.tablet => 920,
      AppDeviceClass.desktop => 1180,
      AppDeviceClass.largeDesktop => 1360,
    };
  }
}
