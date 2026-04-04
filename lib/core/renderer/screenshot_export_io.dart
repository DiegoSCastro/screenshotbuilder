import 'dart:io';

Future<void> ensureOutputDir(String outputDir) async {
  final dir = Directory(outputDir);
  if (!await dir.exists()) {
    await dir.create(recursive: true);
  }
}

Future<void> writePngBytes(String filePath, List<int> bytes) async {
  await File(filePath).writeAsBytes(bytes);
}
