import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:screenshotbuilder/models/background_config.dart';
import 'package:screenshotbuilder/models/text_vertical_placement.dart';
import 'package:screenshotbuilder/templates/template1.dart';
import 'package:screenshotbuilder/templates/template2.dart';
import 'package:screenshotbuilder/templates/template3.dart';

void main() {
  const testSize = Size(360, 640);
  const testBackground = BackgroundConfig(
    gradientColors: [Color(0xFF667EEA), Color(0xFF764BA2)],
  );

  Widget wrapWithApp(Widget child) {
    return MaterialApp(
      home: Scaffold(body: child),
    );
  }

  group('Template1 build', () {
    testWidgets('should render with texts and no image', (tester) async {
      final template = Template1();
      final widget = template.build(
        size: testSize,
        texts: ['Title', 'Subtitle', 'Footer'],
        imagePath: null,
        background: testBackground,
      );

      await tester.pumpWidget(wrapWithApp(widget));

      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Subtitle'), findsOneWidget);
      expect(find.text('Footer'), findsOneWidget);
    });

    testWidgets('should render with text below image', (tester) async {
      final template = Template1();
      final widget = template.build(
        size: testSize,
        texts: ['Title', 'Subtitle', 'Footer'],
        imagePath: null,
        background: testBackground,
        textVerticalPlacement: TextVerticalPlacement.belowImage,
      );

      await tester.pumpWidget(wrapWithApp(widget));

      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Subtitle'), findsOneWidget);
      expect(find.text('Footer'), findsOneWidget);
    });

    testWidgets('should render with empty texts', (tester) async {
      final template = Template1();
      final widget = template.build(
        size: testSize,
        texts: ['', '', ''],
        imagePath: null,
        background: testBackground,
      );

      await tester.pumpWidget(wrapWithApp(widget));
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('should render with solid background', (tester) async {
      final template = Template1();
      final widget = template.build(
        size: testSize,
        texts: ['Test'],
        imagePath: null,
        background: const BackgroundConfig(solidColor: Color(0xFF000000)),
      );

      await tester.pumpWidget(wrapWithApp(widget));
      expect(find.text('Test'), findsOneWidget);
    });
  });

  group('Template2 build', () {
    testWidgets('should render with texts', (tester) async {
      final template = Template2();
      final widget = template.build(
        size: testSize,
        texts: ['Big Title', 'Description'],
        imagePath: null,
        background: testBackground,
      );

      await tester.pumpWidget(wrapWithApp(widget));

      expect(find.text('Big Title'), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);
    });

    testWidgets('should handle single text', (tester) async {
      final template = Template2();
      final widget = template.build(
        size: testSize,
        texts: ['Only Title'],
        imagePath: null,
        background: testBackground,
      );

      await tester.pumpWidget(wrapWithApp(widget));
      expect(find.text('Only Title'), findsOneWidget);
    });
  });

  group('Template3 build', () {
    testWidgets('should render with side layout', (tester) async {
      final template = Template3();
      final widget = template.build(
        size: const Size(640, 360),
        texts: ['Title', 'Description', 'CTA'],
        imagePath: null,
        background: testBackground,
      );

      await tester.pumpWidget(wrapWithApp(widget));

      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);
      expect(find.text('CTA'), findsOneWidget);
    });

    testWidgets('should render placeholder when no image', (tester) async {
      final template = Template3();
      final widget = template.build(
        size: const Size(640, 360),
        texts: ['Title'],
        imagePath: null,
        background: testBackground,
      );

      await tester.pumpWidget(wrapWithApp(widget));
      expect(find.byIcon(Icons.image_outlined), findsOneWidget);
    });

    testWidgets('should swap row when text after image', (tester) async {
      final template = Template3();
      final widget = template.build(
        size: const Size(640, 360),
        texts: ['Title', 'Description', 'CTA'],
        imagePath: null,
        background: testBackground,
        textVerticalPlacement: TextVerticalPlacement.belowImage,
      );

      await tester.pumpWidget(wrapWithApp(widget));

      expect(find.text('Title'), findsOneWidget);
      expect(find.byIcon(Icons.image_outlined), findsOneWidget);
    });
  });
}
