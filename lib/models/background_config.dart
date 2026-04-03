import 'dart:ui';

class BackgroundConfig {
  final Color? solidColor;
  final List<Color>? gradientColors;

  const BackgroundConfig({
    this.solidColor,
    this.gradientColors,
  });

  bool get isGradient => gradientColors != null && gradientColors!.length >= 2;
  bool get isSolid => solidColor != null;

  BackgroundConfig copyWith({
    Color? solidColor,
    List<Color>? gradientColors,
    bool clearSolid = false,
    bool clearGradient = false,
  }) {
    return BackgroundConfig(
      solidColor: clearSolid ? null : (solidColor ?? this.solidColor),
      gradientColors:
          clearGradient ? null : (gradientColors ?? this.gradientColors),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BackgroundConfig &&
          runtimeType == other.runtimeType &&
          solidColor == other.solidColor &&
          _listEquals(gradientColors, other.gradientColors);

  @override
  int get hashCode => Object.hash(solidColor, gradientColors);

  static bool _listEquals(List<Color>? a, List<Color>? b) {
    if (a == null && b == null) return true;
    if (a == null || b == null) return false;
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
