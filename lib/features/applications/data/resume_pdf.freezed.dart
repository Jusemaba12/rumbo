// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resume_pdf.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ResumeHeadings {

 String get locale; String get summary; String get experience; String get education; String get skills; String get present;
/// Create a copy of ResumeHeadings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResumeHeadingsCopyWith<ResumeHeadings> get copyWith => _$ResumeHeadingsCopyWithImpl<ResumeHeadings>(this as ResumeHeadings, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ResumeHeadings;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResumeHeadings&&(identical(other.locale, _this.locale) || other.locale == _this.locale)&&(identical(other.summary, _this.summary) || other.summary == _this.summary)&&(identical(other.experience, _this.experience) || other.experience == _this.experience)&&(identical(other.education, _this.education) || other.education == _this.education)&&(identical(other.skills, _this.skills) || other.skills == _this.skills)&&(identical(other.present, _this.present) || other.present == _this.present));
}


@override
int get hashCode {
  final _this = this as ResumeHeadings;
  return Object.hash(runtimeType,_this.locale,_this.summary,_this.experience,_this.education,_this.skills,_this.present);
}

@override
String toString() {
  final _this = this as ResumeHeadings;
  return 'ResumeHeadings(locale: ${_this.locale}, summary: ${_this.summary}, experience: ${_this.experience}, education: ${_this.education}, skills: ${_this.skills}, present: ${_this.present})';
}


}

/// @nodoc
abstract mixin class $ResumeHeadingsCopyWith<$Res>  {
  factory $ResumeHeadingsCopyWith(ResumeHeadings value, $Res Function(ResumeHeadings) _then) = _$ResumeHeadingsCopyWithImpl;
@useResult
$Res call({
 String locale, String summary, String experience, String education, String skills, String present
});




}
/// @nodoc
class _$ResumeHeadingsCopyWithImpl<$Res>
    implements $ResumeHeadingsCopyWith<$Res> {
  _$ResumeHeadingsCopyWithImpl(this._self, this._then);

  final ResumeHeadings _self;
  final $Res Function(ResumeHeadings) _then;

/// Create a copy of ResumeHeadings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? locale = null,Object? summary = null,Object? experience = null,Object? education = null,Object? skills = null,Object? present = null,}) {
  return _then(ResumeHeadings(
null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,null == experience ? _self.experience : experience // ignore: cast_nullable_to_non_nullable
as String,null == education ? _self.education : education // ignore: cast_nullable_to_non_nullable
as String,null == skills ? _self.skills : skills // ignore: cast_nullable_to_non_nullable
as String,null == present ? _self.present : present // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ResumeHeadings].
extension ResumeHeadingsPatterns on ResumeHeadings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResumeHeadings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResumeHeadings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResumeHeadings value)  $default,){
final _that = this;
switch (_that) {
case _ResumeHeadings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResumeHeadings value)?  $default,){
final _that = this;
switch (_that) {
case _ResumeHeadings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String locale,  String summary,  String experience,  String education,  String skills,  String present)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResumeHeadings() when $default != null:
return $default(_that.locale,_that.summary,_that.experience,_that.education,_that.skills,_that.present);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String locale,  String summary,  String experience,  String education,  String skills,  String present)  $default,) {final _that = this;
switch (_that) {
case _ResumeHeadings():
return $default(_that.locale,_that.summary,_that.experience,_that.education,_that.skills,_that.present);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String locale,  String summary,  String experience,  String education,  String skills,  String present)?  $default,) {final _that = this;
switch (_that) {
case _ResumeHeadings() when $default != null:
return $default(_that.locale,_that.summary,_that.experience,_that.education,_that.skills,_that.present);case _:
  return null;

}
}

}

/// @nodoc


class _ResumeHeadings implements ResumeHeadings {
  const _ResumeHeadings(this.locale, this.summary, this.experience, this.education, this.skills, this.present);
  

@override final  String locale;
@override final  String summary;
@override final  String experience;
@override final  String education;
@override final  String skills;
@override final  String present;

/// Create a copy of ResumeHeadings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResumeHeadingsCopyWith<_ResumeHeadings> get copyWith => __$ResumeHeadingsCopyWithImpl<_ResumeHeadings>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResumeHeadings&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.experience, experience) || other.experience == experience)&&(identical(other.education, education) || other.education == education)&&(identical(other.skills, skills) || other.skills == skills)&&(identical(other.present, present) || other.present == present));
}


@override
int get hashCode {
    return Object.hash(runtimeType,locale,summary,experience,education,skills,present);
}

@override
String toString() {
    return 'ResumeHeadings(locale: $locale, summary: $summary, experience: $experience, education: $education, skills: $skills, present: $present)';
}


}

/// @nodoc
abstract mixin class _$ResumeHeadingsCopyWith<$Res> implements $ResumeHeadingsCopyWith<$Res> {
  factory _$ResumeHeadingsCopyWith(_ResumeHeadings value, $Res Function(_ResumeHeadings) _then) = __$ResumeHeadingsCopyWithImpl;
@override @useResult
$Res call({
 String locale, String summary, String experience, String education, String skills, String present
});




}
/// @nodoc
class __$ResumeHeadingsCopyWithImpl<$Res>
    implements _$ResumeHeadingsCopyWith<$Res> {
  __$ResumeHeadingsCopyWithImpl(this._self, this._then);

  final _ResumeHeadings _self;
  final $Res Function(_ResumeHeadings) _then;

/// Create a copy of ResumeHeadings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? locale = null,Object? summary = null,Object? experience = null,Object? education = null,Object? skills = null,Object? present = null,}) {
  return _then(_ResumeHeadings(
null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,null == experience ? _self.experience : experience // ignore: cast_nullable_to_non_nullable
as String,null == education ? _self.education : education // ignore: cast_nullable_to_non_nullable
as String,null == skills ? _self.skills : skills // ignore: cast_nullable_to_non_nullable
as String,null == present ? _self.present : present // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
