import 'package:flutter/material.dart';

enum DeviceFrameStyle {
  none,
  iPhone,
  android;

  String get displayName {
    switch (this) {
      case DeviceFrameStyle.none:
        return 'None';
      case DeviceFrameStyle.iPhone:
        return 'iPhone';
      case DeviceFrameStyle.android:
        return 'Android';
    }
  }
}

class DeviceFrame extends StatelessWidget {
  final Widget child;
  final DeviceFrameStyle style;
  final Color frameColor;

  const DeviceFrame({
    super.key,
    required this.child,
    this.style = DeviceFrameStyle.none,
    this.frameColor = const Color(0xFF1C1C1E),
  });

  @override
  Widget build(BuildContext context) {
    if (style == DeviceFrameStyle.none) return child;

    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;

        final bool isIPhone = style == DeviceFrameStyle.iPhone;
        final bezel = isIPhone ? w * 0.025 : w * 0.018;
        final outerRadius = isIPhone ? w * 0.12 : w * 0.07;
        final innerRadius = isIPhone ? w * 0.095 : w * 0.055;
        final buttonWidth = w * 0.008;
        final buttonColor = const Color(0xFF2C2C2E);
        final buttonBorderColor = const Color(0xFF48484A);

        final deviceBody = Container(
          decoration: BoxDecoration(
            color: frameColor,
            borderRadius: BorderRadius.circular(outerRadius),
            border: Border.all(
              color: buttonBorderColor,
              width: isIPhone ? 0.8 : 0.6,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: h * 0.025,
                offset: Offset(0, h * 0.008),
              ),
              BoxShadow(
                color: buttonBorderColor.withValues(alpha: 0.15),
                blurRadius: 1,
                spreadRadius: 0.5,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(bezel),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(innerRadius),
              child: child,
            ),
          ),
        );

        final buttons = isIPhone
            ? _buildIPhoneButtons(h, buttonWidth, buttonColor, buttonBorderColor)
            : _buildAndroidButtons(h, buttonWidth, buttonColor, buttonBorderColor);

        return Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: buttonWidth),
              child: deviceBody,
            ),
            ...buttons,
          ],
        );
      },
    );
  }

  List<Widget> _buildIPhoneButtons(
    double h,
    double buttonWidth,
    Color buttonColor,
    Color borderColor,
  ) {
    final buttonRadius = BorderRadius.circular(buttonWidth);

    return [
      // Power button (right side)
      Positioned(
        right: 0,
        top: h * 0.22,
        child: Container(
          width: buttonWidth,
          height: h * 0.09,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: buttonRadius,
            border: Border.all(color: borderColor, width: 0.3),
          ),
        ),
      ),
      // Action button (left side, top)
      Positioned(
        left: 0,
        top: h * 0.15,
        child: Container(
          width: buttonWidth,
          height: h * 0.03,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: buttonRadius,
            border: Border.all(color: borderColor, width: 0.3),
          ),
        ),
      ),
      // Volume Up (left side)
      Positioned(
        left: 0,
        top: h * 0.22,
        child: Container(
          width: buttonWidth,
          height: h * 0.07,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: buttonRadius,
            border: Border.all(color: borderColor, width: 0.3),
          ),
        ),
      ),
      // Volume Down (left side)
      Positioned(
        left: 0,
        top: h * 0.31,
        child: Container(
          width: buttonWidth,
          height: h * 0.07,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: buttonRadius,
            border: Border.all(color: borderColor, width: 0.3),
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildAndroidButtons(
    double h,
    double buttonWidth,
    Color buttonColor,
    Color borderColor,
  ) {
    final buttonRadius = BorderRadius.circular(buttonWidth);

    return [
      // Power button (right side)
      Positioned(
        right: 0,
        top: h * 0.22,
        child: Container(
          width: buttonWidth,
          height: h * 0.07,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: buttonRadius,
            border: Border.all(color: borderColor, width: 0.3),
          ),
        ),
      ),
      // Volume Up (right side)
      Positioned(
        right: 0,
        top: h * 0.32,
        child: Container(
          width: buttonWidth,
          height: h * 0.08,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: buttonRadius,
            border: Border.all(color: borderColor, width: 0.3),
          ),
        ),
      ),
      // Volume Down (right side)
      Positioned(
        right: 0,
        top: h * 0.42,
        child: Container(
          width: buttonWidth,
          height: h * 0.08,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: buttonRadius,
            border: Border.all(color: borderColor, width: 0.3),
          ),
        ),
      ),
    ];
  }
}
