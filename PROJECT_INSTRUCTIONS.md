# 📱 Screenshot Builder (Flutter Desktop - macOS)

## 🎯 Objetivo

Criar um app desktop em Flutter para gerar screenshots para:

* Apple App Store
* Google Play Store

O app deve:

* Importar imagens (screenshots)
* Permitir escolha de templates
* Editar textos
* Editar background (cor ou gradiente)
* Exportar automaticamente nos principais tamanhos (phone + tablet)

---

## 🧱 Arquitetura Geral

### Camadas

* UI (Flutter Widgets)
* Template Engine (renderização dinâmica)
* Export Engine (geração de imagens)
* Models (configuração de templates)

---

## 📂 Estrutura de Pastas

```
lib/
  main.dart

  core/
    renderer/
      screenshot_renderer.dart

  features/
    editor/
      editor_page.dart
      editor_controller.dart

  templates/
    base_template.dart
    template1.dart
    template2.dart
    template3.dart

  models/
    template_model.dart
    export_config.dart

  utils/
    image_utils.dart

assets/
  frames/
  backgrounds/

output/
```

---

## 🧠 Modelos

### TemplateModel

```dart
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
}
```

---

### ExportConfig

```dart
enum StoreType {
  appStore,
  playStore,
}

class ExportSize {
  final String name;
  final double width;
  final double height;

  const ExportSize(this.name, this.width, this.height);
}

class ExportConfig {
  final StoreType store;
  final List<ExportSize> sizes;

  ExportConfig({
    required this.store,
    required this.sizes,
  });
}
```

---

## 📐 Tamanhos de Exportação

### 🍎 App Store

```dart
final appStoreSizes = [
  ExportSize("iphone_6_7", 1290, 2796),
  ExportSize("ipad_12_9", 2048, 2732),
];
```

---

### 🤖 Google Play

```dart
final playStoreSizes = [
  ExportSize("phone", 1080, 1920),
  ExportSize("tablet_10", 1600, 2560),
];
```

---

## 🎨 Template Base

```dart
abstract class BaseTemplate {
  Widget build({
    required Size size,
    required List<String> texts,
    required String imagePath,
    required BackgroundConfig background,
  });
}
```

---

### BackgroundConfig

```dart
class BackgroundConfig {
  final Color? solidColor;
  final List<Color>? gradientColors;

  BackgroundConfig({
    this.solidColor,
    this.gradientColors,
  });
}
```

---

## 🧩 Templates

Criar 3 templates iniciais:

### Template 1

* Texto no topo
* Imagem central
* Background gradiente

### Template 2

* Texto central grande
* Imagem abaixo

### Template 3

* Layout lateral (texto à esquerda, imagem à direita)

---

## 🖥️ UI (Editor)

### Funcionalidades

* Selecionar Store:

  * App Store
  * Google Play

* Upload de imagens (multi)

* Selecionar Template

* Editar:

  * Textos (até 3)
  * Background:

    * Cor sólida
    * Gradiente (2 cores)

* Preview em tempo real

* Botão:
  👉 Generate Screenshots

---

## 🖼️ Renderização

Usar `RepaintBoundary` para capturar widget como imagem.

---

## ⚙️ ScreenshotRenderer

```dart
class ScreenshotRenderer {
  Future<void> renderAll({
    required BaseTemplate template,
    required List<String> images,
    required List<String> texts,
    required BackgroundConfig background,
    required List<ExportSize> sizes,
  }) async {
    for (final size in sizes) {
      for (int i = 0; i < images.length; i++) {
        final widget = template.build(
          size: Size(size.width, size.height),
          texts: texts,
          imagePath: images[i],
          background: background,
        );

        await _renderAndSave(widget, "${size.name}_$i.png");
      }
    }
  }
}
```

---

## 💾 Exportação

Salvar em:
Diretório de downloads do sistema

---

## 🧪 MVP (prioridade)

1. Selecionar store
2. Upload imagens
3. 1 template funcionando
4. Exportar 1 tamanho

---

## 🚀 Evolução futura

* Adicionar novos templates facilmente
* Salvar presets
* Batch por idioma
* Frames de device (iPhone mockup)
* CLI mode

---

## 💡 Observações

* Não precisa ser genérico demais
* Templates podem ser widgets fixos
* Foco em velocidade de geração

---

## ✅ Resultado esperado

Fluxo simples:

1. Seleciona store
2. Escolhe template
3. Define textos e cores
4. Clica em gerar

👉 Recebe todas screenshots prontas para upload
