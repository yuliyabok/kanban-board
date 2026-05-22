import 'package:flutter/material.dart';

import 'app_breakpoints.dart';

@immutable
class AppSpacing extends ThemeExtension<AppSpacing> {
  const AppSpacing({
    this.xs = 4,
    this.sm = 8,
    this.md = 12,
    this.lg = 16,
    this.xl = 24,
    this.xxl = 32,
    this.xxxl = 48,
  });

  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;
  final double xxxl;

  @override
  AppSpacing copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
    double? xxxl,
  }) {
    return AppSpacing(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
      xxxl: xxxl ?? this.xxxl,
    );
  }

  @override
  AppSpacing lerp(ThemeExtension<AppSpacing>? other, double t) {
    if (other is! AppSpacing) return this;

    return AppSpacing(
      xs: _lerp(xs, other.xs, t),
      sm: _lerp(sm, other.sm, t),
      md: _lerp(md, other.md, t),
      lg: _lerp(lg, other.lg, t),
      xl: _lerp(xl, other.xl, t),
      xxl: _lerp(xxl, other.xxl, t),
      xxxl: _lerp(xxxl, other.xxxl, t),
    );
  }
}

final class AppInsets {
  const AppInsets._();

  static const EdgeInsets control = EdgeInsets.symmetric(
    horizontal: 14,
    vertical: 12,
  );
  static const EdgeInsets button = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 12,
  );
  static const EdgeInsets card = EdgeInsets.all(14);
  static const EdgeInsets panel = EdgeInsets.all(16);

  static EdgeInsets page(AppDeviceClass device) {
    return switch (device) {
      AppDeviceClass.phone => const EdgeInsets.all(12),
      AppDeviceClass.tablet => const EdgeInsets.all(20),
      AppDeviceClass.desktop => const EdgeInsets.all(24),
      AppDeviceClass.largeDesktop => const EdgeInsets.all(32),
    };
  }
}

double _lerp(double a, double b, double t) => a + (b - a) * t;
