/// Vertical order of the text block relative to the screenshot image.
enum TextVerticalPlacement {
  /// Title and subtitles occupy the upper [Flexible] region; image below.
  aboveImage,

  /// Image on top; text block in the lower region.
  belowImage,
}

extension TextVerticalPlacementX on TextVerticalPlacement {
  String get labelEn => switch (this) {
        TextVerticalPlacement.aboveImage => 'Above image',
        TextVerticalPlacement.belowImage => 'Below image',
      };
}
