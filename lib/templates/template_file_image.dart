import 'package:flutter/material.dart';

import 'template_file_image_stub.dart'
    if (dart.library.io) 'template_file_image_io.dart' as impl;

Widget platformFileImage(
  String path, {
  required BoxFit fit,
  required Alignment alignment,
  ImageErrorWidgetBuilder? errorBuilder,
}) {
  return impl.platformFileImage(
    path,
    fit: fit,
    alignment: alignment,
    errorBuilder: errorBuilder,
  );
}
