enum StoreType {
  appStore,
  playStore;

  String get displayName {
    switch (this) {
      case StoreType.appStore:
        return 'App Store';
      case StoreType.playStore:
        return 'Google Play';
    }
  }
}

class ExportSize {
  final String name;
  final double width;
  final double height;

  const ExportSize(this.name, this.width, this.height);

  double get aspectRatio => width / height;

  /// Tablet sizes have a wider aspect ratio (closer to 3:4) vs phones (~9:19.5)
  bool get isTablet => aspectRatio > 0.6;

  @override
  String toString() => '$name (${width.toInt()}x${height.toInt()})';
}

class ExportConfig {
  final StoreType store;
  final List<ExportSize> sizes;

  const ExportConfig({
    required this.store,
    required this.sizes,
  });

  static const appStoreSizes = [
    ExportSize('iphone_6_7', 1290, 2796),
    ExportSize('ipad_12_9', 2048, 2732),
  ];

  static const playStoreSizes = [
    ExportSize('phone', 1080, 1920),
    ExportSize('tablet_10', 1600, 2560),
  ];

  static List<ExportSize> sizesForStore(StoreType store) {
    switch (store) {
      case StoreType.appStore:
        return appStoreSizes;
      case StoreType.playStore:
        return playStoreSizes;
    }
  }
}
