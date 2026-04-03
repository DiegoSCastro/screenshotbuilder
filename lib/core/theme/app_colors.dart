import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  //TODO: Add branding based theme colors
  final Color? primary;
  final Color? secondary;

  //Utility colors
  final Color? surfaceColor;
  final Color? onSurface;
  final Color? appBarColor;
  final Color? contentBorder;
  final Color? subtext;
  final Color? cardBg;
  final Color? errorRed;

  //constant colors
  final Color kBlack;
  final Color kWhite;

  const AppColors({
    required this.primary,
    required this.secondary,
    required this.surfaceColor,
    required this.onSurface,
    required this.appBarColor,
    required this.contentBorder,
    required this.subtext,
    this.cardBg,
    this.errorRed,
    this.kBlack = Colors.black,
    this.kWhite = Colors.white,
  });

  @override
  AppColors copyWith({
    Color? primary,
    Color? secondary,
    Color? surfaceColor,
    Color? onSurface,
    Color? appBarColor,
    Color? contentBorder,
    Color? subtext,
    Color? cardBg,
    Color? errorRed,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      onSurface: onSurface ?? this.onSurface,
      appBarColor: appBarColor ?? this.appBarColor,
      contentBorder: contentBorder ?? this.contentBorder,
      subtext: subtext ?? this.subtext,
      cardBg: cardBg ?? this.cardBg,
      errorRed: errorRed ?? this.errorRed,
    );
  }

  @override
  AppColors lerp(covariant ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      primary: Color.lerp(primary, other.primary, t),
      secondary: Color.lerp(secondary, other.secondary, t),
      surfaceColor: Color.lerp(surfaceColor, other.surfaceColor, t),
      onSurface: Color.lerp(onSurface, other.onSurface, t),
      appBarColor: Color.lerp(appBarColor, other.appBarColor, t),
      contentBorder: Color.lerp(contentBorder, other.contentBorder, t),
      subtext: Color.lerp(subtext, other.subtext, t),
      cardBg: Color.lerp(cardBg, other.cardBg, t),
      errorRed: Color.lerp(errorRed, other.errorRed, t),
    );
  }
}
