import 'package:flutter/material.dart';

@immutable
class AppRadius extends ThemeExtension<AppRadius> {
  const AppRadius({
    this.xs = 6,
    this.sm = 8,
    this.md = 10,
    this.lg = 12,
    this.xl = 16,
    this.modal = 20,
  });

  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double modal;

  BorderRadius get card => BorderRadius.circular(lg);
  BorderRadius get control => BorderRadius.circular(md);
  BorderRadius get sheet => BorderRadius.circular(modal);

  @override
  AppRadius copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? modal,
  }) {
    return AppRadius(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      modal: modal ?? this.modal,
    );
  }

  @override
  AppRadius lerp(ThemeExtension<AppRadius>? other, double t) {
    if (other is! AppRadius) return this;

    return AppRadius(
      xs: _lerp(xs, other.xs, t),
      sm: _lerp(sm, other.sm, t),
      md: _lerp(md, other.md, t),
      lg: _lerp(lg, other.lg, t),
      xl: _lerp(xl, other.xl, t),
      modal: _lerp(modal, other.modal, t),
    );
  }
}

typedef AppRadii = AppRadius;

double _lerp(double a, double b, double t) => a + (b - a) * t;
