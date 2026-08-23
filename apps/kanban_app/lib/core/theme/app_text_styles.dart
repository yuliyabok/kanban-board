import 'package:flutter/material.dart';

final class AppTextStyles {
  const AppTextStyles._();

  static const String fontFamily = 'Inter';

  static TextTheme textTheme(ColorScheme colorScheme) {
    const base = TextStyle(
      fontFamily: fontFamily,
      letterSpacing: 0,
      height: 1.35,
    );

    TextStyle style({
      required double size,
      required FontWeight weight,
      required double height,
      Color? color,
    }) {
      return base.copyWith(
        fontSize: size,
        fontWeight: weight,
        height: height,
        color: color ?? colorScheme.onSurface,
      );
    }

    return TextTheme(
      displayLarge: style(size: 48, weight: FontWeight.w700, height: 1.08),
      displayMedium: style(size: 40, weight: FontWeight.w700, height: 1.1),
      displaySmall: style(size: 32, weight: FontWeight.w700, height: 1.15),
      headlineLarge: style(size: 28, weight: FontWeight.w700, height: 1.18),
      headlineMedium: style(size: 24, weight: FontWeight.w700, height: 1.22),
      headlineSmall: style(size: 20, weight: FontWeight.w600, height: 1.25),
      titleLarge: style(size: 18, weight: FontWeight.w600, height: 1.28),
      titleMedium: style(size: 16, weight: FontWeight.w600, height: 1.3),
      titleSmall: style(size: 14, weight: FontWeight.w600, height: 1.3),
      bodyLarge: style(size: 16, weight: FontWeight.w400, height: 1.5),
      bodyMedium: style(size: 14, weight: FontWeight.w400, height: 1.45),
      bodySmall: style(
        size: 12,
        weight: FontWeight.w400,
        height: 1.4,
        color: colorScheme.onSurfaceVariant,
      ),
      labelLarge: style(size: 14, weight: FontWeight.w600, height: 1.25),
      labelMedium: style(size: 12, weight: FontWeight.w600, height: 1.2),
      labelSmall: style(size: 11, weight: FontWeight.w600, height: 1.15),
    );
  }
}
