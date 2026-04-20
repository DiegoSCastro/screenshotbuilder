import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../common/widgets/device_frame.dart';
import '../models/background_config.dart';
import '../models/screenshot_font_family.dart';
import '../models/template_model.dart';
import '../models/text_vertical_placement.dart';
import 'base_template.dart';

/// Side-by-side layout: text on the left, image on the right
class Template3 extends BaseTemplate {
  @override
  TemplateModel get model => const TemplateModel(
        id: 'template_3',
        name: 'Side Layout',
        maxTexts: 3,
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
    final footerText = texts.length > 2 ? texts[2] : '';

    final textFlex = ((1 - imageSizeRatio) * 100).round().clamp(20, 60);
    final imageFlex = (imageSizeRatio * 100).round().clamp(40, 80);
    final radius = isTablet ? size.width * 0.02 : size.width * 0.04;
    final cropBottom = isTablet ? 1.0 / 3.0 : 0.0;
    final textFirst =
        textVerticalPlacement == TextVerticalPlacement.aboveImage;

    final textPane = Expanded(
      flex: textFlex,
      child: Padding(
        padding: textFirst
            ? EdgeInsets.only(
                left: size.width * 0.06,
                top: size.height * 0.12,
                bottom: size.height * 0.12,
              )
            : EdgeInsets.only(
                right: size.width * 0.06,
                top: size.height * 0.12,
                bottom: size.height * 0.12,
              ),
        child: Column(
          crossAxisAlignment:
              textFirst ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (titleText.isNotEmpty)
              Text(
                titleText,
                textAlign: textFirst ? TextAlign.start : TextAlign.end,
                style: screenshotFont.textStyle(
                  fontSize: size.height * 0.038 * textScale,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                  height: 1.2,
                ),
              ),
            if (subtitleText.isNotEmpty) ...[
              SizedBox(height: size.height * 0.02),
              Text(
                subtitleText,
                textAlign: textFirst ? TextAlign.start : TextAlign.end,
                style: screenshotFont.textStyle(
                  fontSize: size.height * 0.02 * textScale,
                  fontWeight: FontWeight.w400,
                  color: textColor.withValues(alpha: 0.8),
                  height: 1.4,
                ),
              ),
            ],
            if (footerText.isNotEmpty) ...[
              SizedBox(height: size.height * 0.03),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.03,
                  vertical: size.height * 0.01,
                ),
                decoration: BoxDecoration(
                  color: textColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(size.width * 0.02),
                ),
                child: Text(
                  footerText,
                  textAlign: textFirst ? TextAlign.start : TextAlign.end,
                  style: screenshotFont.textStyle(
                    fontSize: size.height * 0.016 * textScale,
                    fontWeight: FontWeight.w500,
                    color: textColor.withValues(alpha: 0.9),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );

    final imagePane = Expanded(
      flex: imageFlex,
      child: Padding(
        padding: textFirst
            ? EdgeInsets.only(
                top: size.height * 0.06,
                bottom: size.height * 0.06,
                right: size.width * 0.05,
                left: size.width * 0.02,
              )
            : EdgeInsets.only(
                top: size.height * 0.06,
                bottom: size.height * 0.06,
                left: size.width * 0.05,
                right: size.width * 0.02,
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
      child: Row(
        children: textFirst
            ? [textPane, imagePane]
            : [imagePane, textPane],
      ),
    );
  }
}
