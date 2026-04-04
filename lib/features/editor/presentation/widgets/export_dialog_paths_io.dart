import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String?> defaultExportDirectory() async {
  try {
    final downloads = await getDownloadsDirectory();
    if (downloads != null) {
      final outputDir =
          '${downloads.path}${Platform.pathSeparator}ScreenshotBuilder';
      await Directory(outputDir).create(recursive: true);
      return outputDir;
    }
  } catch (_) {}
  return null;
}
