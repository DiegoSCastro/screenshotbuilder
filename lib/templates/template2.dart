import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../common/widgets/device_frame.dart';
import '../models/background_config.dart';
import '../models/screenshot_font_family.dart';
import '../models/template_model.dart';
import '../models/text_vertical_placement.dart';
import 'base_template.dart';

/// Large centered text on top, image below
class Template2 extends BaseTemplate {
  @override
  TemplateModel get model => const TemplateModel(
        id: 'template_2',
        name: 'Bold Center Text',
        maxTexts: 2,
      );

  @override
  Widget build({
    required Size size,
    required List<String> texts,
    required String? imagePath,
    Uint8List? imageBytes,
    required BackgroundConfig background,
    double textScale = 1.0,
    DeviceFrameStyle deviceFrame = DeviceFrameStyle.none,
    double imageSizeRatio = 0.8,
    Color textColor = Colors.white,
    ScreenshotFontFamily screenshotFont = ScreenshotFontFamily.nunito,
    bool isTablet = false,
    TextVerticalPlacement textVerticalPlacement =
        TextVerticalPlacement.aboveImage,
  }) {
    final titleText = texts.isNotEmpty ? texts[0] : '';
    final subtitleText = texts.length > 1 ? texts[1] : '';

    final textAreaFlex = ((1 - imageSizeRatio) * 100).round();
    final imageFlex = (imageSizeRatio * 100).round();
    final radius = isTablet ? size.width * 0.02 : size.width * 0.04;
    final cropBottom = isTablet ? 1.0 / 3.0 : 0.0;
    final textFirst =
        textVerticalPlacement == TextVerticalPlacement.aboveImage;

    final textBlock = Flexible(
      flex: textAreaFlex,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (titleText.isNotEmpty)
              Text(
                titleText,
                textAlign: TextAlign.center,
                style: screenshotFont.textStyle(
                  fontSize: size.height * 0.055 * textScale,
                  fontWeight: FontWeight.w800,
                  color: textColor,
                  height: 1.1,
                ),
              ),
            if (subtitleText.isNotEmpty) ...[
              SizedBox(height: size.height * 0.015),
              Text(
                subtitleText,
                textAlign: TextAlign.center,
                style: screenshotFont.textStyle(
                  fontSize: size.height * 0.022 * textScale,
                  fontWeight: FontWeight.w400,
                  color: textColor.withValues(alpha: 0.8),
                  height: 1.3,
                ),
              ),
            ],
          ],
        ),
      ),
    );

    final imageBlock = Flexible(
      flex: imageFlex,
      child: Padding(
        padding: EdgeInsets.only(
          left: size.width * 0.08,
          right: size.width * 0.08,
          top: textFirst ? 0 : size.height * 0.03,
          bottom: textFirst ? size.height * 0.03 : 0,
        ),
        child: buildImageWidget(
          imagePath,
          imageBytes: imageBytes,
          deviceFrame: deviceFrame,
          cropBottomFraction: cropBottom,
          borderRadius: radius,
        ),
      ),
    );

    return Container(
      width: size.width,
      height: size.height,
      decoration: buildBackgroundDecoration(background),
      child: Column(
        children: [
          if (textFirst) textBlock else imageBlock,
          if (textFirst) imageBlock else textBlock,
        ],
      ),
    );
  }
}
