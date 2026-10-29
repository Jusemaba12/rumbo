// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$JobFilter {

 bool get remoteOnly; bool get goodMatchOnly; bool get recentOnly;/// Portal de origen (`job.source`); nulo para todos.
 String? get source;
/// Create a copy of JobFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobFilterCopyWith<JobFilter> get copyWith => _$JobFilterCopyWithImpl<JobFilter>(this as JobFilter, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as JobFilter;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobFilter&&(identical(other.remoteOnly, _this.remoteOnly) || other.remoteOnly == _this.remoteOnly)&&(identical(other.goodMatchOnly, _this.goodMatchOnly) || other.goodMatchOnly == _this.goodMatchOnly)&&(identical(other.recentOnly, _this.recentOnly) || other.recentOnly == _this.recentOnly)&&(identical(other.source, _this.source) || other.source == _this.source));
}


@override
int get hashCode {
  final _this = this as JobFilter;
  return Object.hash(runtimeType,_this.remoteOnly,_this.goodMatchOnly,_this.recentOnly,_this.source);
}

@override
String toString() {
  final _this = this as JobFilter;
  return 'JobFilter(remoteOnly: ${_this.remoteOnly}, goodMatchOnly: ${_this.goodMatchOnly}, recentOnly: ${_this.recentOnly}, source: ${_this.source})';
}


}

/// @nodoc
abstract mixin class $JobFilterCopyWith<$Res>  {
  factory $JobFilterCopyWith(JobFilter value, $Res Function(JobFilter) _then) = _$JobFilterCopyWithImpl;
@useResult
$Res call({
 bool remoteOnly, bool goodMatchOnly, bool recentOnly, String? source
});




}
/// @nodoc
class _$JobFilterCopyWithImpl<$Res>
    implements $JobFilterCopyWith<$Res> {
  _$JobFilterCopyWithImpl(this._self, this._then);

  final JobFilter _self;
  final $Res Function(JobFilter) _then;

/// Create a copy of JobFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? remoteOnly = null,Object? goodMatchOnly = null,Object? recentOnly = null,Object? source = freezed,}) {
  return _then(JobFilter(
remoteOnly: null == remoteOnly ? _self.remoteOnly : remoteOnly // ignore: cast_nullable_to_non_nullable
as bool,goodMatchOnly: null == goodMatchOnly ? _self.goodMatchOnly : goodMatchOnly // ignore: cast_nullable_to_non_nullable
as bool,recentOnly: null == recentOnly ? _self.recentOnly : recentOnly // ignore: cast_nullable_to_non_nullable
as bool,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [JobFilter].
extension JobFilterPatterns on JobFilter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobFilter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobFilter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobFilter value)  $default,){
final _that = this;
switch (_that) {
case _JobFilter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobFilter value)?  $default,){
final _that = this;
switch (_that) {
case _JobFilter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool remoteOnly,  bool goodMatchOnly,  bool recentOnly,  String? source)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobFilter() when $default != null:
return $default(_that.remoteOnly,_that.goodMatchOnly,_that.recentOnly,_that.source);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool remoteOnly,  bool goodMatchOnly,  bool recentOnly,  String? source)  $default,) {final _that = this;
switch (_that) {
case _JobFilter():
return $default(_that.remoteOnly,_that.goodMatchOnly,_that.recentOnly,_that.source);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool remoteOnly,  bool goodMatchOnly,  bool recentOnly,  String? source)?  $default,) {final _that = this;
switch (_that) {
case _JobFilter() when $default != null:
return $default(_that.remoteOnly,_that.goodMatchOnly,_that.recentOnly,_that.source);case _:
  return null;

}
}

}

/// @nodoc


class _JobFilter extends JobFilter {
  const _JobFilter({this.remoteOnly = false, this.goodMatchOnly = false, this.recentOnly = false, this.source}): super._();
  

@override@JsonKey() final  bool remoteOnly;
@override@JsonKey() final  bool goodMatchOnly;
@override@JsonKey() final  bool recentOnly;
/// Portal de origen (`job.source`); nulo para todos.
@override final  String? source;

/// Create a copy of JobFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobFilterCopyWith<_JobFilter> get copyWith => __$JobFilterCopyWithImpl<_JobFilter>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobFilter&&(identical(other.remoteOnly, remoteOnly) || other.remoteOnly == remoteOnly)&&(identical(other.goodMatchOnly, goodMatchOnly) || other.goodMatchOnly == goodMatchOnly)&&(identical(other.recentOnly, recentOnly) || other.recentOnly == recentOnly)&&(identical(other.source, source) || other.source == source));
}


@override
int get hashCode {
    return Object.hash(runtimeType,remoteOnly,goodMatchOnly,recentOnly,source);
}

@override
String toString() {
    return 'JobFilter(remoteOnly: $remoteOnly, goodMatchOnly: $goodMatchOnly, recentOnly: $recentOnly, source: $source)';
}


}

/// @nodoc
abstract mixin class _$JobFilterCopyWith<$Res> implements $JobFilterCopyWith<$Res> {
  factory _$JobFilterCopyWith(_JobFilter value, $Res Function(_JobFilter) _then) = __$JobFilterCopyWithImpl;
@override @useResult
$Res call({
 bool remoteOnly, bool goodMatchOnly, bool recentOnly, String? source
});




}
/// @nodoc
class __$JobFilterCopyWithImpl<$Res>
    implements _$JobFilterCopyWith<$Res> {
  __$JobFilterCopyWithImpl(this._self, this._then);

  final _JobFilter _self;
  final $Res Function(_JobFilter) _then;

/// Create a copy of JobFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? remoteOnly = null,Object? goodMatchOnly = null,Object? recentOnly = null,Object? source = freezed,}) {
  return _then(_JobFilter(
remoteOnly: null == remoteOnly ? _self.remoteOnly : remoteOnly // ignore: cast_nullable_to_non_nullable
as bool,goodMatchOnly: null == goodMatchOnly ? _self.goodMatchOnly : goodMatchOnly // ignore: cast_nullable_to_non_nullable
as bool,recentOnly: null == recentOnly ? _self.recentOnly : recentOnly // ignore: cast_nullable_to_non_nullable
as bool,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
