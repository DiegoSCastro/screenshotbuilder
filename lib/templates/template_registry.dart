import 'base_template.dart';
import 'template1.dart';
import 'template2.dart';
import 'template3.dart';

class TemplateRegistry {
  static final List<BaseTemplate> templates = [
    Template1(),
    Template2(),
    Template3(),
  ];

  static BaseTemplate getByIndex(int index) {
    if (index < 0 || index >= templates.length) {
      return templates.first;
    }
    return templates[index];
  }

  static BaseTemplate? getById(String id) {
    try {
      return templates.firstWhere((t) => t.model.id == id);
    } catch (_) {
      return null;
    }
  }
}
