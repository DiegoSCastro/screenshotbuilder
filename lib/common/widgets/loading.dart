import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/extensions/theme_ext.dart';
import '../../core/theme/app_colors.dart';

class Loading extends StatelessWidget {
  ///Example:
  ///-------------------------
  ///```
  /// class HomeScreen extends StatelessWidget {
  ///   const HomeScreen({super.key});
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return Scaffold(
  ///       appBar: AppBar(
  ///         title: const Text("Home Screen"),
  ///       ),
  ///       body: const Loading(
  ///         isLoading: true // your loding contidtion here
  ///         child: MyUI(), //code for your screen UI,
  ///       ),
  ///     );
  ///   }
  /// }
  /// ```
  const Loading({super.key, required this.child, required this.isLoading});
  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    AppColors? appColors = context.appColors;
    if (!isLoading) {
      return child;
    }

    return Stack(
      children: [
        child,
        Container(
          color: appColors?.kBlack.withValues(alpha: 0.3),
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              height: 70,
              decoration: BoxDecoration(
                color: appColors?.surfaceColor,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Platform.isIOS
                      ? const CupertinoActivityIndicator(radius: 15)
                      : const CircularProgressIndicator(strokeWidth: 2),
                  const SizedBox(width: 15),
                  Text("Please Wait...", style: context.labelLarge()),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
