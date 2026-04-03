import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../common/widgets/device_frame.dart';
import '../../models/background_config.dart';
import '../../models/export_config.dart';
import '../../templates/base_template.dart';

class ScreenshotRenderer {
  Future<List<String>> renderAll({
    required BuildContext context,
    required BaseTemplate template,
    required List<String> images,
    required Map<String, List<String>> textsPerImage,
    required int maxTexts,
    required BackgroundConfig background,
    required List<ExportSize> sizes,
    required String outputDir,
    double textScale = 1.0,
    DeviceFrameStyle deviceFrame = DeviceFrameStyle.none,
    double imageSizeRatio = 0.8,
    Color textColor = Colors.white,
    void Function(int current, int total)? onProgress,
  }) async {
    final savedPaths = <String>[];
    final total = sizes.length * images.length;
    int current = 0;

    final overlay = Overlay.of(context);

    final dir = Directory(outputDir);
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    for (final size in sizes) {
      // Tablet sizes crop from top to fit the wider aspect ratio
      final imageAlignment =
          size.isTablet ? Alignment.topCenter : Alignment.center;

      for (int i = 0; i < images.length; i++) {
        final imagePath = images[i];
        final texts = _textsForImage(imagePath, textsPerImage, maxTexts);

        final bytes = await _renderOffscreen(
          overlay: overlay,
          template: template,
          imagePath: imagePath,
          texts: texts,
          background: background,
          targetSize: Size(size.width, size.height),
          textScale: textScale,
          deviceFrame: deviceFrame,
          imageSizeRatio: imageSizeRatio,
          textColor: textColor,
          imageAlignment: imageAlignment,
        );

        final fileName = '${size.name}_screenshot_$i.png';
        final filePath = '$outputDir/$fileName';
        await File(filePath).writeAsBytes(bytes);
        savedPaths.add(filePath);

        current++;
        onProgress?.call(current, total);
      }
    }

    return savedPaths;
  }

  List<String> _textsForImage(
    String imagePath,
    Map<String, List<String>> textsPerImage,
    int maxTexts,
  ) {
    final texts = textsPerImage[imagePath];
    if (texts == null) return List.filled(maxTexts, '');
    if (texts.length < maxTexts) {
      return [...texts, ...List.filled(maxTexts - texts.length, '')];
    }
    return texts;
  }

  Future<List<int>> _renderOffscreen({
    required OverlayState overlay,
    required BaseTemplate template,
    required String imagePath,
    required List<String> texts,
    required BackgroundConfig background,
    required Size targetSize,
    required double textScale,
    required DeviceFrameStyle deviceFrame,
    required double imageSizeRatio,
    required Color textColor,
    required Alignment imageAlignment,
  }) async {
    const double maxLogicalSize = 800.0;
    final double scale;
    if (targetSize.width > maxLogicalSize ||
        targetSize.height > maxLogicalSize) {
      scale = targetSize.longestSide / maxLogicalSize;
    } else {
      scale = 1.0;
    }

    final logicalSize = Size(
      targetSize.width / scale,
      targetSize.height / scale,
    );

    final key = GlobalKey();

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) => Positioned(
        left: -99999,
        top: -99999,
        child: RepaintBoundary(
          key: key,
          child: SizedBox(
            width: logicalSize.width,
            height: logicalSize.height,
            child: MediaQuery(
              data: MediaQueryData(size: logicalSize),
              child: template.build(
                size: logicalSize,
                texts: texts,
                imagePath: imagePath,
                background: background,
                textScale: textScale,
                deviceFrame: deviceFrame,
                imageSizeRatio: imageSizeRatio,
                textColor: textColor,
                imageAlignment: imageAlignment,
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(entry);

    await Future.delayed(const Duration(milliseconds: 300));
    await _waitForFrame();
    await Future.delayed(const Duration(milliseconds: 200));

    try {
      final boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: scale);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData!.buffer.asUint8List();
    } finally {
      entry.remove();
    }
  }

  Future<void> _waitForFrame() {
    return Future(() {
      return WidgetsBinding.instance.endOfFrame;
    });
  }
}
