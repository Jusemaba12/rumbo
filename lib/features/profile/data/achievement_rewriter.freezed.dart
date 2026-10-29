// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'achievement_rewriter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AchievementSuggestion implements DiagnosticableTreeMixin {

 int? get index; String get original; String get rewritten; String get reason;
/// Create a copy of AchievementSuggestion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AchievementSuggestionCopyWith<AchievementSuggestion> get copyWith => _$AchievementSuggestionCopyWithImpl<AchievementSuggestion>(this as AchievementSuggestion, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  final _this = this as AchievementSuggestion;
  properties
    ..add(DiagnosticsProperty('type', 'AchievementSuggestion'))
    ..add(DiagnosticsProperty('index', _this.index))..add(DiagnosticsProperty('original', _this.original))..add(DiagnosticsProperty('rewritten', _this.rewritten))..add(DiagnosticsProperty('reason', _this.reason));
}

@override
bool operator ==(Object other) {
  final _this = this as AchievementSuggestion;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AchievementSuggestion&&(identical(other.index, _this.index) || other.index == _this.index)&&(identical(other.original, _this.original) || other.original == _this.original)&&(identical(other.rewritten, _this.rewritten) || other.rewritten == _this.rewritten)&&(identical(other.reason, _this.reason) || other.reason == _this.reason));
}


@override
int get hashCode {
  final _this = this as AchievementSuggestion;
  return Object.hash(runtimeType,_this.index,_this.original,_this.rewritten,_this.reason);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  final _this = this as AchievementSuggestion;
  return 'AchievementSuggestion(index: ${_this.index}, original: ${_this.original}, rewritten: ${_this.rewritten}, reason: ${_this.reason})';
}


}

/// @nodoc
abstract mixin class $AchievementSuggestionCopyWith<$Res>  {
  factory $AchievementSuggestionCopyWith(AchievementSuggestion value, $Res Function(AchievementSuggestion) _then) = _$AchievementSuggestionCopyWithImpl;
@useResult
$Res call({
 int? index, String original, String rewritten, String reason
});




}
/// @nodoc
class _$AchievementSuggestionCopyWithImpl<$Res>
    implements $AchievementSuggestionCopyWith<$Res> {
  _$AchievementSuggestionCopyWithImpl(this._self, this._then);

  final AchievementSuggestion _self;
  final $Res Function(AchievementSuggestion) _then;

/// Create a copy of AchievementSuggestion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? index = freezed,Object? original = null,Object? rewritten = null,Object? reason = null,}) {
  return _then(AchievementSuggestion(
index: freezed == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int?,original: null == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as String,rewritten: null == rewritten ? _self.rewritten : rewritten // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AchievementSuggestion].
extension AchievementSuggestionPatterns on AchievementSuggestion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AchievementSuggestion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AchievementSuggestion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AchievementSuggestion value)  $default,){
final _that = this;
switch (_that) {
case _AchievementSuggestion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AchievementSuggestion value)?  $default,){
final _that = this;
switch (_that) {
case _AchievementSuggestion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? index,  String original,  String rewritten,  String reason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AchievementSuggestion() when $default != null:
return $default(_that.index,_that.original,_that.rewritten,_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? index,  String original,  String rewritten,  String reason)  $default,) {final _that = this;
switch (_that) {
case _AchievementSuggestion():
return $default(_that.index,_that.original,_that.rewritten,_that.reason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? index,  String original,  String rewritten,  String reason)?  $default,) {final _that = this;
switch (_that) {
case _AchievementSuggestion() when $default != null:
return $default(_that.index,_that.original,_that.rewritten,_that.reason);case _:
  return null;

}
}

}

/// @nodoc


class _AchievementSuggestion with DiagnosticableTreeMixin implements AchievementSuggestion {
  const _AchievementSuggestion({required this.index, required this.original, required this.rewritten, this.reason = ''});
  

@override final  int? index;
@override final  String original;
@override final  String rewritten;
@override@JsonKey() final  String reason;

/// Create a copy of AchievementSuggestion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AchievementSuggestionCopyWith<_AchievementSuggestion> get copyWith => __$AchievementSuggestionCopyWithImpl<_AchievementSuggestion>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
    ..add(DiagnosticsProperty('type', 'AchievementSuggestion'))
    ..add(DiagnosticsProperty('index', index))..add(DiagnosticsProperty('original', original))..add(DiagnosticsProperty('rewritten', rewritten))..add(DiagnosticsProperty('reason', reason));
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AchievementSuggestion&&(identical(other.index, index) || other.index == index)&&(identical(other.original, original) || other.original == original)&&(identical(other.rewritten, rewritten) || other.rewritten == rewritten)&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode {
    return Object.hash(runtimeType,index,original,rewritten,reason);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
    return 'AchievementSuggestion(index: $index, original: $original, rewritten: $rewritten, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$AchievementSuggestionCopyWith<$Res> implements $AchievementSuggestionCopyWith<$Res> {
  factory _$AchievementSuggestionCopyWith(_AchievementSuggestion value, $Res Function(_AchievementSuggestion) _then) = __$AchievementSuggestionCopyWithImpl;
@override @useResult
$Res call({
 int? index, String original, String rewritten, String reason
});




}
/// @nodoc
class __$AchievementSuggestionCopyWithImpl<$Res>
    implements _$AchievementSuggestionCopyWith<$Res> {
  __$AchievementSuggestionCopyWithImpl(this._self, this._then);

  final _AchievementSuggestion _self;
  final $Res Function(_AchievementSuggestion) _then;

/// Create a copy of AchievementSuggestion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? index = freezed,Object? original = null,Object? rewritten = null,Object? reason = null,}) {
  return _then(_AchievementSuggestion(
index: freezed == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int?,original: null == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as String,rewritten: null == rewritten ? _self.rewritten : rewritten // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
