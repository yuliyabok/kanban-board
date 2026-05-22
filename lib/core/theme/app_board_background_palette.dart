import 'package:flutter/material.dart';

final class AppBoardBackgroundColor {
  const AppBoardBackgroundColor({
    required this.id,
    required this.label,
    required this.lightCard,
    required this.darkCard,
    required this.lightColumn,
    required this.darkColumn,
  });

  final String id;
  final String label;
  final Color lightCard;
  final Color darkCard;
  final Color lightColumn;
  final Color darkColumn;

  Color resolveCard(Brightness brightness) {
    return brightness == Brightness.dark ? darkCard : lightCard;
  }

  Color resolveColumn(Brightness brightness) {
    return brightness == Brightness.dark ? darkColumn : lightColumn;
  }
}

final class AppBoardBackgroundPalette {
  const AppBoardBackgroundPalette._();

  static const colors = [
    AppBoardBackgroundColor(
      id: 'default',
      label: 'Default',
      lightCard: Color(0xFFFFFFFF),
      darkCard: Color(0xFF12161F),
      lightColumn: Color(0xFFFDFDFE),
      darkColumn: Color(0xFF171B24),
    ),
    AppBoardBackgroundColor(
      id: 'blue',
      label: 'Blue',
      lightCard: Color(0xFFF3F6FF),
      darkCard: Color(0xFF151D33),
      lightColumn: Color(0xFFEEF3FF),
      darkColumn: Color(0xFF111A2D),
    ),
    AppBoardBackgroundColor(
      id: 'green',
      label: 'Green',
      lightCard: Color(0xFFF0FAF5),
      darkCard: Color(0xFF12251D),
      lightColumn: Color(0xFFEAF7F1),
      darkColumn: Color(0xFF102018),
    ),
    AppBoardBackgroundColor(
      id: 'amber',
      label: 'Amber',
      lightCard: Color(0xFFFFF8EA),
      darkCard: Color(0xFF2A2113),
      lightColumn: Color(0xFFFFF3D7),
      darkColumn: Color(0xFF241C10),
    ),
    AppBoardBackgroundColor(
      id: 'rose',
      label: 'Rose',
      lightCard: Color(0xFFFFF2F5),
      darkCard: Color(0xFF2A161D),
      lightColumn: Color(0xFFFFEAF0),
      darkColumn: Color(0xFF24131A),
    ),
    AppBoardBackgroundColor(
      id: 'violet',
      label: 'Violet',
      lightCard: Color(0xFFF7F3FF),
      darkCard: Color(0xFF211A33),
      lightColumn: Color(0xFFF1EAFF),
      darkColumn: Color(0xFF1C162D),
    ),
  ];

  static bool isAllowed(String id) {
    return colors.any((color) => color.id == id);
  }

  static Color resolveCard(BuildContext context, String id) {
    return _byId(id).resolveCard(Theme.of(context).brightness);
  }

  static Color resolveColumn(BuildContext context, String id) {
    return _byId(id).resolveColumn(Theme.of(context).brightness);
  }

  static AppBoardBackgroundColor _byId(String id) {
    return colors.firstWhere(
      (color) => color.id == id,
      orElse: () => colors.first,
    );
  }
}
