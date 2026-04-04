// ignore: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:html' as html;

Future<void> ensureOutputDir(String outputDir) async {}

Future<void> writePngBytes(String filePath, List<int> bytes) async {
  final name = filePath.contains('/')
      ? filePath.split('/').last
      : filePath.split(r'\').last;
  final blob = html.Blob([bytes]);
  final url = html.Url.createObjectUrlFromBlob(blob);
  html.AnchorElement(href: url)
    ..setAttribute('download', name.isEmpty ? 'screenshot.png' : name)
    ..click();
  html.Url.revokeObjectUrl(url);
}
