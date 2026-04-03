import 'package:flutter_test/flutter_test.dart';
import 'package:screenshotbuilder/templates/template1.dart';
import 'package:screenshotbuilder/templates/template2.dart';
import 'package:screenshotbuilder/templates/template3.dart';
import 'package:screenshotbuilder/templates/template_registry.dart';

void main() {
  group('TemplateRegistry', () {
    test('should have 3 templates', () {
      expect(TemplateRegistry.templates.length, 3);
    });

    test('templates should have unique ids', () {
      final ids = TemplateRegistry.templates.map((t) => t.model.id).toList();
      expect(ids.toSet().length, ids.length);
    });

    test('templates should have non-empty names', () {
      for (final template in TemplateRegistry.templates) {
        expect(template.model.name.isNotEmpty, true);
      }
    });

    test('getByIndex should return correct template', () {
      expect(TemplateRegistry.getByIndex(0), isA<Template1>());
      expect(TemplateRegistry.getByIndex(1), isA<Template2>());
      expect(TemplateRegistry.getByIndex(2), isA<Template3>());
    });

    test('getByIndex should return first template for invalid index', () {
      expect(TemplateRegistry.getByIndex(-1), isA<Template1>());
      expect(TemplateRegistry.getByIndex(99), isA<Template1>());
    });

    test('getById should return correct template', () {
      final template = TemplateRegistry.getById('template_1');
      expect(template, isNotNull);
      expect(template, isA<Template1>());
    });

    test('getById should return null for unknown id', () {
      final template = TemplateRegistry.getById('nonexistent');
      expect(template, isNull);
    });
  });

  group('Template models', () {
    test('Template1 model should have correct config', () {
      final template = Template1();
      expect(template.model.id, 'template_1');
      expect(template.model.name, 'Classic Top Text');
      expect(template.model.maxTexts, 3);
    });

    test('Template2 model should have correct config', () {
      final template = Template2();
      expect(template.model.id, 'template_2');
      expect(template.model.name, 'Bold Center Text');
      expect(template.model.maxTexts, 2);
    });

    test('Template3 model should have correct config', () {
      final template = Template3();
      expect(template.model.id, 'template_3');
      expect(template.model.name, 'Side Layout');
      expect(template.model.maxTexts, 3);
    });
  });
}
