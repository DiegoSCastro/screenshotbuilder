import 'package:flutter/material.dart';

Widget platformFileImage(
  String path, {
  required BoxFit fit,
  required Alignment alignment,
  ImageErrorWidgetBuilder? errorBuilder,
}) {
  return Builder(
    builder: (context) {
      final builder = errorBuilder;
      if (builder != null) {
        return builder(
          context,
          Exception('File image not available on this platform'),
          StackTrace.current,
        );
      }
      return const SizedBox();
    },
  );
}
