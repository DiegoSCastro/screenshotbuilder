import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../common/widgets/device_frame.dart';
import '../../../../../models/background_config.dart';
import '../../../../../models/export_config.dart';
import '../../../../../models/screenshot_font_family.dart';
import '../../../../../models/text_vertical_placement.dart';
import '../../../../../templates/template_registry.dart';

part 'editor_event.dart';
part 'editor_state.dart';
part 'editor_bloc.freezed.dart';

@injectable
class EditorBloc extends Bloc<EditorEvent, EditorState> {
  EditorBloc() : super(EditorState.initial()) {
    on<_SelectStore>((event, emit) {
      emit(state.copyWith(storeType: event.store));
    });

    on<_SelectTemplate>((event, emit) {
      emit(state.copyWith(selectedTemplateIndex: event.index));
    });

    on<_AddImages>((event, emit) {
      final updated = List<String>.from(state.imagePaths)..addAll(event.paths);
      final updatedTexts =
          Map<String, List<String>>.from(state.textsPerImage);
      final updatedBytes = Map<String, Uint8List>.from(state.webImageBytes);
      final updatedNames =
          Map<String, String>.from(state.webImageDisplayNames);
      if (event.webImageBytes != null) {
        updatedBytes.addAll(event.webImageBytes!);
      }
      if (event.webImageDisplayNames != null) {
        updatedNames.addAll(event.webImageDisplayNames!);
      }
      final maxTexts =
          TemplateRegistry.getByIndex(state.selectedTemplateIndex)
              .model
              .maxTexts;
      for (final path in event.paths) {
        if (!updatedTexts.containsKey(path)) {
          updatedTexts[path] = List.filled(maxTexts, '');
        }
      }
      emit(state.copyWith(
        imagePaths: updated,
        textsPerImage: updatedTexts,
        webImageBytes: updatedBytes,
        webImageDisplayNames: updatedNames,
      ));
    });

    on<_RemoveImage>((event, emit) {
      if (event.index < 0 || event.index >= state.imagePaths.length) return;
      final removedPath = state.imagePaths[event.index];
      final updated = List<String>.from(state.imagePaths)
        ..removeAt(event.index);
      final updatedTexts =
          Map<String, List<String>>.from(state.textsPerImage)
            ..remove(removedPath);
      final updatedPlacement =
          Map<String, TextVerticalPlacement>.from(
        state.textPlacementPerImage,
      )..remove(removedPath);
      final updatedBytes = Map<String, Uint8List>.from(state.webImageBytes)
        ..remove(removedPath);
      final updatedNames =
          Map<String, String>.from(state.webImageDisplayNames)
            ..remove(removedPath);
      int idx = state.selectedImageIndex;
      if (idx >= updated.length && updated.isNotEmpty) {
        idx = updated.length - 1;
      } else if (updated.isEmpty) {
        idx = 0;
      }
      emit(state.copyWith(
        imagePaths: updated,
        textsPerImage: updatedTexts,
        textPlacementPerImage: updatedPlacement,
        webImageBytes: updatedBytes,
        webImageDisplayNames: updatedNames,
        selectedImageIndex: idx,
      ));
    });

    on<_UpdateText>((event, emit) {
      final path = state.selectedImagePath;
      if (path == null) return;
      final maxTexts =
          TemplateRegistry.getByIndex(state.selectedTemplateIndex)
              .model
              .maxTexts;
      final current =
          List<String>.from(state.textsForImage(path, maxTexts));
      if (event.index < current.length) {
        current[event.index] = event.text;
      }
      final updatedTexts =
          Map<String, List<String>>.from(state.textsPerImage);
      updatedTexts[path] = current;
      emit(state.copyWith(textsPerImage: updatedTexts));
    });

    on<_UpdateTitle>((event, emit) {
      final path = state.selectedImagePath;
      if (path == null) return;
      final maxTexts =
          TemplateRegistry.getByIndex(state.selectedTemplateIndex)
              .model
              .maxTexts;
      final next = List<String>.generate(
        maxTexts,
        (i) => i == 0 ? event.text : '',
      );
      final updatedTexts =
          Map<String, List<String>>.from(state.textsPerImage);
      updatedTexts[path] = next;
      emit(state.copyWith(textsPerImage: updatedTexts));
    });

    on<_UpdateBackground>((event, emit) {
      emit(state.copyWith(background: event.background));
    });

    on<_SelectImage>((event, emit) {
      emit(state.copyWith(selectedImageIndex: event.index));
    });

    on<_ReorderImages>((event, emit) {
      final updated = List<String>.from(state.imagePaths);
      final item = updated.removeAt(event.oldIndex);
      updated.insert(event.newIndex, item);
      emit(state.copyWith(imagePaths: updated));
    });

    on<_UpdateTextScale>((event, emit) {
      emit(state.copyWith(textScale: event.scale.clamp(0.5, 2.0)));
    });

    on<_ToggleDeviceFrame>((event, emit) {
      emit(state.copyWith(showDeviceFrame: event.show));
    });

    on<_UpdateImageSizeRatio>((event, emit) {
      emit(state.copyWith(imageSizeRatio: event.ratio.clamp(0.4, 0.95)));
    });

    on<_UpdateTextColor>((event, emit) {
      emit(state.copyWith(textColor: event.color));
    });

    on<_TogglePreviewTablet>((event, emit) {
      emit(state.copyWith(previewTablet: event.value));
    });

    on<_UpdateScreenshotFont>((event, emit) {
      emit(state.copyWith(screenshotFont: event.font));
    });

    on<_UpdateTextPlacement>((event, emit) {
      final path = state.selectedImagePath;
      if (path == null) return;
      final updated = Map<String, TextVerticalPlacement>.from(
        state.textPlacementPerImage,
      );
      if (event.placement == TextVerticalPlacement.aboveImage) {
        updated.remove(path);
      } else {
        updated[path] = event.placement;
      }
      emit(state.copyWith(textPlacementPerImage: updated));
    });
  }
}
