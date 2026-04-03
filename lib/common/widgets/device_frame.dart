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
        return switch (style) {
          DeviceFrameStyle.iPhone =>
            _IPhoneFrame(frameColor: frameColor, child: child),
          DeviceFrameStyle.android =>
            _AndroidFrame(frameColor: frameColor, child: child),
          DeviceFrameStyle.none => child,
        };
      },
    );
  }
}

class _IPhoneFrame extends StatelessWidget {
  final Widget child;
  final Color frameColor;

  const _IPhoneFrame({required this.child, required this.frameColor});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;
        final bezel = w * 0.028;
        final outerRadius = w * 0.12;
        final innerRadius = w * 0.095;

        return Container(
          decoration: BoxDecoration(
            color: frameColor,
            borderRadius: BorderRadius.circular(outerRadius),
            border: Border.all(
              color: const Color(0xFF48484A),
              width: 0.8,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: h * 0.025,
                offset: Offset(0, h * 0.008),
              ),
              BoxShadow(
                color: const Color(0xFF48484A).withValues(alpha: 0.15),
                blurRadius: 1,
                spreadRadius: 0.5,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(bezel, 0, bezel, 0),
            child: Column(
              children: [
                // Dynamic Island area
                SizedBox(
                  height: h * 0.04,
                  child: Center(
                    child: Container(
                      width: w * 0.28,
                      height: h * 0.016,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                ),
                // Screen
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(innerRadius),
                    child: child,
                  ),
                ),
                // Home indicator area
                SizedBox(
                  height: h * 0.028,
                  child: Center(
                    child: Container(
                      width: w * 0.32,
                      height: 3.5,
                      margin: EdgeInsets.only(top: h * 0.006),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.22),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AndroidFrame extends StatelessWidget {
  final Widget child;
  final Color frameColor;

  const _AndroidFrame({required this.child, required this.frameColor});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;
        final bezel = w * 0.02;
        final outerRadius = w * 0.08;
        final innerRadius = w * 0.06;

        return Container(
          decoration: BoxDecoration(
            color: frameColor,
            borderRadius: BorderRadius.circular(outerRadius),
            border: Border.all(
              color: const Color(0xFF48484A),
              width: 0.6,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: h * 0.02,
                offset: Offset(0, h * 0.006),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(bezel, 0, bezel, 0),
            child: Column(
              children: [
                // Camera punch-hole area
                SizedBox(
                  height: h * 0.03,
                  child: Center(
                    child: Container(
                      width: w * 0.03,
                      height: w * 0.03,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2C2C2E),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF3A3A3C),
                          width: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
                // Screen
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(innerRadius),
                    child: child,
                  ),
                ),
                // Bottom bar area
                SizedBox(
                  height: h * 0.02,
                  child: Center(
                    child: Container(
                      width: w * 0.28,
                      height: 2.5,
                      margin: EdgeInsets.only(top: h * 0.005),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
