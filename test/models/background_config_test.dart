import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:screenshotbuilder/models/background_config.dart';

void main() {
  group('BackgroundConfig', () {
    test('isGradient should return true when gradientColors has 2+ colors', () {
      const config = BackgroundConfig(
        gradientColors: [Color(0xFF000000), Color(0xFFFFFFFF)],
      );

      expect(config.isGradient, true);
      expect(config.isSolid, false);
    });

    test('isSolid should return true when solidColor is set', () {
      const config = BackgroundConfig(solidColor: Color(0xFF000000));

      expect(config.isSolid, true);
      expect(config.isGradient, false);
    });

    test('isGradient should return false when gradientColors is null', () {
      const config = BackgroundConfig();
      expect(config.isGradient, false);
    });

    test('isGradient should return false when gradientColors has < 2 colors',
        () {
      const config = BackgroundConfig(
        gradientColors: [Color(0xFF000000)],
      );
      expect(config.isGradient, false);
    });

    test('copyWith should create a copy with updated values', () {
      const original = BackgroundConfig(
        solidColor: Color(0xFF000000),
      );

      final copy = original.copyWith(solidColor: const Color(0xFFFF0000));

      expect(copy.solidColor, const Color(0xFFFF0000));
    });

    test('copyWith with clearSolid should remove solidColor', () {
      const original = BackgroundConfig(solidColor: Color(0xFF000000));

      final copy = original.copyWith(clearSolid: true);

      expect(copy.solidColor, isNull);
    });

    test('copyWith with clearGradient should remove gradientColors', () {
      const original = BackgroundConfig(
        gradientColors: [Color(0xFF000000), Color(0xFFFFFFFF)],
      );

      final copy = original.copyWith(clearGradient: true);

      expect(copy.gradientColors, isNull);
    });

    test('equality should compare solidColor and gradientColors', () {
      const config1 = BackgroundConfig(solidColor: Color(0xFF000000));
      const config2 = BackgroundConfig(solidColor: Color(0xFF000000));
      const config3 = BackgroundConfig(solidColor: Color(0xFFFF0000));

      expect(config1, equals(config2));
      expect(config1, isNot(equals(config3)));
    });

    test('equality should handle gradient lists', () {
      const config1 = BackgroundConfig(
        gradientColors: [Color(0xFF000000), Color(0xFFFFFFFF)],
      );
      const config2 = BackgroundConfig(
        gradientColors: [Color(0xFF000000), Color(0xFFFFFFFF)],
      );
      const config3 = BackgroundConfig(
        gradientColors: [Color(0xFFFF0000), Color(0xFFFFFFFF)],
      );

      expect(config1, equals(config2));
      expect(config1, isNot(equals(config3)));
    });

    test('equality should handle null lists', () {
      const config1 = BackgroundConfig();
      const config2 = BackgroundConfig();

      expect(config1, equals(config2));
    });
  });
}
