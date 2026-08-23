import 'package:flutter/widgets.dart';

enum AppDeviceClass {
  phone,
  tablet,
  desktop,
  largeDesktop
  ;

  bool get isPhone => this == phone;
  bool get isTablet => this == tablet;
  bool get isDesktop => this == desktop || this == largeDesktop;
}

final class AppBreakpoints {
  const AppBreakpoints._();

  static const double phone = 600;
  static const double tablet = 1024;
  static const double largeDesktop = 1440;

  static AppDeviceClass fromWidth(double width) {
    if (width < phone) return AppDeviceClass.phone;
    if (width <= tablet) return AppDeviceClass.tablet;
    if (width > largeDesktop) return AppDeviceClass.largeDesktop;
    return AppDeviceClass.desktop;
  }

  static AppDeviceClass of(BuildContext context) {
    return fromWidth(MediaQuery.sizeOf(context).width);
  }
}
