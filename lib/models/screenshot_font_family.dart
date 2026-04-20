import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Store-friendly rounded / geometric sans families for screenshot text.
enum ScreenshotFontFamily {
  nunito,
  quicksand,
  comfortaa,
  varelaRound,
  fredoka,
  rubik;

  String get displayName {
    switch (this) {
      case ScreenshotFontFamily.nunito:
        return 'Nunito';
      case ScreenshotFontFamily.quicksand:
        return 'Quicksand';
      case ScreenshotFontFamily.comfortaa:
        return 'Comfortaa';
      case ScreenshotFontFamily.varelaRound:
        return 'Varela Round';
      case ScreenshotFontFamily.fredoka:
        return 'Fredoka';
      case ScreenshotFontFamily.rubik:
        return 'Rubik';
    }
  }

  /// Short label for compact UI.
  String get shortLabel {
    switch (this) {
      case ScreenshotFontFamily.nunito:
        return 'Nunito';
      case ScreenshotFontFamily.quicksand:
        return 'Quicksand';
      case ScreenshotFontFamily.comfortaa:
        return 'Comfortaa';
      case ScreenshotFontFamily.varelaRound:
        return 'Varela';
      case ScreenshotFontFamily.fredoka:
        return 'Fredoka';
      case ScreenshotFontFamily.rubik:
        return 'Rubik';
    }
  }

  TextStyle textStyle({
    required double fontSize,
    FontWeight? fontWeight,
    required Color color,
    double? height,
    TextDecoration decoration = TextDecoration.none,
  }) {
    final w = fontWeight ?? FontWeight.w400;
    switch (this) {
      case ScreenshotFontFamily.nunito:
        return GoogleFonts.nunito(
          fontSize: fontSize,
          fontWeight: w,
          color: color,
          height: height,
          decoration: decoration,
        );
      case ScreenshotFontFamily.quicksand:
        return GoogleFonts.quicksand(
          fontSize: fontSize,
          fontWeight: w,
          color: color,
          height: height,
          decoration: decoration,
        );
      case ScreenshotFontFamily.comfortaa:
        return GoogleFonts.comfortaa(
          fontSize: fontSize,
          fontWeight: w,
          color: color,
          height: height,
          decoration: decoration,
        );
      case ScreenshotFontFamily.varelaRound:
        return GoogleFonts.varelaRound(
          fontSize: fontSize,
          fontWeight: w,
          color: color,
          height: height,
          decoration: decoration,
        );
      case ScreenshotFontFamily.fredoka:
        return GoogleFonts.fredoka(
          fontSize: fontSize,
          fontWeight: w,
          color: color,
          height: height,
          decoration: decoration,
        );
      case ScreenshotFontFamily.rubik:
        return GoogleFonts.rubik(
          fontSize: fontSize,
          fontWeight: w,
          color: color,
          height: height,
          decoration: decoration,
        );
    }
  }
}
