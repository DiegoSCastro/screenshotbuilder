part of 'editor_bloc.dart';

@freezed
class EditorEvent with _$EditorEvent {
  const factory EditorEvent.selectStore(StoreType store) = _SelectStore;
  const factory EditorEvent.selectTemplate(int index) = _SelectTemplate;
  const factory EditorEvent.addImages(List<String> paths) = _AddImages;
  const factory EditorEvent.removeImage(int index) = _RemoveImage;
  const factory EditorEvent.updateText({
    required int index,
    required String text,
  }) = _UpdateText;
  const factory EditorEvent.updateBackground(BackgroundConfig background) =
      _UpdateBackground;
  const factory EditorEvent.selectImage(int index) = _SelectImage;
  const factory EditorEvent.reorderImages({
    required int oldIndex,
    required int newIndex,
  }) = _ReorderImages;
  const factory EditorEvent.updateTextScale(double scale) = _UpdateTextScale;
  const factory EditorEvent.toggleDeviceFrame(bool show) = _ToggleDeviceFrame;
  const factory EditorEvent.updateImageSizeRatio(double ratio) =
      _UpdateImageSizeRatio;
  const factory EditorEvent.updateTextColor(Color color) = _UpdateTextColor;
}
