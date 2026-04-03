// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'editor_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EditorEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditorEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EditorEvent()';
}


}

/// @nodoc
class $EditorEventCopyWith<$Res>  {
$EditorEventCopyWith(EditorEvent _, $Res Function(EditorEvent) __);
}


/// Adds pattern-matching-related methods to [EditorEvent].
extension EditorEventPatterns on EditorEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _SelectStore value)?  selectStore,TResult Function( _SelectTemplate value)?  selectTemplate,TResult Function( _AddImages value)?  addImages,TResult Function( _RemoveImage value)?  removeImage,TResult Function( _UpdateText value)?  updateText,TResult Function( _UpdateBackground value)?  updateBackground,TResult Function( _SelectImage value)?  selectImage,TResult Function( _ReorderImages value)?  reorderImages,TResult Function( _UpdateTextScale value)?  updateTextScale,TResult Function( _ToggleDeviceFrame value)?  toggleDeviceFrame,TResult Function( _UpdateImageSizeRatio value)?  updateImageSizeRatio,TResult Function( _UpdateTextColor value)?  updateTextColor,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SelectStore() when selectStore != null:
return selectStore(_that);case _SelectTemplate() when selectTemplate != null:
return selectTemplate(_that);case _AddImages() when addImages != null:
return addImages(_that);case _RemoveImage() when removeImage != null:
return removeImage(_that);case _UpdateText() when updateText != null:
return updateText(_that);case _UpdateBackground() when updateBackground != null:
return updateBackground(_that);case _SelectImage() when selectImage != null:
return selectImage(_that);case _ReorderImages() when reorderImages != null:
return reorderImages(_that);case _UpdateTextScale() when updateTextScale != null:
return updateTextScale(_that);case _ToggleDeviceFrame() when toggleDeviceFrame != null:
return toggleDeviceFrame(_that);case _UpdateImageSizeRatio() when updateImageSizeRatio != null:
return updateImageSizeRatio(_that);case _UpdateTextColor() when updateTextColor != null:
return updateTextColor(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _SelectStore value)  selectStore,required TResult Function( _SelectTemplate value)  selectTemplate,required TResult Function( _AddImages value)  addImages,required TResult Function( _RemoveImage value)  removeImage,required TResult Function( _UpdateText value)  updateText,required TResult Function( _UpdateBackground value)  updateBackground,required TResult Function( _SelectImage value)  selectImage,required TResult Function( _ReorderImages value)  reorderImages,required TResult Function( _UpdateTextScale value)  updateTextScale,required TResult Function( _ToggleDeviceFrame value)  toggleDeviceFrame,required TResult Function( _UpdateImageSizeRatio value)  updateImageSizeRatio,required TResult Function( _UpdateTextColor value)  updateTextColor,}){
final _that = this;
switch (_that) {
case _SelectStore():
return selectStore(_that);case _SelectTemplate():
return selectTemplate(_that);case _AddImages():
return addImages(_that);case _RemoveImage():
return removeImage(_that);case _UpdateText():
return updateText(_that);case _UpdateBackground():
return updateBackground(_that);case _SelectImage():
return selectImage(_that);case _ReorderImages():
return reorderImages(_that);case _UpdateTextScale():
return updateTextScale(_that);case _ToggleDeviceFrame():
return toggleDeviceFrame(_that);case _UpdateImageSizeRatio():
return updateImageSizeRatio(_that);case _UpdateTextColor():
return updateTextColor(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _SelectStore value)?  selectStore,TResult? Function( _SelectTemplate value)?  selectTemplate,TResult? Function( _AddImages value)?  addImages,TResult? Function( _RemoveImage value)?  removeImage,TResult? Function( _UpdateText value)?  updateText,TResult? Function( _UpdateBackground value)?  updateBackground,TResult? Function( _SelectImage value)?  selectImage,TResult? Function( _ReorderImages value)?  reorderImages,TResult? Function( _UpdateTextScale value)?  updateTextScale,TResult? Function( _ToggleDeviceFrame value)?  toggleDeviceFrame,TResult? Function( _UpdateImageSizeRatio value)?  updateImageSizeRatio,TResult? Function( _UpdateTextColor value)?  updateTextColor,}){
final _that = this;
switch (_that) {
case _SelectStore() when selectStore != null:
return selectStore(_that);case _SelectTemplate() when selectTemplate != null:
return selectTemplate(_that);case _AddImages() when addImages != null:
return addImages(_that);case _RemoveImage() when removeImage != null:
return removeImage(_that);case _UpdateText() when updateText != null:
return updateText(_that);case _UpdateBackground() when updateBackground != null:
return updateBackground(_that);case _SelectImage() when selectImage != null:
return selectImage(_that);case _ReorderImages() when reorderImages != null:
return reorderImages(_that);case _UpdateTextScale() when updateTextScale != null:
return updateTextScale(_that);case _ToggleDeviceFrame() when toggleDeviceFrame != null:
return toggleDeviceFrame(_that);case _UpdateImageSizeRatio() when updateImageSizeRatio != null:
return updateImageSizeRatio(_that);case _UpdateTextColor() when updateTextColor != null:
return updateTextColor(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( StoreType store)?  selectStore,TResult Function( int index)?  selectTemplate,TResult Function( List<String> paths)?  addImages,TResult Function( int index)?  removeImage,TResult Function( int index,  String text)?  updateText,TResult Function( BackgroundConfig background)?  updateBackground,TResult Function( int index)?  selectImage,TResult Function( int oldIndex,  int newIndex)?  reorderImages,TResult Function( double scale)?  updateTextScale,TResult Function( bool show)?  toggleDeviceFrame,TResult Function( double ratio)?  updateImageSizeRatio,TResult Function( Color color)?  updateTextColor,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SelectStore() when selectStore != null:
return selectStore(_that.store);case _SelectTemplate() when selectTemplate != null:
return selectTemplate(_that.index);case _AddImages() when addImages != null:
return addImages(_that.paths);case _RemoveImage() when removeImage != null:
return removeImage(_that.index);case _UpdateText() when updateText != null:
return updateText(_that.index,_that.text);case _UpdateBackground() when updateBackground != null:
return updateBackground(_that.background);case _SelectImage() when selectImage != null:
return selectImage(_that.index);case _ReorderImages() when reorderImages != null:
return reorderImages(_that.oldIndex,_that.newIndex);case _UpdateTextScale() when updateTextScale != null:
return updateTextScale(_that.scale);case _ToggleDeviceFrame() when toggleDeviceFrame != null:
return toggleDeviceFrame(_that.show);case _UpdateImageSizeRatio() when updateImageSizeRatio != null:
return updateImageSizeRatio(_that.ratio);case _UpdateTextColor() when updateTextColor != null:
return updateTextColor(_that.color);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( StoreType store)  selectStore,required TResult Function( int index)  selectTemplate,required TResult Function( List<String> paths)  addImages,required TResult Function( int index)  removeImage,required TResult Function( int index,  String text)  updateText,required TResult Function( BackgroundConfig background)  updateBackground,required TResult Function( int index)  selectImage,required TResult Function( int oldIndex,  int newIndex)  reorderImages,required TResult Function( double scale)  updateTextScale,required TResult Function( bool show)  toggleDeviceFrame,required TResult Function( double ratio)  updateImageSizeRatio,required TResult Function( Color color)  updateTextColor,}) {final _that = this;
switch (_that) {
case _SelectStore():
return selectStore(_that.store);case _SelectTemplate():
return selectTemplate(_that.index);case _AddImages():
return addImages(_that.paths);case _RemoveImage():
return removeImage(_that.index);case _UpdateText():
return updateText(_that.index,_that.text);case _UpdateBackground():
return updateBackground(_that.background);case _SelectImage():
return selectImage(_that.index);case _ReorderImages():
return reorderImages(_that.oldIndex,_that.newIndex);case _UpdateTextScale():
return updateTextScale(_that.scale);case _ToggleDeviceFrame():
return toggleDeviceFrame(_that.show);case _UpdateImageSizeRatio():
return updateImageSizeRatio(_that.ratio);case _UpdateTextColor():
return updateTextColor(_that.color);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( StoreType store)?  selectStore,TResult? Function( int index)?  selectTemplate,TResult? Function( List<String> paths)?  addImages,TResult? Function( int index)?  removeImage,TResult? Function( int index,  String text)?  updateText,TResult? Function( BackgroundConfig background)?  updateBackground,TResult? Function( int index)?  selectImage,TResult? Function( int oldIndex,  int newIndex)?  reorderImages,TResult? Function( double scale)?  updateTextScale,TResult? Function( bool show)?  toggleDeviceFrame,TResult? Function( double ratio)?  updateImageSizeRatio,TResult? Function( Color color)?  updateTextColor,}) {final _that = this;
switch (_that) {
case _SelectStore() when selectStore != null:
return selectStore(_that.store);case _SelectTemplate() when selectTemplate != null:
return selectTemplate(_that.index);case _AddImages() when addImages != null:
return addImages(_that.paths);case _RemoveImage() when removeImage != null:
return removeImage(_that.index);case _UpdateText() when updateText != null:
return updateText(_that.index,_that.text);case _UpdateBackground() when updateBackground != null:
return updateBackground(_that.background);case _SelectImage() when selectImage != null:
return selectImage(_that.index);case _ReorderImages() when reorderImages != null:
return reorderImages(_that.oldIndex,_that.newIndex);case _UpdateTextScale() when updateTextScale != null:
return updateTextScale(_that.scale);case _ToggleDeviceFrame() when toggleDeviceFrame != null:
return toggleDeviceFrame(_that.show);case _UpdateImageSizeRatio() when updateImageSizeRatio != null:
return updateImageSizeRatio(_that.ratio);case _UpdateTextColor() when updateTextColor != null:
return updateTextColor(_that.color);case _:
  return null;

}
}

}

/// @nodoc


class _SelectStore implements EditorEvent {
  const _SelectStore(this.store);
  

 final  StoreType store;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectStoreCopyWith<_SelectStore> get copyWith => __$SelectStoreCopyWithImpl<_SelectStore>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectStore&&(identical(other.store, store) || other.store == store));
}


@override
int get hashCode => Object.hash(runtimeType,store);

@override
String toString() {
  return 'EditorEvent.selectStore(store: $store)';
}


}

/// @nodoc
abstract mixin class _$SelectStoreCopyWith<$Res> implements $EditorEventCopyWith<$Res> {
  factory _$SelectStoreCopyWith(_SelectStore value, $Res Function(_SelectStore) _then) = __$SelectStoreCopyWithImpl;
@useResult
$Res call({
 StoreType store
});




}
/// @nodoc
class __$SelectStoreCopyWithImpl<$Res>
    implements _$SelectStoreCopyWith<$Res> {
  __$SelectStoreCopyWithImpl(this._self, this._then);

  final _SelectStore _self;
  final $Res Function(_SelectStore) _then;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? store = null,}) {
  return _then(_SelectStore(
null == store ? _self.store : store // ignore: cast_nullable_to_non_nullable
as StoreType,
  ));
}


}

/// @nodoc


class _SelectTemplate implements EditorEvent {
  const _SelectTemplate(this.index);
  

 final  int index;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectTemplateCopyWith<_SelectTemplate> get copyWith => __$SelectTemplateCopyWithImpl<_SelectTemplate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectTemplate&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode => Object.hash(runtimeType,index);

@override
String toString() {
  return 'EditorEvent.selectTemplate(index: $index)';
}


}

/// @nodoc
abstract mixin class _$SelectTemplateCopyWith<$Res> implements $EditorEventCopyWith<$Res> {
  factory _$SelectTemplateCopyWith(_SelectTemplate value, $Res Function(_SelectTemplate) _then) = __$SelectTemplateCopyWithImpl;
@useResult
$Res call({
 int index
});




}
/// @nodoc
class __$SelectTemplateCopyWithImpl<$Res>
    implements _$SelectTemplateCopyWith<$Res> {
  __$SelectTemplateCopyWithImpl(this._self, this._then);

  final _SelectTemplate _self;
  final $Res Function(_SelectTemplate) _then;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? index = null,}) {
  return _then(_SelectTemplate(
null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _AddImages implements EditorEvent {
  const _AddImages(final  List<String> paths): _paths = paths;
  

 final  List<String> _paths;
 List<String> get paths {
  if (_paths is EqualUnmodifiableListView) return _paths;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_paths);
}


/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddImagesCopyWith<_AddImages> get copyWith => __$AddImagesCopyWithImpl<_AddImages>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddImages&&const DeepCollectionEquality().equals(other._paths, _paths));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_paths));

@override
String toString() {
  return 'EditorEvent.addImages(paths: $paths)';
}


}

/// @nodoc
abstract mixin class _$AddImagesCopyWith<$Res> implements $EditorEventCopyWith<$Res> {
  factory _$AddImagesCopyWith(_AddImages value, $Res Function(_AddImages) _then) = __$AddImagesCopyWithImpl;
@useResult
$Res call({
 List<String> paths
});




}
/// @nodoc
class __$AddImagesCopyWithImpl<$Res>
    implements _$AddImagesCopyWith<$Res> {
  __$AddImagesCopyWithImpl(this._self, this._then);

  final _AddImages _self;
  final $Res Function(_AddImages) _then;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? paths = null,}) {
  return _then(_AddImages(
null == paths ? _self._paths : paths // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc


class _RemoveImage implements EditorEvent {
  const _RemoveImage(this.index);
  

 final  int index;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RemoveImageCopyWith<_RemoveImage> get copyWith => __$RemoveImageCopyWithImpl<_RemoveImage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RemoveImage&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode => Object.hash(runtimeType,index);

@override
String toString() {
  return 'EditorEvent.removeImage(index: $index)';
}


}

/// @nodoc
abstract mixin class _$RemoveImageCopyWith<$Res> implements $EditorEventCopyWith<$Res> {
  factory _$RemoveImageCopyWith(_RemoveImage value, $Res Function(_RemoveImage) _then) = __$RemoveImageCopyWithImpl;
@useResult
$Res call({
 int index
});




}
/// @nodoc
class __$RemoveImageCopyWithImpl<$Res>
    implements _$RemoveImageCopyWith<$Res> {
  __$RemoveImageCopyWithImpl(this._self, this._then);

  final _RemoveImage _self;
  final $Res Function(_RemoveImage) _then;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? index = null,}) {
  return _then(_RemoveImage(
null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _UpdateText implements EditorEvent {
  const _UpdateText({required this.index, required this.text});
  

 final  int index;
 final  String text;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateTextCopyWith<_UpdateText> get copyWith => __$UpdateTextCopyWithImpl<_UpdateText>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateText&&(identical(other.index, index) || other.index == index)&&(identical(other.text, text) || other.text == text));
}


@override
int get hashCode => Object.hash(runtimeType,index,text);

@override
String toString() {
  return 'EditorEvent.updateText(index: $index, text: $text)';
}


}

/// @nodoc
abstract mixin class _$UpdateTextCopyWith<$Res> implements $EditorEventCopyWith<$Res> {
  factory _$UpdateTextCopyWith(_UpdateText value, $Res Function(_UpdateText) _then) = __$UpdateTextCopyWithImpl;
@useResult
$Res call({
 int index, String text
});




}
/// @nodoc
class __$UpdateTextCopyWithImpl<$Res>
    implements _$UpdateTextCopyWith<$Res> {
  __$UpdateTextCopyWithImpl(this._self, this._then);

  final _UpdateText _self;
  final $Res Function(_UpdateText) _then;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? index = null,Object? text = null,}) {
  return _then(_UpdateText(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _UpdateBackground implements EditorEvent {
  const _UpdateBackground(this.background);
  

 final  BackgroundConfig background;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateBackgroundCopyWith<_UpdateBackground> get copyWith => __$UpdateBackgroundCopyWithImpl<_UpdateBackground>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateBackground&&(identical(other.background, background) || other.background == background));
}


@override
int get hashCode => Object.hash(runtimeType,background);

@override
String toString() {
  return 'EditorEvent.updateBackground(background: $background)';
}


}

/// @nodoc
abstract mixin class _$UpdateBackgroundCopyWith<$Res> implements $EditorEventCopyWith<$Res> {
  factory _$UpdateBackgroundCopyWith(_UpdateBackground value, $Res Function(_UpdateBackground) _then) = __$UpdateBackgroundCopyWithImpl;
@useResult
$Res call({
 BackgroundConfig background
});




}
/// @nodoc
class __$UpdateBackgroundCopyWithImpl<$Res>
    implements _$UpdateBackgroundCopyWith<$Res> {
  __$UpdateBackgroundCopyWithImpl(this._self, this._then);

  final _UpdateBackground _self;
  final $Res Function(_UpdateBackground) _then;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? background = null,}) {
  return _then(_UpdateBackground(
null == background ? _self.background : background // ignore: cast_nullable_to_non_nullable
as BackgroundConfig,
  ));
}


}

/// @nodoc


class _SelectImage implements EditorEvent {
  const _SelectImage(this.index);
  

 final  int index;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectImageCopyWith<_SelectImage> get copyWith => __$SelectImageCopyWithImpl<_SelectImage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectImage&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode => Object.hash(runtimeType,index);

@override
String toString() {
  return 'EditorEvent.selectImage(index: $index)';
}


}

/// @nodoc
abstract mixin class _$SelectImageCopyWith<$Res> implements $EditorEventCopyWith<$Res> {
  factory _$SelectImageCopyWith(_SelectImage value, $Res Function(_SelectImage) _then) = __$SelectImageCopyWithImpl;
@useResult
$Res call({
 int index
});




}
/// @nodoc
class __$SelectImageCopyWithImpl<$Res>
    implements _$SelectImageCopyWith<$Res> {
  __$SelectImageCopyWithImpl(this._self, this._then);

  final _SelectImage _self;
  final $Res Function(_SelectImage) _then;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? index = null,}) {
  return _then(_SelectImage(
null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _ReorderImages implements EditorEvent {
  const _ReorderImages({required this.oldIndex, required this.newIndex});
  

 final  int oldIndex;
 final  int newIndex;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReorderImagesCopyWith<_ReorderImages> get copyWith => __$ReorderImagesCopyWithImpl<_ReorderImages>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReorderImages&&(identical(other.oldIndex, oldIndex) || other.oldIndex == oldIndex)&&(identical(other.newIndex, newIndex) || other.newIndex == newIndex));
}


@override
int get hashCode => Object.hash(runtimeType,oldIndex,newIndex);

@override
String toString() {
  return 'EditorEvent.reorderImages(oldIndex: $oldIndex, newIndex: $newIndex)';
}


}

/// @nodoc
abstract mixin class _$ReorderImagesCopyWith<$Res> implements $EditorEventCopyWith<$Res> {
  factory _$ReorderImagesCopyWith(_ReorderImages value, $Res Function(_ReorderImages) _then) = __$ReorderImagesCopyWithImpl;
@useResult
$Res call({
 int oldIndex, int newIndex
});




}
/// @nodoc
class __$ReorderImagesCopyWithImpl<$Res>
    implements _$ReorderImagesCopyWith<$Res> {
  __$ReorderImagesCopyWithImpl(this._self, this._then);

  final _ReorderImages _self;
  final $Res Function(_ReorderImages) _then;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? oldIndex = null,Object? newIndex = null,}) {
  return _then(_ReorderImages(
oldIndex: null == oldIndex ? _self.oldIndex : oldIndex // ignore: cast_nullable_to_non_nullable
as int,newIndex: null == newIndex ? _self.newIndex : newIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _UpdateTextScale implements EditorEvent {
  const _UpdateTextScale(this.scale);
  

 final  double scale;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateTextScaleCopyWith<_UpdateTextScale> get copyWith => __$UpdateTextScaleCopyWithImpl<_UpdateTextScale>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateTextScale&&(identical(other.scale, scale) || other.scale == scale));
}


@override
int get hashCode => Object.hash(runtimeType,scale);

@override
String toString() {
  return 'EditorEvent.updateTextScale(scale: $scale)';
}


}

/// @nodoc
abstract mixin class _$UpdateTextScaleCopyWith<$Res> implements $EditorEventCopyWith<$Res> {
  factory _$UpdateTextScaleCopyWith(_UpdateTextScale value, $Res Function(_UpdateTextScale) _then) = __$UpdateTextScaleCopyWithImpl;
@useResult
$Res call({
 double scale
});




}
/// @nodoc
class __$UpdateTextScaleCopyWithImpl<$Res>
    implements _$UpdateTextScaleCopyWith<$Res> {
  __$UpdateTextScaleCopyWithImpl(this._self, this._then);

  final _UpdateTextScale _self;
  final $Res Function(_UpdateTextScale) _then;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? scale = null,}) {
  return _then(_UpdateTextScale(
null == scale ? _self.scale : scale // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc


class _ToggleDeviceFrame implements EditorEvent {
  const _ToggleDeviceFrame(this.show);
  

 final  bool show;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToggleDeviceFrameCopyWith<_ToggleDeviceFrame> get copyWith => __$ToggleDeviceFrameCopyWithImpl<_ToggleDeviceFrame>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleDeviceFrame&&(identical(other.show, show) || other.show == show));
}


@override
int get hashCode => Object.hash(runtimeType,show);

@override
String toString() {
  return 'EditorEvent.toggleDeviceFrame(show: $show)';
}


}

/// @nodoc
abstract mixin class _$ToggleDeviceFrameCopyWith<$Res> implements $EditorEventCopyWith<$Res> {
  factory _$ToggleDeviceFrameCopyWith(_ToggleDeviceFrame value, $Res Function(_ToggleDeviceFrame) _then) = __$ToggleDeviceFrameCopyWithImpl;
@useResult
$Res call({
 bool show
});




}
/// @nodoc
class __$ToggleDeviceFrameCopyWithImpl<$Res>
    implements _$ToggleDeviceFrameCopyWith<$Res> {
  __$ToggleDeviceFrameCopyWithImpl(this._self, this._then);

  final _ToggleDeviceFrame _self;
  final $Res Function(_ToggleDeviceFrame) _then;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? show = null,}) {
  return _then(_ToggleDeviceFrame(
null == show ? _self.show : show // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _UpdateImageSizeRatio implements EditorEvent {
  const _UpdateImageSizeRatio(this.ratio);
  

 final  double ratio;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateImageSizeRatioCopyWith<_UpdateImageSizeRatio> get copyWith => __$UpdateImageSizeRatioCopyWithImpl<_UpdateImageSizeRatio>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateImageSizeRatio&&(identical(other.ratio, ratio) || other.ratio == ratio));
}


@override
int get hashCode => Object.hash(runtimeType,ratio);

@override
String toString() {
  return 'EditorEvent.updateImageSizeRatio(ratio: $ratio)';
}


}

/// @nodoc
abstract mixin class _$UpdateImageSizeRatioCopyWith<$Res> implements $EditorEventCopyWith<$Res> {
  factory _$UpdateImageSizeRatioCopyWith(_UpdateImageSizeRatio value, $Res Function(_UpdateImageSizeRatio) _then) = __$UpdateImageSizeRatioCopyWithImpl;
@useResult
$Res call({
 double ratio
});




}
/// @nodoc
class __$UpdateImageSizeRatioCopyWithImpl<$Res>
    implements _$UpdateImageSizeRatioCopyWith<$Res> {
  __$UpdateImageSizeRatioCopyWithImpl(this._self, this._then);

  final _UpdateImageSizeRatio _self;
  final $Res Function(_UpdateImageSizeRatio) _then;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ratio = null,}) {
  return _then(_UpdateImageSizeRatio(
null == ratio ? _self.ratio : ratio // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc


class _UpdateTextColor implements EditorEvent {
  const _UpdateTextColor(this.color);
  

 final  Color color;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateTextColorCopyWith<_UpdateTextColor> get copyWith => __$UpdateTextColorCopyWithImpl<_UpdateTextColor>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateTextColor&&(identical(other.color, color) || other.color == color));
}


@override
int get hashCode => Object.hash(runtimeType,color);

@override
String toString() {
  return 'EditorEvent.updateTextColor(color: $color)';
}


}

/// @nodoc
abstract mixin class _$UpdateTextColorCopyWith<$Res> implements $EditorEventCopyWith<$Res> {
  factory _$UpdateTextColorCopyWith(_UpdateTextColor value, $Res Function(_UpdateTextColor) _then) = __$UpdateTextColorCopyWithImpl;
@useResult
$Res call({
 Color color
});




}
/// @nodoc
class __$UpdateTextColorCopyWithImpl<$Res>
    implements _$UpdateTextColorCopyWith<$Res> {
  __$UpdateTextColorCopyWithImpl(this._self, this._then);

  final _UpdateTextColor _self;
  final $Res Function(_UpdateTextColor) _then;

/// Create a copy of EditorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? color = null,}) {
  return _then(_UpdateTextColor(
null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}


}

/// @nodoc
mixin _$EditorState {

 StoreType get storeType; int get selectedTemplateIndex; List<String> get imagePaths; Map<String, List<String>> get textsPerImage; BackgroundConfig get background; int get selectedImageIndex; double get textScale; bool get showDeviceFrame; double get imageSizeRatio; Color get textColor;
/// Create a copy of EditorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditorStateCopyWith<EditorState> get copyWith => _$EditorStateCopyWithImpl<EditorState>(this as EditorState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditorState&&(identical(other.storeType, storeType) || other.storeType == storeType)&&(identical(other.selectedTemplateIndex, selectedTemplateIndex) || other.selectedTemplateIndex == selectedTemplateIndex)&&const DeepCollectionEquality().equals(other.imagePaths, imagePaths)&&const DeepCollectionEquality().equals(other.textsPerImage, textsPerImage)&&(identical(other.background, background) || other.background == background)&&(identical(other.selectedImageIndex, selectedImageIndex) || other.selectedImageIndex == selectedImageIndex)&&(identical(other.textScale, textScale) || other.textScale == textScale)&&(identical(other.showDeviceFrame, showDeviceFrame) || other.showDeviceFrame == showDeviceFrame)&&(identical(other.imageSizeRatio, imageSizeRatio) || other.imageSizeRatio == imageSizeRatio)&&(identical(other.textColor, textColor) || other.textColor == textColor));
}


@override
int get hashCode => Object.hash(runtimeType,storeType,selectedTemplateIndex,const DeepCollectionEquality().hash(imagePaths),const DeepCollectionEquality().hash(textsPerImage),background,selectedImageIndex,textScale,showDeviceFrame,imageSizeRatio,textColor);

@override
String toString() {
  return 'EditorState(storeType: $storeType, selectedTemplateIndex: $selectedTemplateIndex, imagePaths: $imagePaths, textsPerImage: $textsPerImage, background: $background, selectedImageIndex: $selectedImageIndex, textScale: $textScale, showDeviceFrame: $showDeviceFrame, imageSizeRatio: $imageSizeRatio, textColor: $textColor)';
}


}

/// @nodoc
abstract mixin class $EditorStateCopyWith<$Res>  {
  factory $EditorStateCopyWith(EditorState value, $Res Function(EditorState) _then) = _$EditorStateCopyWithImpl;
@useResult
$Res call({
 StoreType storeType, int selectedTemplateIndex, List<String> imagePaths, Map<String, List<String>> textsPerImage, BackgroundConfig background, int selectedImageIndex, double textScale, bool showDeviceFrame, double imageSizeRatio, Color textColor
});




}
/// @nodoc
class _$EditorStateCopyWithImpl<$Res>
    implements $EditorStateCopyWith<$Res> {
  _$EditorStateCopyWithImpl(this._self, this._then);

  final EditorState _self;
  final $Res Function(EditorState) _then;

/// Create a copy of EditorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? storeType = null,Object? selectedTemplateIndex = null,Object? imagePaths = null,Object? textsPerImage = null,Object? background = null,Object? selectedImageIndex = null,Object? textScale = null,Object? showDeviceFrame = null,Object? imageSizeRatio = null,Object? textColor = null,}) {
  return _then(_self.copyWith(
storeType: null == storeType ? _self.storeType : storeType // ignore: cast_nullable_to_non_nullable
as StoreType,selectedTemplateIndex: null == selectedTemplateIndex ? _self.selectedTemplateIndex : selectedTemplateIndex // ignore: cast_nullable_to_non_nullable
as int,imagePaths: null == imagePaths ? _self.imagePaths : imagePaths // ignore: cast_nullable_to_non_nullable
as List<String>,textsPerImage: null == textsPerImage ? _self.textsPerImage : textsPerImage // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,background: null == background ? _self.background : background // ignore: cast_nullable_to_non_nullable
as BackgroundConfig,selectedImageIndex: null == selectedImageIndex ? _self.selectedImageIndex : selectedImageIndex // ignore: cast_nullable_to_non_nullable
as int,textScale: null == textScale ? _self.textScale : textScale // ignore: cast_nullable_to_non_nullable
as double,showDeviceFrame: null == showDeviceFrame ? _self.showDeviceFrame : showDeviceFrame // ignore: cast_nullable_to_non_nullable
as bool,imageSizeRatio: null == imageSizeRatio ? _self.imageSizeRatio : imageSizeRatio // ignore: cast_nullable_to_non_nullable
as double,textColor: null == textColor ? _self.textColor : textColor // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}

}


/// Adds pattern-matching-related methods to [EditorState].
extension EditorStatePatterns on EditorState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EditorState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EditorState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EditorState value)  $default,){
final _that = this;
switch (_that) {
case _EditorState():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EditorState value)?  $default,){
final _that = this;
switch (_that) {
case _EditorState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( StoreType storeType,  int selectedTemplateIndex,  List<String> imagePaths,  Map<String, List<String>> textsPerImage,  BackgroundConfig background,  int selectedImageIndex,  double textScale,  bool showDeviceFrame,  double imageSizeRatio,  Color textColor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EditorState() when $default != null:
return $default(_that.storeType,_that.selectedTemplateIndex,_that.imagePaths,_that.textsPerImage,_that.background,_that.selectedImageIndex,_that.textScale,_that.showDeviceFrame,_that.imageSizeRatio,_that.textColor);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( StoreType storeType,  int selectedTemplateIndex,  List<String> imagePaths,  Map<String, List<String>> textsPerImage,  BackgroundConfig background,  int selectedImageIndex,  double textScale,  bool showDeviceFrame,  double imageSizeRatio,  Color textColor)  $default,) {final _that = this;
switch (_that) {
case _EditorState():
return $default(_that.storeType,_that.selectedTemplateIndex,_that.imagePaths,_that.textsPerImage,_that.background,_that.selectedImageIndex,_that.textScale,_that.showDeviceFrame,_that.imageSizeRatio,_that.textColor);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( StoreType storeType,  int selectedTemplateIndex,  List<String> imagePaths,  Map<String, List<String>> textsPerImage,  BackgroundConfig background,  int selectedImageIndex,  double textScale,  bool showDeviceFrame,  double imageSizeRatio,  Color textColor)?  $default,) {final _that = this;
switch (_that) {
case _EditorState() when $default != null:
return $default(_that.storeType,_that.selectedTemplateIndex,_that.imagePaths,_that.textsPerImage,_that.background,_that.selectedImageIndex,_that.textScale,_that.showDeviceFrame,_that.imageSizeRatio,_that.textColor);case _:
  return null;

}
}

}

/// @nodoc


class _EditorState extends EditorState {
  const _EditorState({this.storeType = StoreType.appStore, this.selectedTemplateIndex = 0, final  List<String> imagePaths = const [], final  Map<String, List<String>> textsPerImage = const {}, this.background = const BackgroundConfig(gradientColors: [Color(0xFF667EEA), Color(0xFF764BA2)]), this.selectedImageIndex = 0, this.textScale = 1.0, this.showDeviceFrame = false, this.imageSizeRatio = 0.80, this.textColor = const Color(0xFFFFFFFF)}): _imagePaths = imagePaths,_textsPerImage = textsPerImage,super._();
  

@override@JsonKey() final  StoreType storeType;
@override@JsonKey() final  int selectedTemplateIndex;
 final  List<String> _imagePaths;
@override@JsonKey() List<String> get imagePaths {
  if (_imagePaths is EqualUnmodifiableListView) return _imagePaths;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_imagePaths);
}

 final  Map<String, List<String>> _textsPerImage;
@override@JsonKey() Map<String, List<String>> get textsPerImage {
  if (_textsPerImage is EqualUnmodifiableMapView) return _textsPerImage;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_textsPerImage);
}

@override@JsonKey() final  BackgroundConfig background;
@override@JsonKey() final  int selectedImageIndex;
@override@JsonKey() final  double textScale;
@override@JsonKey() final  bool showDeviceFrame;
@override@JsonKey() final  double imageSizeRatio;
@override@JsonKey() final  Color textColor;

/// Create a copy of EditorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditorStateCopyWith<_EditorState> get copyWith => __$EditorStateCopyWithImpl<_EditorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditorState&&(identical(other.storeType, storeType) || other.storeType == storeType)&&(identical(other.selectedTemplateIndex, selectedTemplateIndex) || other.selectedTemplateIndex == selectedTemplateIndex)&&const DeepCollectionEquality().equals(other._imagePaths, _imagePaths)&&const DeepCollectionEquality().equals(other._textsPerImage, _textsPerImage)&&(identical(other.background, background) || other.background == background)&&(identical(other.selectedImageIndex, selectedImageIndex) || other.selectedImageIndex == selectedImageIndex)&&(identical(other.textScale, textScale) || other.textScale == textScale)&&(identical(other.showDeviceFrame, showDeviceFrame) || other.showDeviceFrame == showDeviceFrame)&&(identical(other.imageSizeRatio, imageSizeRatio) || other.imageSizeRatio == imageSizeRatio)&&(identical(other.textColor, textColor) || other.textColor == textColor));
}


@override
int get hashCode => Object.hash(runtimeType,storeType,selectedTemplateIndex,const DeepCollectionEquality().hash(_imagePaths),const DeepCollectionEquality().hash(_textsPerImage),background,selectedImageIndex,textScale,showDeviceFrame,imageSizeRatio,textColor);

@override
String toString() {
  return 'EditorState(storeType: $storeType, selectedTemplateIndex: $selectedTemplateIndex, imagePaths: $imagePaths, textsPerImage: $textsPerImage, background: $background, selectedImageIndex: $selectedImageIndex, textScale: $textScale, showDeviceFrame: $showDeviceFrame, imageSizeRatio: $imageSizeRatio, textColor: $textColor)';
}


}

/// @nodoc
abstract mixin class _$EditorStateCopyWith<$Res> implements $EditorStateCopyWith<$Res> {
  factory _$EditorStateCopyWith(_EditorState value, $Res Function(_EditorState) _then) = __$EditorStateCopyWithImpl;
@override @useResult
$Res call({
 StoreType storeType, int selectedTemplateIndex, List<String> imagePaths, Map<String, List<String>> textsPerImage, BackgroundConfig background, int selectedImageIndex, double textScale, bool showDeviceFrame, double imageSizeRatio, Color textColor
});




}
/// @nodoc
class __$EditorStateCopyWithImpl<$Res>
    implements _$EditorStateCopyWith<$Res> {
  __$EditorStateCopyWithImpl(this._self, this._then);

  final _EditorState _self;
  final $Res Function(_EditorState) _then;

/// Create a copy of EditorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? storeType = null,Object? selectedTemplateIndex = null,Object? imagePaths = null,Object? textsPerImage = null,Object? background = null,Object? selectedImageIndex = null,Object? textScale = null,Object? showDeviceFrame = null,Object? imageSizeRatio = null,Object? textColor = null,}) {
  return _then(_EditorState(
storeType: null == storeType ? _self.storeType : storeType // ignore: cast_nullable_to_non_nullable
as StoreType,selectedTemplateIndex: null == selectedTemplateIndex ? _self.selectedTemplateIndex : selectedTemplateIndex // ignore: cast_nullable_to_non_nullable
as int,imagePaths: null == imagePaths ? _self._imagePaths : imagePaths // ignore: cast_nullable_to_non_nullable
as List<String>,textsPerImage: null == textsPerImage ? _self._textsPerImage : textsPerImage // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,background: null == background ? _self.background : background // ignore: cast_nullable_to_non_nullable
as BackgroundConfig,selectedImageIndex: null == selectedImageIndex ? _self.selectedImageIndex : selectedImageIndex // ignore: cast_nullable_to_non_nullable
as int,textScale: null == textScale ? _self.textScale : textScale // ignore: cast_nullable_to_non_nullable
as double,showDeviceFrame: null == showDeviceFrame ? _self.showDeviceFrame : showDeviceFrame // ignore: cast_nullable_to_non_nullable
as bool,imageSizeRatio: null == imageSizeRatio ? _self.imageSizeRatio : imageSizeRatio // ignore: cast_nullable_to_non_nullable
as double,textColor: null == textColor ? _self.textColor : textColor // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}


}

// dart format on
