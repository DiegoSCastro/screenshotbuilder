import 'package:flutter_test/flutter_test.dart';
import 'package:screenshotbuilder/models/template_model.dart';

void main() {
  group('TemplateModel', () {
    test('should create with required parameters', () {
      const model = TemplateModel(id: 'test_1', name: 'Test Template');

      expect(model.id, 'test_1');
      expect(model.name, 'Test Template');
    });

    test('should have correct default values', () {
      const model = TemplateModel(id: 'test_1', name: 'Test');

      expect(model.supportsGradient, true);
      expect(model.supportsSolidColor, true);
      expect(model.maxTexts, 3);
    });

    test('should allow overriding default values', () {
      const model = TemplateModel(
        id: 'test_1',
        name: 'Test',
        supportsGradient: false,
        supportsSolidColor: false,
        maxTexts: 2,
      );

      expect(model.supportsGradient, false);
      expect(model.supportsSolidColor, false);
      expect(model.maxTexts, 2);
    });

    test('equality should be based on id', () {
      const model1 = TemplateModel(id: 'test_1', name: 'Name 1');
      const model2 = TemplateModel(id: 'test_1', name: 'Name 2');
      const model3 = TemplateModel(id: 'test_2', name: 'Name 1');

      expect(model1, equals(model2));
      expect(model1, isNot(equals(model3)));
    });

    test('hashCode should be based on id', () {
      const model1 = TemplateModel(id: 'test_1', name: 'Name 1');
      const model2 = TemplateModel(id: 'test_1', name: 'Name 2');

      expect(model1.hashCode, equals(model2.hashCode));
    });

    test('toString should include id and name', () {
      const model = TemplateModel(id: 'test_1', name: 'Test');
      expect(model.toString(), contains('test_1'));
      expect(model.toString(), contains('Test'));
    });
  });
}
