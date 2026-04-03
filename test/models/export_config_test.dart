import 'package:flutter_test/flutter_test.dart';
import 'package:screenshotbuilder/models/export_config.dart';

void main() {
  group('StoreType', () {
    test('displayName should return correct labels', () {
      expect(StoreType.appStore.displayName, 'App Store');
      expect(StoreType.playStore.displayName, 'Google Play');
    });
  });

  group('ExportSize', () {
    test('should store name, width, and height', () {
      const size = ExportSize('phone', 1080, 1920);

      expect(size.name, 'phone');
      expect(size.width, 1080);
      expect(size.height, 1920);
    });

    test('aspectRatio should return width / height', () {
      const size = ExportSize('phone', 1080, 1920);
      expect(size.aspectRatio, closeTo(0.5625, 0.001));
    });

    test('toString should contain dimensions', () {
      const size = ExportSize('phone', 1080, 1920);
      expect(size.toString(), contains('1080'));
      expect(size.toString(), contains('1920'));
    });

    test('isTablet should be false for phone aspect ratios', () {
      const phone = ExportSize('phone', 1080, 1920);
      expect(phone.isTablet, false);

      const iphone = ExportSize('iphone_6_7', 1290, 2796);
      expect(iphone.isTablet, false);
    });

    test('isTablet should be true for tablet aspect ratios', () {
      const ipad = ExportSize('ipad_12_9', 2048, 2732);
      expect(ipad.isTablet, true);

      const tablet = ExportSize('tablet_10', 1600, 2560);
      expect(tablet.isTablet, true);
    });
  });

  group('ExportConfig', () {
    test('appStoreSizes should have correct values', () {
      final sizes = ExportConfig.appStoreSizes;

      expect(sizes.length, 2);
      expect(sizes[0].name, 'iphone_6_7');
      expect(sizes[0].width, 1290);
      expect(sizes[0].height, 2796);
      expect(sizes[1].name, 'ipad_12_9');
      expect(sizes[1].width, 2048);
      expect(sizes[1].height, 2732);
    });

    test('playStoreSizes should have correct values', () {
      final sizes = ExportConfig.playStoreSizes;

      expect(sizes.length, 2);
      expect(sizes[0].name, 'phone');
      expect(sizes[0].width, 1080);
      expect(sizes[0].height, 1920);
      expect(sizes[1].name, 'tablet_10');
      expect(sizes[1].width, 1600);
      expect(sizes[1].height, 2560);
    });

    test('sizesForStore should return correct sizes', () {
      final appStoreSizes = ExportConfig.sizesForStore(StoreType.appStore);
      final playStoreSizes = ExportConfig.sizesForStore(StoreType.playStore);

      expect(appStoreSizes, ExportConfig.appStoreSizes);
      expect(playStoreSizes, ExportConfig.playStoreSizes);
    });

    test('ExportConfig constructor should set store and sizes', () {
      const config = ExportConfig(
        store: StoreType.appStore,
        sizes: ExportConfig.appStoreSizes,
      );

      expect(config.store, StoreType.appStore);
      expect(config.sizes, ExportConfig.appStoreSizes);
    });
  });
}
