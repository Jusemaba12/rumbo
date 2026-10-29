// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'keyword_analysis.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$KeywordPresence {

 bool get inExperience; bool get inSummary; bool get inSkills; bool get inProjects;
/// Create a copy of KeywordPresence
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KeywordPresenceCopyWith<KeywordPresence> get copyWith => _$KeywordPresenceCopyWithImpl<KeywordPresence>(this as KeywordPresence, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as KeywordPresence;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KeywordPresence&&(identical(other.inExperience, _this.inExperience) || other.inExperience == _this.inExperience)&&(identical(other.inSummary, _this.inSummary) || other.inSummary == _this.inSummary)&&(identical(other.inSkills, _this.inSkills) || other.inSkills == _this.inSkills)&&(identical(other.inProjects, _this.inProjects) || other.inProjects == _this.inProjects));
}


@override
int get hashCode {
  final _this = this as KeywordPresence;
  return Object.hash(runtimeType,_this.inExperience,_this.inSummary,_this.inSkills,_this.inProjects);
}

@override
String toString() {
  final _this = this as KeywordPresence;
  return 'KeywordPresence(inExperience: ${_this.inExperience}, inSummary: ${_this.inSummary}, inSkills: ${_this.inSkills}, inProjects: ${_this.inProjects})';
}


}

/// @nodoc
abstract mixin class $KeywordPresenceCopyWith<$Res>  {
  factory $KeywordPresenceCopyWith(KeywordPresence value, $Res Function(KeywordPresence) _then) = _$KeywordPresenceCopyWithImpl;
@useResult
$Res call({
 bool inExperience, bool inSummary, bool inSkills, bool inProjects
});




}
/// @nodoc
class _$KeywordPresenceCopyWithImpl<$Res>
    implements $KeywordPresenceCopyWith<$Res> {
  _$KeywordPresenceCopyWithImpl(this._self, this._then);

  final KeywordPresence _self;
  final $Res Function(KeywordPresence) _then;

/// Create a copy of KeywordPresence
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? inExperience = null,Object? inSummary = null,Object? inSkills = null,Object? inProjects = null,}) {
  return _then(KeywordPresence(
inExperience: null == inExperience ? _self.inExperience : inExperience // ignore: cast_nullable_to_non_nullable
as bool,inSummary: null == inSummary ? _self.inSummary : inSummary // ignore: cast_nullable_to_non_nullable
as bool,inSkills: null == inSkills ? _self.inSkills : inSkills // ignore: cast_nullable_to_non_nullable
as bool,inProjects: null == inProjects ? _self.inProjects : inProjects // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [KeywordPresence].
extension KeywordPresencePatterns on KeywordPresence {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KeywordPresence value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KeywordPresence() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KeywordPresence value)  $default,){
final _that = this;
switch (_that) {
case _KeywordPresence():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KeywordPresence value)?  $default,){
final _that = this;
switch (_that) {
case _KeywordPresence() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool inExperience,  bool inSummary,  bool inSkills,  bool inProjects)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KeywordPresence() when $default != null:
return $default(_that.inExperience,_that.inSummary,_that.inSkills,_that.inProjects);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool inExperience,  bool inSummary,  bool inSkills,  bool inProjects)  $default,) {final _that = this;
switch (_that) {
case _KeywordPresence():
return $default(_that.inExperience,_that.inSummary,_that.inSkills,_that.inProjects);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool inExperience,  bool inSummary,  bool inSkills,  bool inProjects)?  $default,) {final _that = this;
switch (_that) {
case _KeywordPresence() when $default != null:
return $default(_that.inExperience,_that.inSummary,_that.inSkills,_that.inProjects);case _:
  return null;

}
}

}

/// @nodoc


class _KeywordPresence extends KeywordPresence {
  const _KeywordPresence({this.inExperience = false, this.inSummary = false, this.inSkills = false, this.inProjects = false}): super._();
  

@override@JsonKey() final  bool inExperience;
@override@JsonKey() final  bool inSummary;
@override@JsonKey() final  bool inSkills;
@override@JsonKey() final  bool inProjects;

/// Create a copy of KeywordPresence
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KeywordPresenceCopyWith<_KeywordPresence> get copyWith => __$KeywordPresenceCopyWithImpl<_KeywordPresence>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _KeywordPresence&&(identical(other.inExperience, inExperience) || other.inExperience == inExperience)&&(identical(other.inSummary, inSummary) || other.inSummary == inSummary)&&(identical(other.inSkills, inSkills) || other.inSkills == inSkills)&&(identical(other.inProjects, inProjects) || other.inProjects == inProjects));
}


@override
int get hashCode {
    return Object.hash(runtimeType,inExperience,inSummary,inSkills,inProjects);
}

@override
String toString() {
    return 'KeywordPresence(inExperience: $inExperience, inSummary: $inSummary, inSkills: $inSkills, inProjects: $inProjects)';
}


}

/// @nodoc
abstract mixin class _$KeywordPresenceCopyWith<$Res> implements $KeywordPresenceCopyWith<$Res> {
  factory _$KeywordPresenceCopyWith(_KeywordPresence value, $Res Function(_KeywordPresence) _then) = __$KeywordPresenceCopyWithImpl;
@override @useResult
$Res call({
 bool inExperience, bool inSummary, bool inSkills, bool inProjects
});




}
/// @nodoc
class __$KeywordPresenceCopyWithImpl<$Res>
    implements _$KeywordPresenceCopyWith<$Res> {
  __$KeywordPresenceCopyWithImpl(this._self, this._then);

  final _KeywordPresence _self;
  final $Res Function(_KeywordPresence) _then;

/// Create a copy of KeywordPresence
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? inExperience = null,Object? inSummary = null,Object? inSkills = null,Object? inProjects = null,}) {
  return _then(_KeywordPresence(
inExperience: null == inExperience ? _self.inExperience : inExperience // ignore: cast_nullable_to_non_nullable
as bool,inSummary: null == inSummary ? _self.inSummary : inSummary // ignore: cast_nullable_to_non_nullable
as bool,inSkills: null == inSkills ? _self.inSkills : inSkills // ignore: cast_nullable_to_non_nullable
as bool,inProjects: null == inProjects ? _self.inProjects : inProjects // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
