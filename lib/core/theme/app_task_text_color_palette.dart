import 'package:flutter/material.dart';

final class AppTaskTextColor {
  const AppTaskTextColor({
    required this.id,
    required this.label,
    required this.light,
    required this.dark,
  });

  final String id;
  final String label;
  final Color light;
  final Color dark;

  Color resolve(Brightness brightness) {
    return brightness == Brightness.dark ? dark : light;
  }
}

final class AppTaskTextColorPalette {
  const AppTaskTextColorPalette._();

  static const colors = [
    AppTaskTextColor(
      id: 'default',
      label: 'Default',
      light: Color(0xFF12151C),
      dark: Color(0xFFE7EAF0),
    ),
    AppTaskTextColor(
      id: 'blue',
      label: 'Blue',
      light: Color(0xFF214FBB),
      dark: Color(0xFFAFC2FF),
    ),
    AppTaskTextColor(
      id: 'green',
      label: 'Green',
      light: Color(0xFF137A4F),
      dark: Color(0xFF8EE2B7),
    ),
    AppTaskTextColor(
      id: 'red',
      label: 'Red',
      light: Color(0xFFB4232A),
      dark: Color(0xFFFFA3A6),
    ),
    AppTaskTextColor(
      id: 'violet',
      label: 'Violet',
      light: Color(0xFF5B3FD6),
      dark: Color(0xFFC8BBFF),
    ),
    AppTaskTextColor(
      id: 'slate',
      label: 'Slate',
      light: Color(0xFF475467),
      dark: Color(0xFFC7CEDA),
    ),
  ];

  static Color resolve(BuildContext context, String? id) {
    final token = colors.firstWhere(
      (color) => color.id == id,
      orElse: () => colors.first,
    );
    return token.resolve(Theme.of(context).brightness);
  }
}
