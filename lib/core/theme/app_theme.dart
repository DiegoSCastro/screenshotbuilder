import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  final TextTheme textTheme;

  const AppTheme(this.textTheme);

  //Light theme Colors
  static AppColors lightThemeColors() => const AppColors(
    primary: Color(0xFF135BEC),
    secondary: Color(0xFFD3F5B7),
    surfaceColor: Color(0xFFF6F6F8),
    onSurface: Color(0xFF000000),
    appBarColor: Color(0xFFFFFFFF),
    contentBorder: Color(0xFF334155),
    subtext: Color(0xFF64748B),
    cardBg: Color(0xFFFFFFFF),
    errorRed: Color(0xFFFF3B30),
  );
  // Light theme ColorScheme
  static ColorScheme lightScheme() {
    return ColorScheme.fromSeed(
      seedColor: const Color(0xFF135BEC),
      brightness: Brightness.light,
      errorContainer: const Color(0xFFFFF2EC),
      onErrorContainer: const Color(0xFFF44336),
    );
  }

  ThemeData light() {
    return theme(lightScheme(), lightThemeColors());
  }

  //Dark Theme colors
  static AppColors darkThemeColors() => const AppColors(
    primary: Color(0xFF135BEC),
    secondary: Color(0xFF1DE9B6),
    surfaceColor: Color(0xFF101622),
    onSurface: Color(0xFFFFFFFF),
    appBarColor: Color(0xFF1F1F1F),
    contentBorder: Color(0xFF334155),
    subtext: Color(0xFF64748B),
    cardBg: Color(0xFF1F1F1F),
    errorRed: Color(0xFFFF453A),
  );

  //Dark ColorScheme
  static ColorScheme darkScheme() {
    return ColorScheme.fromSeed(
      seedColor: const Color(0xFF135BEC),
      brightness: Brightness.dark,
      error: const Color(0xFFCF6679),
      onError: const Color(0xFF1E1213),
      errorContainer: const Color(0xFF8E001A),
      onErrorContainer: const Color(0xFFFFDAD6),
    );
  }

  ThemeData dark() {
    return theme(darkScheme(), darkThemeColors());
  }

  ThemeData theme(ColorScheme colorScheme, AppColors appColors) => ThemeData(
    //Material 3 style
    useMaterial3: true,

    // Theme mode
    brightness: colorScheme.brightness,

    //Color scheme -set of all colors
    colorScheme: colorScheme,

    //Theme extensions
    extensions: <ThemeExtension<dynamic>>[appColors],

    //Default font family
    // fontFamily: FontFamily.inter,

    //Text theme for configure typography of app
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: appColors.primary,
    ),

    //Scffold background color of the app
    scaffoldBackgroundColor: appColors.surfaceColor,

    //Canvas color
    canvasColor: colorScheme.surfaceContainer,

    //Bottom navigation bar theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: appColors.surfaceColor,
      selectedItemColor: appColors.primary,
      unselectedItemColor: appColors.onSurface?.withOpacity(0.5),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
    ),

    //Button theme
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
    ),

    //Appbar theme
    appBarTheme: AppBarTheme(
      scrolledUnderElevation: 0,
      backgroundColor: appColors.appBarColor,
      iconTheme: IconThemeData(color: appColors.onSurface),
    ),
  );
}
