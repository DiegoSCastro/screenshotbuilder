import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'image_precache_stub.dart'
    if (dart.library.io) 'image_precache_io.dart' as precache;

class ImageUtils {
  static Future<void> precacheImages(
    BuildContext context,
    List<String> imagePaths, {
    Map<String, Uint8List> webImageBytes = const {},
  }) async {
    for (final path in imagePaths) {
      final bytes = webImageBytes[path];
      if (bytes != null) {
        if (context.mounted) {
          await precacheImage(MemoryImage(bytes), context);
        }
        continue;
      }
      await precache.precacheFileImage(context, path);
    }
  }

  static bool isValidImagePath(String path) {
    if (path.startsWith('web:')) return true;
    final ext = path.toLowerCase();
    return ext.endsWith('.png') ||
        ext.endsWith('.jpg') ||
        ext.endsWith('.jpeg') ||
        ext.endsWith('.webp') ||
        ext.endsWith('.gif') ||
        ext.endsWith('.bmp');
  }

  static bool isLikelyImageFileName(String name) {
    final lower = name.toLowerCase();
    return lower.endsWith('.png') ||
        lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg') ||
        lower.endsWith('.webp') ||
        lower.endsWith('.gif') ||
        lower.endsWith('.bmp');
  }

  static String getFileName(String path) {
    final i = path.lastIndexOf('/');
    final j = path.lastIndexOf(r'\');
    final k = i > j ? i : j;
    if (k >= 0) return path.substring(k + 1);
    return path;
  }

  static String displayNameFor(
    String key,
    Map<String, String> webImageDisplayNames,
  ) {
    return webImageDisplayNames[key] ?? getFileName(key);
  }
}
