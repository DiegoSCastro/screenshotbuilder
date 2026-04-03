class TemplateModel {
  final String id;
  final String name;
  final bool supportsGradient;
  final bool supportsSolidColor;
  final int maxTexts;

  const TemplateModel({
    required this.id,
    required this.name,
    this.supportsGradient = true,
    this.supportsSolidColor = true,
    this.maxTexts = 3,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TemplateModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'TemplateModel(id: $id, name: $name)';
}
