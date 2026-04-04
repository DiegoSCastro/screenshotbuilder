import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../common/widgets/device_frame.dart';
import '../models/background_config.dart';
import '../models/template_model.dart';
import 'template_file_image.dart';

abstract class BaseTemplate {
  TemplateModel get model;

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
    bool isTablet = false,
  });

  Decoration buildBackgroundDecoration(BackgroundConfig background) {
    if (background.isGradient) {
      return BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: background.gradientColors!,
        ),
      );
    }
    return BoxDecoration(
      color: background.solidColor ?? const Color(0xFF1a1a2e),
    );
  }

  Widget buildImageWidget(
    String? imagePath, {
    Uint8List? imageBytes,
    BoxFit fit = BoxFit.contain,
    DeviceFrameStyle deviceFrame = DeviceFrameStyle.none,
    double cropBottomFraction = 0.0,
    double borderRadius = 0.0,
  }) {
    final hasRaster =
        imageBytes != null ||
        (imagePath != null && imagePath.isNotEmpty);

    Widget image;
    if (!hasRaster) {
      image = Container(
        color: Colors.black12,
        child: const Center(
          child: Icon(Icons.image_outlined, size: 48, color: Colors.white38),
        ),
      );
    } else {
      final useCover =
          deviceFrame != DeviceFrameStyle.none || cropBottomFraction > 0;
      final effectiveFit = useCover ? BoxFit.cover : fit;
      if (imageBytes != null) {
        image = Image.memory(
          imageBytes,
          fit: effectiveFit,
          alignment: Alignment.topCenter,
          errorBuilder: (_, _, _) => Container(
            color: Colors.black12,
            child: const Center(
              child:
                  Icon(Icons.broken_image, size: 48, color: Colors.white38),
            ),
          ),
        );
      } else {
        image = platformFileImage(
          imagePath!,
          fit: effectiveFit,
          alignment: Alignment.topCenter,
          errorBuilder: (_, _, _) => Container(
            color: Colors.black12,
            child: const Center(
              child:
                  Icon(Icons.broken_image, size: 48, color: Colors.white38),
            ),
          ),
        );
      }
    }

    if (cropBottomFraction > 0 && hasRaster) {
      final originalImage = image;
      image = LayoutBuilder(
        builder: (context, constraints) {
          if (!constraints.hasBoundedHeight) {
            if (borderRadius > 0) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: originalImage,
              );
            }
            return originalImage;
          }
          final expandedHeight =
              constraints.maxHeight / (1 - cropBottomFraction);
          Widget content = SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: ClipRect(
              child: OverflowBox(
                alignment: Alignment.topCenter,
                maxWidth: constraints.maxWidth,
                maxHeight: expandedHeight,
                child: originalImage,
              ),
            ),
          );
          if (borderRadius > 0) {
            content = ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: content,
            );
          }
          return content;
        },
      );
    } else if (borderRadius > 0) {
      image = ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: image,
      );
    }

    if (deviceFrame != DeviceFrameStyle.none) {
      return DeviceFrame(style: deviceFrame, child: image);
    }

    return image;
  }
}
