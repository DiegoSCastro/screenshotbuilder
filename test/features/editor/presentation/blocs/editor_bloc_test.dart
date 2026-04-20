import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:screenshotbuilder/features/editor/presentation/blocs/editor_bloc/editor_bloc.dart';
import 'package:screenshotbuilder/common/widgets/device_frame.dart';
import 'package:screenshotbuilder/models/background_config.dart';
import 'package:screenshotbuilder/models/export_config.dart';
import 'package:screenshotbuilder/models/text_vertical_placement.dart';

void main() {
  group('EditorBloc', () {
    late EditorBloc bloc;

    setUp(() {
      bloc = EditorBloc();
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state should have correct defaults', () {
      final state = bloc.state;

      expect(state.storeType, StoreType.appStore);
      expect(state.selectedTemplateIndex, 0);
      expect(state.imagePaths, isEmpty);
      expect(state.webImageBytes, isEmpty);
      expect(state.webImageDisplayNames, isEmpty);
      expect(state.textsPerImage, isEmpty);
      expect(state.textPlacementPerImage, isEmpty);
      expect(state.background.isGradient, true);
      expect(state.selectedImageIndex, 0);
      expect(state.textScale, 1.0);
      expect(state.showDeviceFrame, false);
      expect(state.imageSizeRatio, 0.80);
      expect(state.textColor, const Color(0xFFFFFFFF));
    });

    test('selectedImagePath should be null when no images', () {
      expect(bloc.state.selectedImagePath, isNull);
    });

    test('currentTexts should return empty texts when no images', () {
      final texts = bloc.state.currentTexts(3);
      expect(texts, ['', '', '']);
    });

    blocTest<EditorBloc, EditorState>(
      'selectStore should update storeType',
      build: () => EditorBloc(),
      act: (bloc) =>
          bloc.add(const EditorEvent.selectStore(StoreType.playStore)),
      expect: () => [
        isA<EditorState>().having(
          (s) => s.storeType,
          'storeType',
          StoreType.playStore,
        ),
      ],
    );

    blocTest<EditorBloc, EditorState>(
      'selectTemplate should update selectedTemplateIndex',
      build: () => EditorBloc(),
      act: (bloc) => bloc.add(const EditorEvent.selectTemplate(2)),
      expect: () => [
        isA<EditorState>().having(
          (s) => s.selectedTemplateIndex,
          'selectedTemplateIndex',
          2,
        ),
      ],
    );

    blocTest<EditorBloc, EditorState>(
      'addImages should append paths and initialize per-image texts',
      build: () => EditorBloc(),
      act: (bloc) {
        bloc.add(const EditorEvent.addImages(paths: ['/img1.png']));
        bloc.add(const EditorEvent.addImages(paths: ['/img2.png']));
      },
      expect: () => [
        isA<EditorState>()
            .having((s) => s.imagePaths, 'imagePaths', ['/img1.png']).having(
          (s) => s.textsPerImage.containsKey('/img1.png'),
          'has texts for img1',
          true,
        ),
        isA<EditorState>().having(
          (s) => s.imagePaths,
          'imagePaths',
          ['/img1.png', '/img2.png'],
        ).having(
          (s) => s.textsPerImage.length,
          'textsPerImage count',
          2,
        ),
      ],
    );

    blocTest<EditorBloc, EditorState>(
      'removeImage should remove path and its texts',
      build: () => EditorBloc(),
      seed: () => const EditorState(
        imagePaths: ['/img1.png', '/img2.png', '/img3.png'],
        textsPerImage: {
          '/img1.png': ['A', 'B', 'C'],
          '/img2.png': ['D', 'E', 'F'],
          '/img3.png': ['G', 'H', 'I'],
        },
      ),
      act: (bloc) => bloc.add(const EditorEvent.removeImage(1)),
      expect: () => [
        isA<EditorState>()
            .having(
              (s) => s.imagePaths,
              'imagePaths',
              ['/img1.png', '/img3.png'],
            )
            .having(
              (s) => s.textsPerImage.containsKey('/img2.png'),
              'img2 texts removed',
              false,
            )
            .having(
              (s) => s.textsPerImage.length,
              'remaining texts count',
              2,
            ),
      ],
    );

    blocTest<EditorBloc, EditorState>(
      'removeImage should adjust selectedImageIndex when needed',
      build: () => EditorBloc(),
      seed: () => const EditorState(
        imagePaths: ['/img1.png', '/img2.png'],
        textsPerImage: {
          '/img1.png': ['A'],
          '/img2.png': ['B'],
        },
        selectedImageIndex: 1,
      ),
      act: (bloc) => bloc.add(const EditorEvent.removeImage(1)),
      expect: () => [
        isA<EditorState>()
            .having((s) => s.imagePaths, 'imagePaths', ['/img1.png'])
            .having((s) => s.selectedImageIndex, 'selectedImageIndex', 0),
      ],
    );

    blocTest<EditorBloc, EditorState>(
      'removeImage should remove text placement for that path',
      build: () => EditorBloc(),
      seed: () => EditorState(
        imagePaths: ['/a.png', '/b.png'],
        textsPerImage: {
          '/a.png': ['', '', ''],
          '/b.png': ['', '', ''],
        },
        textPlacementPerImage: {
          '/a.png': TextVerticalPlacement.belowImage,
          '/b.png': TextVerticalPlacement.belowImage,
        },
        selectedImageIndex: 0,
      ),
      act: (bloc) => bloc.add(const EditorEvent.removeImage(0)),
      expect: () => [
        isA<EditorState>()
            .having(
              (s) => s.textPlacementPerImage.containsKey('/a.png'),
              'a placement removed',
              false,
            )
            .having(
              (s) => s.textPlacementPerImage['/b.png'],
              'b placement kept',
              TextVerticalPlacement.belowImage,
            ),
      ],
    );

    blocTest<EditorBloc, EditorState>(
      'updateTextPlacement should affect selected image only',
      build: () => EditorBloc(),
      seed: () => const EditorState(
        imagePaths: ['/x.png', '/y.png'],
        textsPerImage: {
          '/x.png': ['', '', ''],
          '/y.png': ['', '', ''],
        },
        selectedImageIndex: 0,
      ),
      act: (bloc) => bloc.add(
        const EditorEvent.updateTextPlacement(
          TextVerticalPlacement.belowImage,
        ),
      ),
      expect: () => [
        isA<EditorState>()
            .having(
              (s) => s.textPlacementForImage('/x.png'),
              'x below',
              TextVerticalPlacement.belowImage,
            )
            .having(
              (s) => s.textPlacementForImage('/y.png'),
              'y default above',
              TextVerticalPlacement.aboveImage,
            ),
      ],
    );

    blocTest<EditorBloc, EditorState>(
      'updateTextPlacement to above clears map entry',
      build: () => EditorBloc(),
      seed: () => EditorState(
        imagePaths: ['/x.png'],
        textsPerImage: {'/x.png': ['', '', '']},
        textPlacementPerImage: {
          '/x.png': TextVerticalPlacement.belowImage,
        },
      ),
      act: (bloc) => bloc.add(
        const EditorEvent.updateTextPlacement(
          TextVerticalPlacement.aboveImage,
        ),
      ),
      expect: () => [
        isA<EditorState>().having(
          (s) => s.textPlacementPerImage,
          'placement map empty for default',
          isEmpty,
        ),
      ],
    );

    blocTest<EditorBloc, EditorState>(
      'updateText should update text for the SELECTED image only',
      build: () => EditorBloc(),
      seed: () => const EditorState(
        imagePaths: ['/img1.png', '/img2.png'],
        textsPerImage: {
          '/img1.png': ['', '', ''],
          '/img2.png': ['', '', ''],
        },
        selectedImageIndex: 0,
      ),
      act: (bloc) => bloc.add(
        const EditorEvent.updateText(index: 0, text: 'Title for img1'),
      ),
      expect: () => [
        isA<EditorState>()
            .having(
              (s) => s.textsPerImage['/img1.png']?[0],
              'img1 title',
              'Title for img1',
            )
            .having(
              (s) => s.textsPerImage['/img2.png']?[0],
              'img2 title unchanged',
              '',
            ),
      ],
    );

    blocTest<EditorBloc, EditorState>(
      'updateText on second image should not affect first',
      build: () => EditorBloc(),
      seed: () => const EditorState(
        imagePaths: ['/img1.png', '/img2.png'],
        textsPerImage: {
          '/img1.png': ['Title A', '', ''],
          '/img2.png': ['', '', ''],
        },
        selectedImageIndex: 1,
      ),
      act: (bloc) => bloc.add(
        const EditorEvent.updateText(index: 0, text: 'Title for img2'),
      ),
      expect: () => [
        isA<EditorState>()
            .having(
              (s) => s.textsPerImage['/img1.png']?[0],
              'img1 unchanged',
              'Title A',
            )
            .having(
              (s) => s.textsPerImage['/img2.png']?[0],
              'img2 updated',
              'Title for img2',
            ),
      ],
    );

    blocTest<EditorBloc, EditorState>(
      'updateBackground should update background config',
      build: () => EditorBloc(),
      act: (bloc) => bloc.add(
        const EditorEvent.updateBackground(
          BackgroundConfig(solidColor: Color(0xFF000000)),
        ),
      ),
      expect: () => [
        isA<EditorState>().having(
          (s) => s.background.isSolid,
          'background.isSolid',
          true,
        ),
      ],
    );

    blocTest<EditorBloc, EditorState>(
      'selectImage should update selectedImageIndex',
      build: () => EditorBloc(),
      seed: () => const EditorState(
        imagePaths: ['/img1.png', '/img2.png', '/img3.png'],
      ),
      act: (bloc) => bloc.add(const EditorEvent.selectImage(2)),
      expect: () => [
        isA<EditorState>().having(
          (s) => s.selectedImageIndex,
          'selectedImageIndex',
          2,
        ),
      ],
    );

    blocTest<EditorBloc, EditorState>(
      'reorderImages should move image from old to new index',
      build: () => EditorBloc(),
      seed: () => const EditorState(
        imagePaths: ['/a.png', '/b.png', '/c.png'],
        textsPerImage: {
          '/a.png': ['A'],
          '/b.png': ['B'],
          '/c.png': ['C'],
        },
      ),
      act: (bloc) => bloc.add(
        const EditorEvent.reorderImages(oldIndex: 0, newIndex: 2),
      ),
      expect: () => [
        isA<EditorState>()
            .having(
              (s) => s.imagePaths,
              'imagePaths',
              ['/b.png', '/c.png', '/a.png'],
            )
            .having(
              (s) => s.textsPerImage['/a.png'],
              'texts survive reorder',
              ['A'],
            ),
      ],
    );

    blocTest<EditorBloc, EditorState>(
      'updateTextScale should clamp value between 0.5 and 2.0',
      build: () => EditorBloc(),
      act: (bloc) {
        bloc.add(const EditorEvent.updateTextScale(1.5));
        bloc.add(const EditorEvent.updateTextScale(3.0));
        bloc.add(const EditorEvent.updateTextScale(0.1));
      },
      expect: () => [
        isA<EditorState>().having((s) => s.textScale, 'textScale', 1.5),
        isA<EditorState>().having((s) => s.textScale, 'textScale clamped', 2.0),
        isA<EditorState>().having((s) => s.textScale, 'textScale clamped', 0.5),
      ],
    );

    blocTest<EditorBloc, EditorState>(
      'toggleDeviceFrame should update showDeviceFrame',
      build: () => EditorBloc(),
      act: (bloc) => bloc.add(const EditorEvent.toggleDeviceFrame(true)),
      expect: () => [
        isA<EditorState>().having(
          (s) => s.showDeviceFrame,
          'showDeviceFrame',
          true,
        ),
      ],
    );

    blocTest<EditorBloc, EditorState>(
      'updateImageSizeRatio should clamp between 0.4 and 0.95',
      build: () => EditorBloc(),
      act: (bloc) {
        bloc.add(const EditorEvent.updateImageSizeRatio(0.7));
        bloc.add(const EditorEvent.updateImageSizeRatio(0.1));
        bloc.add(const EditorEvent.updateImageSizeRatio(1.5));
      },
      expect: () => [
        isA<EditorState>()
            .having((s) => s.imageSizeRatio, 'imageSizeRatio', 0.7),
        isA<EditorState>()
            .having((s) => s.imageSizeRatio, 'imageSizeRatio clamped', 0.4),
        isA<EditorState>()
            .having((s) => s.imageSizeRatio, 'imageSizeRatio clamped', 0.95),
      ],
    );

    blocTest<EditorBloc, EditorState>(
      'updateTextColor should update textColor',
      build: () => EditorBloc(),
      act: (bloc) =>
          bloc.add(const EditorEvent.updateTextColor(Color(0xFF000000))),
      expect: () => [
        isA<EditorState>().having(
          (s) => s.textColor,
          'textColor',
          const Color(0xFF000000),
        ),
      ],
    );

    group('EditorState helpers', () {
      test('selectedImagePath should return correct path', () {
        const state = EditorState(
          imagePaths: ['/a.png', '/b.png'],
          selectedImageIndex: 1,
        );
        expect(state.selectedImagePath, '/b.png');
      });

      test('selectedImagePath should be null for out of bounds index', () {
        const state = EditorState(
          imagePaths: ['/a.png'],
          selectedImageIndex: 5,
        );
        expect(state.selectedImagePath, isNull);
      });

      test('textsForImage should return stored texts', () {
        const state = EditorState(
          textsPerImage: {
            '/a.png': ['Title', 'Sub'],
          },
        );
        final texts = state.textsForImage('/a.png', 3);
        expect(texts, ['Title', 'Sub', '']);
      });

      test('textsForImage should return empty texts for unknown image', () {
        const state = EditorState();
        final texts = state.textsForImage('/unknown.png', 3);
        expect(texts, ['', '', '']);
      });

      test('currentTexts should return texts for selected image', () {
        const state = EditorState(
          imagePaths: ['/a.png', '/b.png'],
          textsPerImage: {
            '/a.png': ['A1', 'A2', 'A3'],
            '/b.png': ['B1', 'B2', 'B3'],
          },
          selectedImageIndex: 1,
        );
        final texts = state.currentTexts(3);
        expect(texts, ['B1', 'B2', 'B3']);
      });

      test('textPlacementForImage defaults to aboveImage', () {
        const state = EditorState();
        expect(
          state.textPlacementForImage('/any.png'),
          TextVerticalPlacement.aboveImage,
        );
      });

      test('deviceFrameStyle returns none when showDeviceFrame is false', () {
        const state = EditorState(showDeviceFrame: false);
        expect(state.deviceFrameStyle, DeviceFrameStyle.none);
      });

      test('deviceFrameStyle returns iPhone for App Store', () {
        const state = EditorState(
          showDeviceFrame: true,
          storeType: StoreType.appStore,
        );
        expect(state.deviceFrameStyle, DeviceFrameStyle.iPhone);
      });

      test('deviceFrameStyle returns android for Play Store', () {
        const state = EditorState(
          showDeviceFrame: true,
          storeType: StoreType.playStore,
        );
        expect(state.deviceFrameStyle, DeviceFrameStyle.android);
      });
    });
  });
}
