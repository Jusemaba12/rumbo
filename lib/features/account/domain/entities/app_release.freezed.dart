// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_release.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppRelease {

 String get versionName;/// El número tras el «+» de `version` en pubspec.yaml.
 int get versionCode; String get downloadUrl; String get notes;
/// Create a copy of AppRelease
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppReleaseCopyWith<AppRelease> get copyWith => _$AppReleaseCopyWithImpl<AppRelease>(this as AppRelease, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AppRelease;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppRelease&&(identical(other.versionName, _this.versionName) || other.versionName == _this.versionName)&&(identical(other.versionCode, _this.versionCode) || other.versionCode == _this.versionCode)&&(identical(other.downloadUrl, _this.downloadUrl) || other.downloadUrl == _this.downloadUrl)&&(identical(other.notes, _this.notes) || other.notes == _this.notes));
}


@override
int get hashCode {
  final _this = this as AppRelease;
  return Object.hash(runtimeType,_this.versionName,_this.versionCode,_this.downloadUrl,_this.notes);
}

@override
String toString() {
  final _this = this as AppRelease;
  return 'AppRelease(versionName: ${_this.versionName}, versionCode: ${_this.versionCode}, downloadUrl: ${_this.downloadUrl}, notes: ${_this.notes})';
}


}

/// @nodoc
abstract mixin class $AppReleaseCopyWith<$Res>  {
  factory $AppReleaseCopyWith(AppRelease value, $Res Function(AppRelease) _then) = _$AppReleaseCopyWithImpl;
@useResult
$Res call({
 String versionName, int versionCode, String downloadUrl, String notes
});




}
/// @nodoc
class _$AppReleaseCopyWithImpl<$Res>
    implements $AppReleaseCopyWith<$Res> {
  _$AppReleaseCopyWithImpl(this._self, this._then);

  final AppRelease _self;
  final $Res Function(AppRelease) _then;

/// Create a copy of AppRelease
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? versionName = null,Object? versionCode = null,Object? downloadUrl = null,Object? notes = null,}) {
  return _then(AppRelease(
versionName: null == versionName ? _self.versionName : versionName // ignore: cast_nullable_to_non_nullable
as String,versionCode: null == versionCode ? _self.versionCode : versionCode // ignore: cast_nullable_to_non_nullable
as int,downloadUrl: null == downloadUrl ? _self.downloadUrl : downloadUrl // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AppRelease].
extension AppReleasePatterns on AppRelease {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppRelease value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppRelease() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppRelease value)  $default,){
final _that = this;
switch (_that) {
case _AppRelease():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppRelease value)?  $default,){
final _that = this;
switch (_that) {
case _AppRelease() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String versionName,  int versionCode,  String downloadUrl,  String notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppRelease() when $default != null:
return $default(_that.versionName,_that.versionCode,_that.downloadUrl,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String versionName,  int versionCode,  String downloadUrl,  String notes)  $default,) {final _that = this;
switch (_that) {
case _AppRelease():
return $default(_that.versionName,_that.versionCode,_that.downloadUrl,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String versionName,  int versionCode,  String downloadUrl,  String notes)?  $default,) {final _that = this;
switch (_that) {
case _AppRelease() when $default != null:
return $default(_that.versionName,_that.versionCode,_that.downloadUrl,_that.notes);case _:
  return null;

}
}

}

/// @nodoc


class _AppRelease extends AppRelease {
  const _AppRelease({required this.versionName, required this.versionCode, required this.downloadUrl, this.notes = ''}): super._();
  

@override final  String versionName;
/// El número tras el «+» de `version` en pubspec.yaml.
@override final  int versionCode;
@override final  String downloadUrl;
@override@JsonKey() final  String notes;

/// Create a copy of AppRelease
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppReleaseCopyWith<_AppRelease> get copyWith => __$AppReleaseCopyWithImpl<_AppRelease>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppRelease&&(identical(other.versionName, versionName) || other.versionName == versionName)&&(identical(other.versionCode, versionCode) || other.versionCode == versionCode)&&(identical(other.downloadUrl, downloadUrl) || other.downloadUrl == downloadUrl)&&(identical(other.notes, notes) || other.notes == notes));
}


@override
int get hashCode {
    return Object.hash(runtimeType,versionName,versionCode,downloadUrl,notes);
}

@override
String toString() {
    return 'AppRelease(versionName: $versionName, versionCode: $versionCode, downloadUrl: $downloadUrl, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$AppReleaseCopyWith<$Res> implements $AppReleaseCopyWith<$Res> {
  factory _$AppReleaseCopyWith(_AppRelease value, $Res Function(_AppRelease) _then) = __$AppReleaseCopyWithImpl;
@override @useResult
$Res call({
 String versionName, int versionCode, String downloadUrl, String notes
});




}
/// @nodoc
class __$AppReleaseCopyWithImpl<$Res>
    implements _$AppReleaseCopyWith<$Res> {
  __$AppReleaseCopyWithImpl(this._self, this._then);

  final _AppRelease _self;
  final $Res Function(_AppRelease) _then;

/// Create a copy of AppRelease
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? versionName = null,Object? versionCode = null,Object? downloadUrl = null,Object? notes = null,}) {
  return _then(_AppRelease(
versionName: null == versionName ? _self.versionName : versionName // ignore: cast_nullable_to_non_nullable
as String,versionCode: null == versionCode ? _self.versionCode : versionCode // ignore: cast_nullable_to_non_nullable
as int,downloadUrl: null == downloadUrl ? _self.downloadUrl : downloadUrl // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
