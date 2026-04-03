import 'dart:io';

import 'package:flutter/material.dart';

import '../common/widgets/device_frame.dart';
import '../models/background_config.dart';
import '../models/template_model.dart';

abstract class BaseTemplate {
  TemplateModel get model;

  Widget build({
    required Size size,
    required List<String> texts,
    required String? imagePath,
    required BackgroundConfig background,
    double textScale = 1.0,
    DeviceFrameStyle deviceFrame = DeviceFrameStyle.none,
    double imageSizeRatio = 0.8,
    Color textColor = Colors.white,
    Alignment imageAlignment = Alignment.center,
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
    BoxFit fit = BoxFit.contain,
    DeviceFrameStyle deviceFrame = DeviceFrameStyle.none,
    Alignment alignment = Alignment.center,
  }) {
    Widget image;
    if (imagePath == null || imagePath.isEmpty) {
      image = Container(
        color: Colors.black12,
        child: const Center(
          child: Icon(Icons.image_outlined, size: 48, color: Colors.white38),
        ),
      );
    } else {
      image = Image.file(
        File(imagePath),
        fit: deviceFrame != DeviceFrameStyle.none ? BoxFit.cover : fit,
        alignment: alignment,
        errorBuilder: (_, _, _) => Container(
          color: Colors.black12,
          child: const Center(
            child:
                Icon(Icons.broken_image, size: 48, color: Colors.white38),
          ),
        ),
      );
    }

    if (deviceFrame != DeviceFrameStyle.none) {
      return DeviceFrame(style: deviceFrame, child: image);
    }

    return image;
  }
}
