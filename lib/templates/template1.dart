import 'package:flutter/material.dart';

import '../common/widgets/device_frame.dart';
import '../models/background_config.dart';
import '../models/template_model.dart';
import 'base_template.dart';

/// Text on top, centered image, gradient background
class Template1 extends BaseTemplate {
  @override
  TemplateModel get model => const TemplateModel(
        id: 'template_1',
        name: 'Classic Top Text',
        maxTexts: 3,
      );

  @override
  Widget build({
    required Size size,
    required List<String> texts,
    required String? imagePath,
    required BackgroundConfig background,
    double textScale = 1.0,
    DeviceFrameStyle deviceFrame = DeviceFrameStyle.none,
    double imageSizeRatio = 0.8,
    Color textColor = Colors.white,
    bool isTablet = false,
  }) {
    final titleText = texts.isNotEmpty ? texts[0] : '';
    final subtitleText = texts.length > 1 ? texts[1] : '';
    final footerText = texts.length > 2 ? texts[2] : '';

    final textAreaFlex = ((1 - imageSizeRatio) * 100).round();
    final imageFlex = (imageSizeRatio * 100).round();
    final radius = isTablet ? size.width * 0.02 : size.width * 0.04;
    final cropBottom = isTablet ? 1.0 / 3.0 : 0.0;

    return Container(
      width: size.width,
      height: size.height,
      decoration: buildBackgroundDecoration(background),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
        child: Column(
          children: [
            Flexible(
              flex: textAreaFlex,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (titleText.isNotEmpty)
                    Text(
                      titleText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: size.height * 0.04 * textScale,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                        height: 1.2,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  if (subtitleText.isNotEmpty) ...[
                    SizedBox(height: size.height * 0.012),
                    Text(
                      subtitleText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: size.height * 0.022 * textScale,
                        fontWeight: FontWeight.w400,
                        color: textColor.withValues(alpha: 0.85),
                        height: 1.3,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Flexible(
              flex: imageFlex,
              child: Padding(
                padding: EdgeInsets.only(
                  left: size.width * 0.04,
                  right: size.width * 0.04,
                  bottom: footerText.isNotEmpty ? 0 : size.height * 0.03,
                ),
                child: buildImageWidget(
                  imagePath,
                  deviceFrame: deviceFrame,
                  cropBottomFraction: cropBottom,
                  borderRadius: radius,
                ),
              ),
            ),
            if (footerText.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.01,
                  bottom: size.height * 0.03,
                ),
                child: Text(
                  footerText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: size.height * 0.018 * textScale,
                    fontWeight: FontWeight.w300,
                    color: textColor.withValues(alpha: 0.7),
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
