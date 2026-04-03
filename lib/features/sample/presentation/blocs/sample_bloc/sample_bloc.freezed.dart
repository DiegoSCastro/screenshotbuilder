// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sample_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SampleEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SampleEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SampleEvent()';
}


}

/// @nodoc
class $SampleEventCopyWith<$Res>  {
$SampleEventCopyWith(SampleEvent _, $Res Function(SampleEvent) __);
}


/// Adds pattern-matching-related methods to [SampleEvent].
extension SampleEventPatterns on SampleEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _GetUser value)?  getUser,TResult Function( _GetCliDetails value)?  getCliDetails,TResult Function( _ClearUserResponse value)?  clearUserResponse,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _GetUser() when getUser != null:
return getUser(_that);case _GetCliDetails() when getCliDetails != null:
return getCliDetails(_that);case _ClearUserResponse() when clearUserResponse != null:
return clearUserResponse(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _GetUser value)  getUser,required TResult Function( _GetCliDetails value)  getCliDetails,required TResult Function( _ClearUserResponse value)  clearUserResponse,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _GetUser():
return getUser(_that);case _GetCliDetails():
return getCliDetails(_that);case _ClearUserResponse():
return clearUserResponse(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _GetUser value)?  getUser,TResult? Function( _GetCliDetails value)?  getCliDetails,TResult? Function( _ClearUserResponse value)?  clearUserResponse,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _GetUser() when getUser != null:
return getUser(_that);case _GetCliDetails() when getCliDetails != null:
return getCliDetails(_that);case _ClearUserResponse() when clearUserResponse != null:
return clearUserResponse(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String username)?  getUser,TResult Function()?  getCliDetails,TResult Function()?  clearUserResponse,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _GetUser() when getUser != null:
return getUser(_that.username);case _GetCliDetails() when getCliDetails != null:
return getCliDetails();case _ClearUserResponse() when clearUserResponse != null:
return clearUserResponse();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String username)  getUser,required TResult Function()  getCliDetails,required TResult Function()  clearUserResponse,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _GetUser():
return getUser(_that.username);case _GetCliDetails():
return getCliDetails();case _ClearUserResponse():
return clearUserResponse();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String username)?  getUser,TResult? Function()?  getCliDetails,TResult? Function()?  clearUserResponse,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _GetUser() when getUser != null:
return getUser(_that.username);case _GetCliDetails() when getCliDetails != null:
return getCliDetails();case _ClearUserResponse() when clearUserResponse != null:
return clearUserResponse();case _:
  return null;

}
}

}

/// @nodoc


class _Started implements SampleEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SampleEvent.started()';
}


}




/// @nodoc


class _GetUser implements SampleEvent {
  const _GetUser(this.username);
  

 final  String username;

/// Create a copy of SampleEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetUserCopyWith<_GetUser> get copyWith => __$GetUserCopyWithImpl<_GetUser>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetUser&&(identical(other.username, username) || other.username == username));
}


@override
int get hashCode => Object.hash(runtimeType,username);

@override
String toString() {
  return 'SampleEvent.getUser(username: $username)';
}


}

/// @nodoc
abstract mixin class _$GetUserCopyWith<$Res> implements $SampleEventCopyWith<$Res> {
  factory _$GetUserCopyWith(_GetUser value, $Res Function(_GetUser) _then) = __$GetUserCopyWithImpl;
@useResult
$Res call({
 String username
});




}
/// @nodoc
class __$GetUserCopyWithImpl<$Res>
    implements _$GetUserCopyWith<$Res> {
  __$GetUserCopyWithImpl(this._self, this._then);

  final _GetUser _self;
  final $Res Function(_GetUser) _then;

/// Create a copy of SampleEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? username = null,}) {
  return _then(_GetUser(
null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _GetCliDetails implements SampleEvent {
  const _GetCliDetails();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetCliDetails);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SampleEvent.getCliDetails()';
}


}




/// @nodoc


class _ClearUserResponse implements SampleEvent {
  const _ClearUserResponse();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearUserResponse);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SampleEvent.clearUserResponse()';
}


}




/// @nodoc
mixin _$SampleState {

 bool get isUserLoading; String? get userError; UserEntity? get userResponse; bool get isCliLoading; String? get cliError; CliDetailsEntity? get cliDetails;
/// Create a copy of SampleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SampleStateCopyWith<SampleState> get copyWith => _$SampleStateCopyWithImpl<SampleState>(this as SampleState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SampleState&&(identical(other.isUserLoading, isUserLoading) || other.isUserLoading == isUserLoading)&&(identical(other.userError, userError) || other.userError == userError)&&(identical(other.userResponse, userResponse) || other.userResponse == userResponse)&&(identical(other.isCliLoading, isCliLoading) || other.isCliLoading == isCliLoading)&&(identical(other.cliError, cliError) || other.cliError == cliError)&&(identical(other.cliDetails, cliDetails) || other.cliDetails == cliDetails));
}


@override
int get hashCode => Object.hash(runtimeType,isUserLoading,userError,userResponse,isCliLoading,cliError,cliDetails);

@override
String toString() {
  return 'SampleState(isUserLoading: $isUserLoading, userError: $userError, userResponse: $userResponse, isCliLoading: $isCliLoading, cliError: $cliError, cliDetails: $cliDetails)';
}


}

/// @nodoc
abstract mixin class $SampleStateCopyWith<$Res>  {
  factory $SampleStateCopyWith(SampleState value, $Res Function(SampleState) _then) = _$SampleStateCopyWithImpl;
@useResult
$Res call({
 bool isUserLoading, String? userError, UserEntity? userResponse, bool isCliLoading, String? cliError, CliDetailsEntity? cliDetails
});




}
/// @nodoc
class _$SampleStateCopyWithImpl<$Res>
    implements $SampleStateCopyWith<$Res> {
  _$SampleStateCopyWithImpl(this._self, this._then);

  final SampleState _self;
  final $Res Function(SampleState) _then;

/// Create a copy of SampleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isUserLoading = null,Object? userError = freezed,Object? userResponse = freezed,Object? isCliLoading = null,Object? cliError = freezed,Object? cliDetails = freezed,}) {
  return _then(_self.copyWith(
isUserLoading: null == isUserLoading ? _self.isUserLoading : isUserLoading // ignore: cast_nullable_to_non_nullable
as bool,userError: freezed == userError ? _self.userError : userError // ignore: cast_nullable_to_non_nullable
as String?,userResponse: freezed == userResponse ? _self.userResponse : userResponse // ignore: cast_nullable_to_non_nullable
as UserEntity?,isCliLoading: null == isCliLoading ? _self.isCliLoading : isCliLoading // ignore: cast_nullable_to_non_nullable
as bool,cliError: freezed == cliError ? _self.cliError : cliError // ignore: cast_nullable_to_non_nullable
as String?,cliDetails: freezed == cliDetails ? _self.cliDetails : cliDetails // ignore: cast_nullable_to_non_nullable
as CliDetailsEntity?,
  ));
}

}


/// Adds pattern-matching-related methods to [SampleState].
extension SampleStatePatterns on SampleState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Initial value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Initial value)  $default,){
final _that = this;
switch (_that) {
case _Initial():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Initial value)?  $default,){
final _that = this;
switch (_that) {
case _Initial() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isUserLoading,  String? userError,  UserEntity? userResponse,  bool isCliLoading,  String? cliError,  CliDetailsEntity? cliDetails)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when $default != null:
return $default(_that.isUserLoading,_that.userError,_that.userResponse,_that.isCliLoading,_that.cliError,_that.cliDetails);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isUserLoading,  String? userError,  UserEntity? userResponse,  bool isCliLoading,  String? cliError,  CliDetailsEntity? cliDetails)  $default,) {final _that = this;
switch (_that) {
case _Initial():
return $default(_that.isUserLoading,_that.userError,_that.userResponse,_that.isCliLoading,_that.cliError,_that.cliDetails);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isUserLoading,  String? userError,  UserEntity? userResponse,  bool isCliLoading,  String? cliError,  CliDetailsEntity? cliDetails)?  $default,) {final _that = this;
switch (_that) {
case _Initial() when $default != null:
return $default(_that.isUserLoading,_that.userError,_that.userResponse,_that.isCliLoading,_that.cliError,_that.cliDetails);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements SampleState {
  const _Initial({this.isUserLoading = false, this.userError, this.userResponse, this.isCliLoading = false, this.cliError, this.cliDetails});
  

@override@JsonKey() final  bool isUserLoading;
@override final  String? userError;
@override final  UserEntity? userResponse;
@override@JsonKey() final  bool isCliLoading;
@override final  String? cliError;
@override final  CliDetailsEntity? cliDetails;

/// Create a copy of SampleState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InitialCopyWith<_Initial> get copyWith => __$InitialCopyWithImpl<_Initial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial&&(identical(other.isUserLoading, isUserLoading) || other.isUserLoading == isUserLoading)&&(identical(other.userError, userError) || other.userError == userError)&&(identical(other.userResponse, userResponse) || other.userResponse == userResponse)&&(identical(other.isCliLoading, isCliLoading) || other.isCliLoading == isCliLoading)&&(identical(other.cliError, cliError) || other.cliError == cliError)&&(identical(other.cliDetails, cliDetails) || other.cliDetails == cliDetails));
}


@override
int get hashCode => Object.hash(runtimeType,isUserLoading,userError,userResponse,isCliLoading,cliError,cliDetails);

@override
String toString() {
  return 'SampleState(isUserLoading: $isUserLoading, userError: $userError, userResponse: $userResponse, isCliLoading: $isCliLoading, cliError: $cliError, cliDetails: $cliDetails)';
}


}

/// @nodoc
abstract mixin class _$InitialCopyWith<$Res> implements $SampleStateCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) _then) = __$InitialCopyWithImpl;
@override @useResult
$Res call({
 bool isUserLoading, String? userError, UserEntity? userResponse, bool isCliLoading, String? cliError, CliDetailsEntity? cliDetails
});




}
/// @nodoc
class __$InitialCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(this._self, this._then);

  final _Initial _self;
  final $Res Function(_Initial) _then;

/// Create a copy of SampleState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isUserLoading = null,Object? userError = freezed,Object? userResponse = freezed,Object? isCliLoading = null,Object? cliError = freezed,Object? cliDetails = freezed,}) {
  return _then(_Initial(
isUserLoading: null == isUserLoading ? _self.isUserLoading : isUserLoading // ignore: cast_nullable_to_non_nullable
as bool,userError: freezed == userError ? _self.userError : userError // ignore: cast_nullable_to_non_nullable
as String?,userResponse: freezed == userResponse ? _self.userResponse : userResponse // ignore: cast_nullable_to_non_nullable
as UserEntity?,isCliLoading: null == isCliLoading ? _self.isCliLoading : isCliLoading // ignore: cast_nullable_to_non_nullable
as bool,cliError: freezed == cliError ? _self.cliError : cliError // ignore: cast_nullable_to_non_nullable
as String?,cliDetails: freezed == cliDetails ? _self.cliDetails : cliDetails // ignore: cast_nullable_to_non_nullable
as CliDetailsEntity?,
  ));
}


}

// dart format on
