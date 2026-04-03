import 'package:flutter/material.dart';

class ThemeService {
  static ValueNotifier<bool> isDarkThemeNotifier = ValueNotifier<bool>(false);

  static void toggleTheme() {
    isDarkThemeNotifier.value = !isDarkThemeNotifier.value;
  }

  static void setTheme({required bool isDark}) {
    isDarkThemeNotifier.value = isDark;
  }
}
