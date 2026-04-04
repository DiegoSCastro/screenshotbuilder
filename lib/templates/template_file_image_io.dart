import 'dart:io';

import 'package:flutter/material.dart';

Widget platformFileImage(
  String path, {
  required BoxFit fit,
  required Alignment alignment,
  ImageErrorWidgetBuilder? errorBuilder,
}) {
  return Image.file(
    File(path),
    fit: fit,
    alignment: alignment,
    errorBuilder: errorBuilder,
  );
}
