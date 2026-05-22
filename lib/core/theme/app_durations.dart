import 'package:flutter/material.dart';

@immutable
class AppDurations extends ThemeExtension<AppDurations> {
  const AppDurations({
    this.hover = const Duration(milliseconds: 140),
    this.fast = const Duration(milliseconds: 120),
    this.base = const Duration(milliseconds: 180),
    this.page = const Duration(milliseconds: 220),
    this.slow = const Duration(milliseconds: 260),
    this.emphasized = Curves.easeOutCubic,
    this.standard = Curves.easeInOutCubic,
  });

  final Duration hover;
  final Duration fast;
  final Duration base;
  final Duration page;
  final Duration slow;
  final Curve emphasized;
  final Curve standard;

  @override
  AppDurations copyWith({
    Duration? hover,
    Duration? fast,
    Duration? base,
    Duration? page,
    Duration? slow,
    Curve? emphasized,
    Curve? standard,
  }) {
    return AppDurations(
      hover: hover ?? this.hover,
      fast: fast ?? this.fast,
      base: base ?? this.base,
      page: page ?? this.page,
      slow: slow ?? this.slow,
      emphasized: emphasized ?? this.emphasized,
      standard: standard ?? this.standard,
    );
  }

  @override
  AppDurations lerp(ThemeExtension<AppDurations>? other, double t) => this;
}

typedef AppMotion = AppDurations;
