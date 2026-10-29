// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'keyword_coverage.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$KeywordCoverage {

/// Palabras clave que pide la oferta.
 List<String> get keywords; Set<String> get inBase; Set<String> get inTailored;
/// Create a copy of KeywordCoverage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KeywordCoverageCopyWith<KeywordCoverage> get copyWith => _$KeywordCoverageCopyWithImpl<KeywordCoverage>(this as KeywordCoverage, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as KeywordCoverage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KeywordCoverage&&const DeepCollectionEquality().equals(other.keywords, _this.keywords)&&const DeepCollectionEquality().equals(other.inBase, _this.inBase)&&const DeepCollectionEquality().equals(other.inTailored, _this.inTailored));
}


@override
int get hashCode {
  final _this = this as KeywordCoverage;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.keywords),const DeepCollectionEquality().hash(_this.inBase),const DeepCollectionEquality().hash(_this.inTailored));
}

@override
String toString() {
  final _this = this as KeywordCoverage;
  return 'KeywordCoverage(keywords: ${_this.keywords}, inBase: ${_this.inBase}, inTailored: ${_this.inTailored})';
}


}

/// @nodoc
abstract mixin class $KeywordCoverageCopyWith<$Res>  {
  factory $KeywordCoverageCopyWith(KeywordCoverage value, $Res Function(KeywordCoverage) _then) = _$KeywordCoverageCopyWithImpl;
@useResult
$Res call({
 List<String> keywords, Set<String> inBase, Set<String> inTailored
});




}
/// @nodoc
class _$KeywordCoverageCopyWithImpl<$Res>
    implements $KeywordCoverageCopyWith<$Res> {
  _$KeywordCoverageCopyWithImpl(this._self, this._then);

  final KeywordCoverage _self;
  final $Res Function(KeywordCoverage) _then;

/// Create a copy of KeywordCoverage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? keywords = null,Object? inBase = null,Object? inTailored = null,}) {
  return _then(KeywordCoverage(
keywords: null == keywords ? _self.keywords : keywords // ignore: cast_nullable_to_non_nullable
as List<String>,inBase: null == inBase ? _self.inBase : inBase // ignore: cast_nullable_to_non_nullable
as Set<String>,inTailored: null == inTailored ? _self.inTailored : inTailored // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [KeywordCoverage].
extension KeywordCoveragePatterns on KeywordCoverage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KeywordCoverage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KeywordCoverage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KeywordCoverage value)  $default,){
final _that = this;
switch (_that) {
case _KeywordCoverage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KeywordCoverage value)?  $default,){
final _that = this;
switch (_that) {
case _KeywordCoverage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> keywords,  Set<String> inBase,  Set<String> inTailored)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KeywordCoverage() when $default != null:
return $default(_that.keywords,_that.inBase,_that.inTailored);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> keywords,  Set<String> inBase,  Set<String> inTailored)  $default,) {final _that = this;
switch (_that) {
case _KeywordCoverage():
return $default(_that.keywords,_that.inBase,_that.inTailored);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> keywords,  Set<String> inBase,  Set<String> inTailored)?  $default,) {final _that = this;
switch (_that) {
case _KeywordCoverage() when $default != null:
return $default(_that.keywords,_that.inBase,_that.inTailored);case _:
  return null;

}
}

}

/// @nodoc


class _KeywordCoverage extends KeywordCoverage {
  const _KeywordCoverage({required  List<String> keywords, required  Set<String> inBase, required  Set<String> inTailored}): _keywords = keywords,_inBase = inBase,_inTailored = inTailored,super._();
  

/// Palabras clave que pide la oferta.
 final  List<String> _keywords;
/// Palabras clave que pide la oferta.
@override List<String> get keywords {
  if (_keywords is EqualUnmodifiableListView) return _keywords;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_keywords);
}

 final  Set<String> _inBase;
@override Set<String> get inBase {
  if (_inBase is EqualUnmodifiableSetView) return _inBase;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_inBase);
}

 final  Set<String> _inTailored;
@override Set<String> get inTailored {
  if (_inTailored is EqualUnmodifiableSetView) return _inTailored;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_inTailored);
}


/// Create a copy of KeywordCoverage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KeywordCoverageCopyWith<_KeywordCoverage> get copyWith => __$KeywordCoverageCopyWithImpl<_KeywordCoverage>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _KeywordCoverage&&const DeepCollectionEquality().equals(other.keywords, _keywords)&&const DeepCollectionEquality().equals(other.inBase, _inBase)&&const DeepCollectionEquality().equals(other.inTailored, _inTailored));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_keywords),const DeepCollectionEquality().hash(_inBase),const DeepCollectionEquality().hash(_inTailored));
}

@override
String toString() {
    return 'KeywordCoverage(keywords: $keywords, inBase: $inBase, inTailored: $inTailored)';
}


}

/// @nodoc
abstract mixin class _$KeywordCoverageCopyWith<$Res> implements $KeywordCoverageCopyWith<$Res> {
  factory _$KeywordCoverageCopyWith(_KeywordCoverage value, $Res Function(_KeywordCoverage) _then) = __$KeywordCoverageCopyWithImpl;
@override @useResult
$Res call({
 List<String> keywords, Set<String> inBase, Set<String> inTailored
});




}
/// @nodoc
class __$KeywordCoverageCopyWithImpl<$Res>
    implements _$KeywordCoverageCopyWith<$Res> {
  __$KeywordCoverageCopyWithImpl(this._self, this._then);

  final _KeywordCoverage _self;
  final $Res Function(_KeywordCoverage) _then;

/// Create a copy of KeywordCoverage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? keywords = null,Object? inBase = null,Object? inTailored = null,}) {
  return _then(_KeywordCoverage(
keywords: null == keywords ? _self._keywords : keywords // ignore: cast_nullable_to_non_nullable
as List<String>,inBase: null == inBase ? _self._inBase : inBase // ignore: cast_nullable_to_non_nullable
as Set<String>,inTailored: null == inTailored ? _self._inTailored : inTailored // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}


}

// dart format on
