import 'package:flutter/material.dart';

final class AppTaskTypeColor {
  const AppTaskTypeColor({
    required this.id,
    required this.light,
    required this.dark,
  });

  final String id;
  final Color light;
  final Color dark;

  Color resolve(Brightness brightness) {
    return brightness == Brightness.dark ? dark : light;
  }
}

final class AppTaskTypeColorPalette {
  const AppTaskTypeColorPalette._();

  static const colors = [
    AppTaskTypeColor(
      id: 'blue',
      light: Color(0xFF4F7DFF),
      dark: Color(0xFF8DA8FF),
    ),
    AppTaskTypeColor(
      id: 'red',
      light: Color(0xFFE5484D),
      dark: Color(0xFFFF7A7E),
    ),
    AppTaskTypeColor(
      id: 'violet',
      light: Color(0xFF7C5CFC),
      dark: Color(0xFFA996FF),
    ),
    AppTaskTypeColor(
      id: 'pink',
      light: Color(0xFFC33C8A),
      dark: Color(0xFFE785BF),
    ),
    AppTaskTypeColor(
      id: 'slate',
      light: Color(0xFF596275),
      dark: Color(0xFFB8C0CF),
    ),
    AppTaskTypeColor(
      id: 'amber',
      light: Color(0xFFB7791F),
      dark: Color(0xFFE4B363),
    ),
    AppTaskTypeColor(
      id: 'green',
      light: Color(0xFF22A06B),
      dark: Color(0xFF54C895),
    ),
    AppTaskTypeColor(
      id: 'orange',
      light: Color(0xFFD96C2C),
      dark: Color(0xFFFFA36B),
    ),
  ];

  static bool isAllowed(String id) {
    return colors.any((color) => color.id == id);
  }

  static Color resolve(
    BuildContext context,
    String? id, {
    double alpha = 1,
  }) {
    final token = colors.firstWhere(
      (color) => color.id == id,
      orElse: () => colors.first,
    );
    return token.resolve(Theme.of(context).brightness).withValues(alpha: alpha);
  }
}
