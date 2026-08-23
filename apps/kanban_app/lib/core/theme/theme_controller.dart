//в этом файле описан контроллер темы, который управляет текущей темой приложения
// (светлая, темная или системная) и позволяет переключаться между ними.
// Он использует Riverpod для управления состоянием темы и обеспечивает удобный интерфейс для изменения темы в любом месте приложения.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeControllerProvider = NotifierProvider<ThemeController, ThemeMode>(
  ThemeController.new,
);

class ThemeController extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ThemeMode.system;

  ThemeMode get themeMode => state;

  set themeMode(ThemeMode mode) {
    state = mode;
  }

  void toggleLightDark() {
    state = switch (state) {
      ThemeMode.dark => ThemeMode.light,
      ThemeMode.light => ThemeMode.dark,
      ThemeMode.system => ThemeMode.dark,
    };
  }
}
