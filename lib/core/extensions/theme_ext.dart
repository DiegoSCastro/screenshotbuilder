import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// [TextThemeExt] - A custom extension on `BuildContext` to access
/// TextStyle easily with build context
extension TextThemeExt on BuildContext {
  TextTheme textTheme() => Theme.of(this).textTheme;

  TextStyle displayLarge(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .displayLarge!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle displayMedium(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .displayMedium!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle displaySmall(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .displaySmall!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle headlineLarge(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .headlineLarge!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle headlineMedium(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .headlineMedium!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle headlineSmall(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .headlineSmall!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle titleLarge(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .titleLarge!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle titleMedium(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .titleMedium!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle titleSmall(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .titleSmall!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle bodyLarge(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .bodyLarge!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle bodyMedium(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .bodyMedium!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle bodySmall(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .bodySmall!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle labelSmall(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .labelSmall!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle labelMedium(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .labelMedium!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);

  TextStyle labelLarge(
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Theme.of(this)
          .textTheme
          .labelLarge!
          .copyWith(color: color, fontSize: fontSize, fontWeight: fontWeight);
}


extension ThemeContext on BuildContext {
  ThemeData get theme => Theme.of(this);
  bool get isDarkTheme => Theme.of(this).brightness == Brightness.dark;
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;

  ///
  ///[setThemeBasedColor] accepts two colors as parameters [darkThemeColor]
  ///and [lightThemeColor], if current app theme is Dark then [darkThemeColor]
  ///will return else [lightThemeColor] will return.
  ///```
  /// //Example
  /// ----------
  /// Container(
  ///   height:100,
  ///   width:100,
  ///   color:context.setThemeBasedColor(
  ///     darkThemeColor:Colors.white,
  ///     lightThemeColor:Colors.black,
  ///    ),
  ///   ),
  ///  // The color of container will be black if theme is Dark else white.
  /// ```
  Color? setThemeBasedColor(
      {required Color? darkThemeColor, required Color? lightThemeColor}) {
    bool isDarkTheme = Theme.of(this).brightness == Brightness.dark;
    if (isDarkTheme) {
      return darkThemeColor;
    } else {
      return lightThemeColor;
    }
  }

  AppColors? get appColors => Theme.of(this).extension<AppColors>();
}


