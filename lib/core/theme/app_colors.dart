import 'package:flutter/material.dart';

final class AppColors {
  const AppColors._();

  static const Color primary = Color(0xFF4F7DFF);
  static const Color primaryDark = Color(0xFF8DA8FF);
  static const Color success = Color(0xFF22A06B);
  static const Color warning = Color(0xFFB7791F);
  static const Color danger = Color(0xFFE5484D);

  static const Color lightSurface = Color(0xFFF7F8FB);
  static const Color lightPanel = Color(0xFFFFFFFF);
  static const Color lightPanelAlt = Color(0xFFF1F3F7);
  static const Color lightText = Color(0xFF12151C);
  static const Color lightMuted = Color(0xFF667085);
  static const Color lightBorder = Color(0xFFE8EBF1);

  static const Color darkSurface = Color(0xFF0E1117);
  static const Color darkPanel = Color(0xFF12161F);
  static const Color darkPanelAlt = Color(0xFF1D222D);
  static const Color darkText = Color(0xFFE7EAF0);
  static const Color darkMuted = Color(0xFFA5ADBC);
  static const Color darkBorder = Color(0xFF2A303D);

  static const Color focusRing = Color(0x664F7DFF);

  static const ColorScheme lightScheme = ColorScheme.light(
    primary: primary,
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFEAF0FF),
    onPrimaryContainer: Color(0xFF17315F),
    secondary: Color(0xFF596275),
    onSecondary: Color(0xFFFFFFFF),
    tertiary: success,
    error: danger,
    surface: lightSurface,
    onSurface: lightText,
    surfaceContainerLowest: lightPanel,
    surfaceContainerLow: Color(0xFFFDFDFE),
    surfaceContainer: lightPanelAlt,
    surfaceContainerHigh: Color(0xFFE9ECF2),
    surfaceContainerHighest: Color(0xFFE1E5EE),
    onSurfaceVariant: lightMuted,
    outline: Color(0xFFD8DDE7),
    outlineVariant: lightBorder,
    shadow: Color(0xFF0F172A),
    scrim: Color(0x990B1020),
  );

  static const ColorScheme darkScheme = ColorScheme.dark(
    primary: primaryDark,
    onPrimary: Color(0xFF081225),
    primaryContainer: Color(0xFF1B2B52),
    onPrimaryContainer: Color(0xFFDDE6FF),
    secondary: Color(0xFFB8C0CF),
    onSecondary: Color(0xFF10131A),
    tertiary: Color(0xFF54C895),
    error: Color(0xFFFF6B6F),
    surface: darkSurface,
    onSurface: darkText,
    surfaceContainerLowest: darkPanel,
    surfaceContainerLow: Color(0xFF171B24),
    surfaceContainer: darkPanelAlt,
    surfaceContainerHigh: Color(0xFF252B38),
    surfaceContainerHighest: Color(0xFF303746),
    onSurfaceVariant: darkMuted,
    outline: Color(0xFF3A4252),
    outlineVariant: darkBorder,
    shadow: Color(0xFF000000),
    scrim: Color(0xCC000000),
  );
}
