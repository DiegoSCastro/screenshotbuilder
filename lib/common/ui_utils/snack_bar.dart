import 'package:flutter/material.dart';
import '../../core/extensions/theme_ext.dart';

class AppSnackBar {
  static void showSnackBar(
    BuildContext context, {
    required String message,
    bool isError = false,
    Duration duration = const Duration(seconds: 3),
  }) {
    final appColors = context.appColors;

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: context.bodyMedium(color: appColors?.kWhite ?? Colors.white),
        ),
        backgroundColor: isError
            ? (appColors?.errorRed ?? Colors.red)
            : Colors.green,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
