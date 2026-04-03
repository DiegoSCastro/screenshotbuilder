import 'package:flutter/material.dart';

abstract class AppTextStyles {
  static TextTheme getTextTheme() {

    //Base text style 
    TextStyle baseTextStyle = const TextStyle(
      decoration: TextDecoration.none,
    );
    return TextTheme(
      //Display
      displayLarge: baseTextStyle.copyWith(
        fontSize: 57,
      ),
      displayMedium: baseTextStyle.copyWith(
        fontSize: 45,
      ),
      displaySmall: baseTextStyle.copyWith(
        fontSize: 36,
      ),

      //Headline
      headlineLarge: baseTextStyle.copyWith(
        fontSize: 32,
      ),
      headlineMedium: baseTextStyle.copyWith(
        fontSize: 28,
      ),
      headlineSmall: baseTextStyle.copyWith(
        fontSize: 24,
      ),

      //Title
      titleLarge: baseTextStyle.copyWith(
        fontSize: 22,
      ),
      titleMedium: baseTextStyle.copyWith(
        fontSize: 16,
      ),
      titleSmall: baseTextStyle.copyWith(
        fontSize: 14,
      ),

      //Label
      labelLarge: baseTextStyle.copyWith(
        fontSize: 14,
      ),
      labelMedium: baseTextStyle.copyWith(
        fontSize: 12,
      ),
      labelSmall: baseTextStyle.copyWith(
        fontSize: 11,
      ),

      //Body
      bodyLarge: baseTextStyle.copyWith(
        fontSize: 16,
      ),
      bodyMedium: baseTextStyle.copyWith(
        fontSize: 14,
      ),
      bodySmall: baseTextStyle.copyWith(
        fontSize: 12,
      ),
    );
  }
}

