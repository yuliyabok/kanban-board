import 'package:flutter/material.dart';

@immutable
class AppShadows extends ThemeExtension<AppShadows> {
  const AppShadows({
    required this.card,
    required this.popover,
    required this.drag,
    required this.focus,
  });

  factory AppShadows.light() {
    return const AppShadows(
      card: [
        BoxShadow(
          color: Color(0x0A0F172A),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
      popover: [
        BoxShadow(
          color: Color(0x1A0F172A),
          blurRadius: 30,
          offset: Offset(0, 18),
        ),
      ],
      drag: [
        BoxShadow(
          color: Color(0x260F172A),
          blurRadius: 28,
          offset: Offset(0, 16),
        ),
      ],
      focus: [
        BoxShadow(
          color: Color(0x334F7DFF),
          blurRadius: 0,
          spreadRadius: 3,
        ),
      ],
    );
  }

  factory AppShadows.dark() {
    return const AppShadows(
      card: [
        BoxShadow(
          color: Color(0x40000000),
          blurRadius: 18,
          offset: Offset(0, 8),
        ),
      ],
      popover: [
        BoxShadow(
          color: Color(0x80000000),
          blurRadius: 34,
          offset: Offset(0, 22),
        ),
      ],
      drag: [
        BoxShadow(
          color: Color(0x99000000),
          blurRadius: 36,
          offset: Offset(0, 20),
        ),
      ],
      focus: [
        BoxShadow(
          color: Color(0x448DA8FF),
          blurRadius: 0,
          spreadRadius: 3,
        ),
      ],
    );
  }

  final List<BoxShadow> card;
  final List<BoxShadow> popover;
  final List<BoxShadow> drag;
  final List<BoxShadow> focus;

  @override
  AppShadows copyWith({
    List<BoxShadow>? card,
    List<BoxShadow>? popover,
    List<BoxShadow>? drag,
    List<BoxShadow>? focus,
  }) {
    return AppShadows(
      card: card ?? this.card,
      popover: popover ?? this.popover,
      drag: drag ?? this.drag,
      focus: focus ?? this.focus,
    );
  }

  @override
  AppShadows lerp(ThemeExtension<AppShadows>? other, double t) => this;
}
