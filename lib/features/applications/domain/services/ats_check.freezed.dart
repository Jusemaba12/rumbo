// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ats_check.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AtsCheck {

 AtsCheckKind get kind; bool get passed;/// Lo que falta (sección, cargo, habilidades…) cuando no pasa.
 String get detail;
/// Create a copy of AtsCheck
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AtsCheckCopyWith<AtsCheck> get copyWith => _$AtsCheckCopyWithImpl<AtsCheck>(this as AtsCheck, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AtsCheck;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AtsCheck&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.passed, _this.passed) || other.passed == _this.passed)&&(identical(other.detail, _this.detail) || other.detail == _this.detail));
}


@override
int get hashCode {
  final _this = this as AtsCheck;
  return Object.hash(runtimeType,_this.kind,_this.passed,_this.detail);
}

@override
String toString() {
  final _this = this as AtsCheck;
  return 'AtsCheck(kind: ${_this.kind}, passed: ${_this.passed}, detail: ${_this.detail})';
}


}

/// @nodoc
abstract mixin class $AtsCheckCopyWith<$Res>  {
  factory $AtsCheckCopyWith(AtsCheck value, $Res Function(AtsCheck) _then) = _$AtsCheckCopyWithImpl;
@useResult
$Res call({
 AtsCheckKind kind, bool passed, String detail
});




}
/// @nodoc
class _$AtsCheckCopyWithImpl<$Res>
    implements $AtsCheckCopyWith<$Res> {
  _$AtsCheckCopyWithImpl(this._self, this._then);

  final AtsCheck _self;
  final $Res Function(AtsCheck) _then;

/// Create a copy of AtsCheck
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? passed = null,Object? detail = null,}) {
  return _then(AtsCheck(
null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as AtsCheckKind,passed: null == passed ? _self.passed : passed // ignore: cast_nullable_to_non_nullable
as bool,detail: null == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AtsCheck].
extension AtsCheckPatterns on AtsCheck {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AtsCheck value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AtsCheck() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AtsCheck value)  $default,){
final _that = this;
switch (_that) {
case _AtsCheck():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AtsCheck value)?  $default,){
final _that = this;
switch (_that) {
case _AtsCheck() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AtsCheckKind kind,  bool passed,  String detail)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AtsCheck() when $default != null:
return $default(_that.kind,_that.passed,_that.detail);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AtsCheckKind kind,  bool passed,  String detail)  $default,) {final _that = this;
switch (_that) {
case _AtsCheck():
return $default(_that.kind,_that.passed,_that.detail);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AtsCheckKind kind,  bool passed,  String detail)?  $default,) {final _that = this;
switch (_that) {
case _AtsCheck() when $default != null:
return $default(_that.kind,_that.passed,_that.detail);case _:
  return null;

}
}

}

/// @nodoc


class _AtsCheck implements AtsCheck {
  const _AtsCheck(this.kind, {required this.passed, this.detail = ''});
  

@override final  AtsCheckKind kind;
@override final  bool passed;
/// Lo que falta (sección, cargo, habilidades…) cuando no pasa.
@override@JsonKey() final  String detail;

/// Create a copy of AtsCheck
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AtsCheckCopyWith<_AtsCheck> get copyWith => __$AtsCheckCopyWithImpl<_AtsCheck>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AtsCheck&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.passed, passed) || other.passed == passed)&&(identical(other.detail, detail) || other.detail == detail));
}


@override
int get hashCode {
    return Object.hash(runtimeType,kind,passed,detail);
}

@override
String toString() {
    return 'AtsCheck(kind: $kind, passed: $passed, detail: $detail)';
}


}

/// @nodoc
abstract mixin class _$AtsCheckCopyWith<$Res> implements $AtsCheckCopyWith<$Res> {
  factory _$AtsCheckCopyWith(_AtsCheck value, $Res Function(_AtsCheck) _then) = __$AtsCheckCopyWithImpl;
@override @useResult
$Res call({
 AtsCheckKind kind, bool passed, String detail
});




}
/// @nodoc
class __$AtsCheckCopyWithImpl<$Res>
    implements _$AtsCheckCopyWith<$Res> {
  __$AtsCheckCopyWithImpl(this._self, this._then);

  final _AtsCheck _self;
  final $Res Function(_AtsCheck) _then;

/// Create a copy of AtsCheck
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? passed = null,Object? detail = null,}) {
  return _then(_AtsCheck(
null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as AtsCheckKind,passed: null == passed ? _self.passed : passed // ignore: cast_nullable_to_non_nullable
as bool,detail: null == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
