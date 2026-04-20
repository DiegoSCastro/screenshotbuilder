part of 'editor_bloc.dart';

@freezed
sealed class EditorState with _$EditorState {
  const EditorState._();

  const factory EditorState({
    @Default(StoreType.appStore) StoreType storeType,
    @Default(0) int selectedTemplateIndex,
    @Default([]) List<String> imagePaths,
    @Default({}) Map<String, Uint8List> webImageBytes,
    @Default({}) Map<String, String> webImageDisplayNames,
    @Default({}) Map<String, List<String>> textsPerImage,
    @Default(BackgroundConfig(
      gradientColors: [Color(0xFF667EEA), Color(0xFF764BA2)],
    ))
    BackgroundConfig background,
    @Default(0) int selectedImageIndex,
    @Default(1.0) double textScale,
    @Default(false) bool showDeviceFrame,
    @Default(0.80) double imageSizeRatio,
    @Default(Color(0xFFFFFFFF)) Color textColor,
    @Default(ScreenshotFontFamily.nunito) ScreenshotFontFamily screenshotFont,
    @Default(false) bool previewTablet,
    @Default({}) Map<String, TextVerticalPlacement> textPlacementPerImage,
  }) = _EditorState;

  factory EditorState.initial() => const EditorState();

  String? get selectedImagePath {
    if (imagePaths.isEmpty) return null;
    if (selectedImageIndex >= imagePaths.length) return null;
    return imagePaths[selectedImageIndex];
  }

  DeviceFrameStyle get deviceFrameStyle {
    if (!showDeviceFrame) return DeviceFrameStyle.none;
    return storeType == StoreType.appStore
        ? DeviceFrameStyle.iPhone
        : DeviceFrameStyle.android;
  }

  List<String> textsForImage(String imagePath, int maxTexts) {
    final texts = textsPerImage[imagePath];
    if (texts == null) return List.filled(maxTexts, '');
    if (texts.length < maxTexts) {
      return [...texts, ...List.filled(maxTexts - texts.length, '')];
    }
    return texts;
  }

  List<String> currentTexts(int maxTexts) {
    final path = selectedImagePath;
    if (path == null) return List.filled(maxTexts, '');
    return textsForImage(path, maxTexts);
  }

  TextVerticalPlacement textPlacementForImage(String imagePath) {
    return textPlacementPerImage[imagePath] ??
        TextVerticalPlacement.aboveImage;
  }
}
