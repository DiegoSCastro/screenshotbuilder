import 'dart:io';

import 'package:flutter/material.dart';

class ImageUtils {
  static Future<void> precacheImages(
    BuildContext context,
    List<String> imagePaths,
  ) async {
    for (final path in imagePaths) {
      final file = File(path);
      if (await file.exists()) {
        if (context.mounted) {
          await precacheImage(FileImage(file), context);
        }
      }
    }
  }

  static bool isValidImagePath(String path) {
    final ext = path.toLowerCase();
    return ext.endsWith('.png') ||
        ext.endsWith('.jpg') ||
        ext.endsWith('.jpeg') ||
        ext.endsWith('.webp') ||
        ext.endsWith('.gif') ||
        ext.endsWith('.bmp');
  }

  static String getFileName(String path) {
    return path.split(Platform.pathSeparator).last;
  }
}
