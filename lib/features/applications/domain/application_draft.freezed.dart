// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'application_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TailoredExperience {

 String get experienceId; String get company; String get role; DateTime get startDate; DateTime? get endDate; List<String> get bullets;
/// Create a copy of TailoredExperience
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TailoredExperienceCopyWith<TailoredExperience> get copyWith => _$TailoredExperienceCopyWithImpl<TailoredExperience>(this as TailoredExperience, _$identity);

  /// Serializes this TailoredExperience to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TailoredExperience;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TailoredExperience&&(identical(other.experienceId, _this.experienceId) || other.experienceId == _this.experienceId)&&(identical(other.company, _this.company) || other.company == _this.company)&&(identical(other.role, _this.role) || other.role == _this.role)&&(identical(other.startDate, _this.startDate) || other.startDate == _this.startDate)&&(identical(other.endDate, _this.endDate) || other.endDate == _this.endDate)&&const DeepCollectionEquality().equals(other.bullets, _this.bullets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TailoredExperience;
  return Object.hash(runtimeType,_this.experienceId,_this.company,_this.role,_this.startDate,_this.endDate,const DeepCollectionEquality().hash(_this.bullets));
}

@override
String toString() {
  final _this = this as TailoredExperience;
  return 'TailoredExperience(experienceId: ${_this.experienceId}, company: ${_this.company}, role: ${_this.role}, startDate: ${_this.startDate}, endDate: ${_this.endDate}, bullets: ${_this.bullets})';
}


}

/// @nodoc
abstract mixin class $TailoredExperienceCopyWith<$Res>  {
  factory $TailoredExperienceCopyWith(TailoredExperience value, $Res Function(TailoredExperience) _then) = _$TailoredExperienceCopyWithImpl;
@useResult
$Res call({
 String experienceId, String company, String role, DateTime startDate, DateTime? endDate, List<String> bullets
});




}
/// @nodoc
class _$TailoredExperienceCopyWithImpl<$Res>
    implements $TailoredExperienceCopyWith<$Res> {
  _$TailoredExperienceCopyWithImpl(this._self, this._then);

  final TailoredExperience _self;
  final $Res Function(TailoredExperience) _then;

/// Create a copy of TailoredExperience
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? experienceId = null,Object? company = null,Object? role = null,Object? startDate = null,Object? endDate = freezed,Object? bullets = null,}) {
  return _then(TailoredExperience(
experienceId: null == experienceId ? _self.experienceId : experienceId // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,bullets: null == bullets ? _self.bullets : bullets // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [TailoredExperience].
extension TailoredExperiencePatterns on TailoredExperience {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TailoredExperience value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TailoredExperience() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TailoredExperience value)  $default,){
final _that = this;
switch (_that) {
case _TailoredExperience():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TailoredExperience value)?  $default,){
final _that = this;
switch (_that) {
case _TailoredExperience() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String experienceId,  String company,  String role,  DateTime startDate,  DateTime? endDate,  List<String> bullets)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TailoredExperience() when $default != null:
return $default(_that.experienceId,_that.company,_that.role,_that.startDate,_that.endDate,_that.bullets);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String experienceId,  String company,  String role,  DateTime startDate,  DateTime? endDate,  List<String> bullets)  $default,) {final _that = this;
switch (_that) {
case _TailoredExperience():
return $default(_that.experienceId,_that.company,_that.role,_that.startDate,_that.endDate,_that.bullets);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String experienceId,  String company,  String role,  DateTime startDate,  DateTime? endDate,  List<String> bullets)?  $default,) {final _that = this;
switch (_that) {
case _TailoredExperience() when $default != null:
return $default(_that.experienceId,_that.company,_that.role,_that.startDate,_that.endDate,_that.bullets);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TailoredExperience implements TailoredExperience {
  const _TailoredExperience({required this.experienceId, required this.company, required this.role, required this.startDate, this.endDate,  List<String> bullets = const []}): _bullets = bullets;
  factory _TailoredExperience.fromJson(Map<String, dynamic> json) => _$TailoredExperienceFromJson(json);

@override final  String experienceId;
@override final  String company;
@override final  String role;
@override final  DateTime startDate;
@override final  DateTime? endDate;
 final  List<String> _bullets;
@override@JsonKey() List<String> get bullets {
  if (_bullets is EqualUnmodifiableListView) return _bullets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bullets);
}


/// Create a copy of TailoredExperience
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TailoredExperienceCopyWith<_TailoredExperience> get copyWith => __$TailoredExperienceCopyWithImpl<_TailoredExperience>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TailoredExperienceToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TailoredExperience&&(identical(other.experienceId, experienceId) || other.experienceId == experienceId)&&(identical(other.company, company) || other.company == company)&&(identical(other.role, role) || other.role == role)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&const DeepCollectionEquality().equals(other.bullets, _bullets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,experienceId,company,role,startDate,endDate,const DeepCollectionEquality().hash(_bullets));
}

@override
String toString() {
    return 'TailoredExperience(experienceId: $experienceId, company: $company, role: $role, startDate: $startDate, endDate: $endDate, bullets: $bullets)';
}


}

/// @nodoc
abstract mixin class _$TailoredExperienceCopyWith<$Res> implements $TailoredExperienceCopyWith<$Res> {
  factory _$TailoredExperienceCopyWith(_TailoredExperience value, $Res Function(_TailoredExperience) _then) = __$TailoredExperienceCopyWithImpl;
@override @useResult
$Res call({
 String experienceId, String company, String role, DateTime startDate, DateTime? endDate, List<String> bullets
});




}
/// @nodoc
class __$TailoredExperienceCopyWithImpl<$Res>
    implements _$TailoredExperienceCopyWith<$Res> {
  __$TailoredExperienceCopyWithImpl(this._self, this._then);

  final _TailoredExperience _self;
  final $Res Function(_TailoredExperience) _then;

/// Create a copy of TailoredExperience
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? experienceId = null,Object? company = null,Object? role = null,Object? startDate = null,Object? endDate = freezed,Object? bullets = null,}) {
  return _then(_TailoredExperience(
experienceId: null == experienceId ? _self.experienceId : experienceId // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,bullets: null == bullets ? _self._bullets : bullets // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$TailoredResume {

 String get headline; String get summary; List<TailoredExperience> get experiences; List<String> get skills;
/// Create a copy of TailoredResume
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TailoredResumeCopyWith<TailoredResume> get copyWith => _$TailoredResumeCopyWithImpl<TailoredResume>(this as TailoredResume, _$identity);

  /// Serializes this TailoredResume to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TailoredResume;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TailoredResume&&(identical(other.headline, _this.headline) || other.headline == _this.headline)&&(identical(other.summary, _this.summary) || other.summary == _this.summary)&&const DeepCollectionEquality().equals(other.experiences, _this.experiences)&&const DeepCollectionEquality().equals(other.skills, _this.skills));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TailoredResume;
  return Object.hash(runtimeType,_this.headline,_this.summary,const DeepCollectionEquality().hash(_this.experiences),const DeepCollectionEquality().hash(_this.skills));
}

@override
String toString() {
  final _this = this as TailoredResume;
  return 'TailoredResume(headline: ${_this.headline}, summary: ${_this.summary}, experiences: ${_this.experiences}, skills: ${_this.skills})';
}


}

/// @nodoc
abstract mixin class $TailoredResumeCopyWith<$Res>  {
  factory $TailoredResumeCopyWith(TailoredResume value, $Res Function(TailoredResume) _then) = _$TailoredResumeCopyWithImpl;
@useResult
$Res call({
 String headline, String summary, List<TailoredExperience> experiences, List<String> skills
});




}
/// @nodoc
class _$TailoredResumeCopyWithImpl<$Res>
    implements $TailoredResumeCopyWith<$Res> {
  _$TailoredResumeCopyWithImpl(this._self, this._then);

  final TailoredResume _self;
  final $Res Function(TailoredResume) _then;

/// Create a copy of TailoredResume
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? headline = null,Object? summary = null,Object? experiences = null,Object? skills = null,}) {
  return _then(TailoredResume(
headline: null == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,experiences: null == experiences ? _self.experiences : experiences // ignore: cast_nullable_to_non_nullable
as List<TailoredExperience>,skills: null == skills ? _self.skills : skills // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [TailoredResume].
extension TailoredResumePatterns on TailoredResume {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TailoredResume value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TailoredResume() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TailoredResume value)  $default,){
final _that = this;
switch (_that) {
case _TailoredResume():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TailoredResume value)?  $default,){
final _that = this;
switch (_that) {
case _TailoredResume() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String headline,  String summary,  List<TailoredExperience> experiences,  List<String> skills)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TailoredResume() when $default != null:
return $default(_that.headline,_that.summary,_that.experiences,_that.skills);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String headline,  String summary,  List<TailoredExperience> experiences,  List<String> skills)  $default,) {final _that = this;
switch (_that) {
case _TailoredResume():
return $default(_that.headline,_that.summary,_that.experiences,_that.skills);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String headline,  String summary,  List<TailoredExperience> experiences,  List<String> skills)?  $default,) {final _that = this;
switch (_that) {
case _TailoredResume() when $default != null:
return $default(_that.headline,_that.summary,_that.experiences,_that.skills);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TailoredResume implements TailoredResume {
  const _TailoredResume({this.headline = '', this.summary = '',  List<TailoredExperience> experiences = const [],  List<String> skills = const []}): _experiences = experiences,_skills = skills;
  factory _TailoredResume.fromJson(Map<String, dynamic> json) => _$TailoredResumeFromJson(json);

@override@JsonKey() final  String headline;
@override@JsonKey() final  String summary;
 final  List<TailoredExperience> _experiences;
@override@JsonKey() List<TailoredExperience> get experiences {
  if (_experiences is EqualUnmodifiableListView) return _experiences;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_experiences);
}

 final  List<String> _skills;
@override@JsonKey() List<String> get skills {
  if (_skills is EqualUnmodifiableListView) return _skills;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_skills);
}


/// Create a copy of TailoredResume
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TailoredResumeCopyWith<_TailoredResume> get copyWith => __$TailoredResumeCopyWithImpl<_TailoredResume>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TailoredResumeToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TailoredResume&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other.experiences, _experiences)&&const DeepCollectionEquality().equals(other.skills, _skills));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,headline,summary,const DeepCollectionEquality().hash(_experiences),const DeepCollectionEquality().hash(_skills));
}

@override
String toString() {
    return 'TailoredResume(headline: $headline, summary: $summary, experiences: $experiences, skills: $skills)';
}


}

/// @nodoc
abstract mixin class _$TailoredResumeCopyWith<$Res> implements $TailoredResumeCopyWith<$Res> {
  factory _$TailoredResumeCopyWith(_TailoredResume value, $Res Function(_TailoredResume) _then) = __$TailoredResumeCopyWithImpl;
@override @useResult
$Res call({
 String headline, String summary, List<TailoredExperience> experiences, List<String> skills
});




}
/// @nodoc
class __$TailoredResumeCopyWithImpl<$Res>
    implements _$TailoredResumeCopyWith<$Res> {
  __$TailoredResumeCopyWithImpl(this._self, this._then);

  final _TailoredResume _self;
  final $Res Function(_TailoredResume) _then;

/// Create a copy of TailoredResume
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? headline = null,Object? summary = null,Object? experiences = null,Object? skills = null,}) {
  return _then(_TailoredResume(
headline: null == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,experiences: null == experiences ? _self._experiences : experiences // ignore: cast_nullable_to_non_nullable
as List<TailoredExperience>,skills: null == skills ? _self._skills : skills // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$ResumeChange {

 String get section; String get before; String get after; String get reason;
/// Create a copy of ResumeChange
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResumeChangeCopyWith<ResumeChange> get copyWith => _$ResumeChangeCopyWithImpl<ResumeChange>(this as ResumeChange, _$identity);

  /// Serializes this ResumeChange to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ResumeChange;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResumeChange&&(identical(other.section, _this.section) || other.section == _this.section)&&(identical(other.before, _this.before) || other.before == _this.before)&&(identical(other.after, _this.after) || other.after == _this.after)&&(identical(other.reason, _this.reason) || other.reason == _this.reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ResumeChange;
  return Object.hash(runtimeType,_this.section,_this.before,_this.after,_this.reason);
}

@override
String toString() {
  final _this = this as ResumeChange;
  return 'ResumeChange(section: ${_this.section}, before: ${_this.before}, after: ${_this.after}, reason: ${_this.reason})';
}


}

/// @nodoc
abstract mixin class $ResumeChangeCopyWith<$Res>  {
  factory $ResumeChangeCopyWith(ResumeChange value, $Res Function(ResumeChange) _then) = _$ResumeChangeCopyWithImpl;
@useResult
$Res call({
 String section, String before, String after, String reason
});




}
/// @nodoc
class _$ResumeChangeCopyWithImpl<$Res>
    implements $ResumeChangeCopyWith<$Res> {
  _$ResumeChangeCopyWithImpl(this._self, this._then);

  final ResumeChange _self;
  final $Res Function(ResumeChange) _then;

/// Create a copy of ResumeChange
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? section = null,Object? before = null,Object? after = null,Object? reason = null,}) {
  return _then(ResumeChange(
section: null == section ? _self.section : section // ignore: cast_nullable_to_non_nullable
as String,before: null == before ? _self.before : before // ignore: cast_nullable_to_non_nullable
as String,after: null == after ? _self.after : after // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ResumeChange].
extension ResumeChangePatterns on ResumeChange {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResumeChange value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResumeChange() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResumeChange value)  $default,){
final _that = this;
switch (_that) {
case _ResumeChange():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResumeChange value)?  $default,){
final _that = this;
switch (_that) {
case _ResumeChange() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String section,  String before,  String after,  String reason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResumeChange() when $default != null:
return $default(_that.section,_that.before,_that.after,_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String section,  String before,  String after,  String reason)  $default,) {final _that = this;
switch (_that) {
case _ResumeChange():
return $default(_that.section,_that.before,_that.after,_that.reason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String section,  String before,  String after,  String reason)?  $default,) {final _that = this;
switch (_that) {
case _ResumeChange() when $default != null:
return $default(_that.section,_that.before,_that.after,_that.reason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ResumeChange implements ResumeChange {
  const _ResumeChange({required this.section, this.before = '', this.after = '', this.reason = ''});
  factory _ResumeChange.fromJson(Map<String, dynamic> json) => _$ResumeChangeFromJson(json);

@override final  String section;
@override@JsonKey() final  String before;
@override@JsonKey() final  String after;
@override@JsonKey() final  String reason;

/// Create a copy of ResumeChange
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResumeChangeCopyWith<_ResumeChange> get copyWith => __$ResumeChangeCopyWithImpl<_ResumeChange>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResumeChangeToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResumeChange&&(identical(other.section, section) || other.section == section)&&(identical(other.before, before) || other.before == before)&&(identical(other.after, after) || other.after == after)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,section,before,after,reason);
}

@override
String toString() {
    return 'ResumeChange(section: $section, before: $before, after: $after, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$ResumeChangeCopyWith<$Res> implements $ResumeChangeCopyWith<$Res> {
  factory _$ResumeChangeCopyWith(_ResumeChange value, $Res Function(_ResumeChange) _then) = __$ResumeChangeCopyWithImpl;
@override @useResult
$Res call({
 String section, String before, String after, String reason
});




}
/// @nodoc
class __$ResumeChangeCopyWithImpl<$Res>
    implements _$ResumeChangeCopyWith<$Res> {
  __$ResumeChangeCopyWithImpl(this._self, this._then);

  final _ResumeChange _self;
  final $Res Function(_ResumeChange) _then;

/// Create a copy of ResumeChange
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? section = null,Object? before = null,Object? after = null,Object? reason = null,}) {
  return _then(_ResumeChange(
section: null == section ? _self.section : section // ignore: cast_nullable_to_non_nullable
as String,before: null == before ? _self.before : before // ignore: cast_nullable_to_non_nullable
as String,after: null == after ? _self.after : after // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ApplicationDraft {

 String get jobId; ResumeLanguage get language; TailoredResume get resume; String get coverLetter; List<ResumeChange> get changes; List<String> get keywords;/// Frases que el validador descartó por no estar en el perfil.
 List<String> get rejected;
/// Create a copy of ApplicationDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApplicationDraftCopyWith<ApplicationDraft> get copyWith => _$ApplicationDraftCopyWithImpl<ApplicationDraft>(this as ApplicationDraft, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ApplicationDraft;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApplicationDraft&&(identical(other.jobId, _this.jobId) || other.jobId == _this.jobId)&&(identical(other.language, _this.language) || other.language == _this.language)&&(identical(other.resume, _this.resume) || other.resume == _this.resume)&&(identical(other.coverLetter, _this.coverLetter) || other.coverLetter == _this.coverLetter)&&const DeepCollectionEquality().equals(other.changes, _this.changes)&&const DeepCollectionEquality().equals(other.keywords, _this.keywords)&&const DeepCollectionEquality().equals(other.rejected, _this.rejected));
}


@override
int get hashCode {
  final _this = this as ApplicationDraft;
  return Object.hash(runtimeType,_this.jobId,_this.language,_this.resume,_this.coverLetter,const DeepCollectionEquality().hash(_this.changes),const DeepCollectionEquality().hash(_this.keywords),const DeepCollectionEquality().hash(_this.rejected));
}

@override
String toString() {
  final _this = this as ApplicationDraft;
  return 'ApplicationDraft(jobId: ${_this.jobId}, language: ${_this.language}, resume: ${_this.resume}, coverLetter: ${_this.coverLetter}, changes: ${_this.changes}, keywords: ${_this.keywords}, rejected: ${_this.rejected})';
}


}

/// @nodoc
abstract mixin class $ApplicationDraftCopyWith<$Res>  {
  factory $ApplicationDraftCopyWith(ApplicationDraft value, $Res Function(ApplicationDraft) _then) = _$ApplicationDraftCopyWithImpl;
@useResult
$Res call({
 String jobId, ResumeLanguage language, TailoredResume resume, String coverLetter, List<ResumeChange> changes, List<String> keywords, List<String> rejected
});


$TailoredResumeCopyWith<$Res> get resume;

}
/// @nodoc
class _$ApplicationDraftCopyWithImpl<$Res>
    implements $ApplicationDraftCopyWith<$Res> {
  _$ApplicationDraftCopyWithImpl(this._self, this._then);

  final ApplicationDraft _self;
  final $Res Function(ApplicationDraft) _then;

/// Create a copy of ApplicationDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? jobId = null,Object? language = null,Object? resume = null,Object? coverLetter = null,Object? changes = null,Object? keywords = null,Object? rejected = null,}) {
  return _then(ApplicationDraft(
jobId: null == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as ResumeLanguage,resume: null == resume ? _self.resume : resume // ignore: cast_nullable_to_non_nullable
as TailoredResume,coverLetter: null == coverLetter ? _self.coverLetter : coverLetter // ignore: cast_nullable_to_non_nullable
as String,changes: null == changes ? _self.changes : changes // ignore: cast_nullable_to_non_nullable
as List<ResumeChange>,keywords: null == keywords ? _self.keywords : keywords // ignore: cast_nullable_to_non_nullable
as List<String>,rejected: null == rejected ? _self.rejected : rejected // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of ApplicationDraft
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TailoredResumeCopyWith<$Res> get resume {
  
  return $TailoredResumeCopyWith<$Res>(_self.resume, (value) {
    return _then(_self.copyWith(resume: value));
  });
}
}


/// Adds pattern-matching-related methods to [ApplicationDraft].
extension ApplicationDraftPatterns on ApplicationDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApplicationDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApplicationDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApplicationDraft value)  $default,){
final _that = this;
switch (_that) {
case _ApplicationDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApplicationDraft value)?  $default,){
final _that = this;
switch (_that) {
case _ApplicationDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String jobId,  ResumeLanguage language,  TailoredResume resume,  String coverLetter,  List<ResumeChange> changes,  List<String> keywords,  List<String> rejected)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApplicationDraft() when $default != null:
return $default(_that.jobId,_that.language,_that.resume,_that.coverLetter,_that.changes,_that.keywords,_that.rejected);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String jobId,  ResumeLanguage language,  TailoredResume resume,  String coverLetter,  List<ResumeChange> changes,  List<String> keywords,  List<String> rejected)  $default,) {final _that = this;
switch (_that) {
case _ApplicationDraft():
return $default(_that.jobId,_that.language,_that.resume,_that.coverLetter,_that.changes,_that.keywords,_that.rejected);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String jobId,  ResumeLanguage language,  TailoredResume resume,  String coverLetter,  List<ResumeChange> changes,  List<String> keywords,  List<String> rejected)?  $default,) {final _that = this;
switch (_that) {
case _ApplicationDraft() when $default != null:
return $default(_that.jobId,_that.language,_that.resume,_that.coverLetter,_that.changes,_that.keywords,_that.rejected);case _:
  return null;

}
}

}

/// @nodoc


class _ApplicationDraft implements ApplicationDraft {
  const _ApplicationDraft({required this.jobId, this.language = ResumeLanguage.es, required this.resume, this.coverLetter = '',  List<ResumeChange> changes = const [],  List<String> keywords = const [],  List<String> rejected = const []}): _changes = changes,_keywords = keywords,_rejected = rejected;
  

@override final  String jobId;
@override@JsonKey() final  ResumeLanguage language;
@override final  TailoredResume resume;
@override@JsonKey() final  String coverLetter;
 final  List<ResumeChange> _changes;
@override@JsonKey() List<ResumeChange> get changes {
  if (_changes is EqualUnmodifiableListView) return _changes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_changes);
}

 final  List<String> _keywords;
@override@JsonKey() List<String> get keywords {
  if (_keywords is EqualUnmodifiableListView) return _keywords;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_keywords);
}

/// Frases que el validador descartó por no estar en el perfil.
 final  List<String> _rejected;
/// Frases que el validador descartó por no estar en el perfil.
@override@JsonKey() List<String> get rejected {
  if (_rejected is EqualUnmodifiableListView) return _rejected;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rejected);
}


/// Create a copy of ApplicationDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApplicationDraftCopyWith<_ApplicationDraft> get copyWith => __$ApplicationDraftCopyWithImpl<_ApplicationDraft>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApplicationDraft&&(identical(other.jobId, jobId) || other.jobId == jobId)&&(identical(other.language, language) || other.language == language)&&(identical(other.resume, resume) || other.resume == resume)&&(identical(other.coverLetter, coverLetter) || other.coverLetter == coverLetter)&&const DeepCollectionEquality().equals(other.changes, _changes)&&const DeepCollectionEquality().equals(other.keywords, _keywords)&&const DeepCollectionEquality().equals(other.rejected, _rejected));
}


@override
int get hashCode {
    return Object.hash(runtimeType,jobId,language,resume,coverLetter,const DeepCollectionEquality().hash(_changes),const DeepCollectionEquality().hash(_keywords),const DeepCollectionEquality().hash(_rejected));
}

@override
String toString() {
    return 'ApplicationDraft(jobId: $jobId, language: $language, resume: $resume, coverLetter: $coverLetter, changes: $changes, keywords: $keywords, rejected: $rejected)';
}


}

/// @nodoc
abstract mixin class _$ApplicationDraftCopyWith<$Res> implements $ApplicationDraftCopyWith<$Res> {
  factory _$ApplicationDraftCopyWith(_ApplicationDraft value, $Res Function(_ApplicationDraft) _then) = __$ApplicationDraftCopyWithImpl;
@override @useResult
$Res call({
 String jobId, ResumeLanguage language, TailoredResume resume, String coverLetter, List<ResumeChange> changes, List<String> keywords, List<String> rejected
});


@override $TailoredResumeCopyWith<$Res> get resume;

}
/// @nodoc
class __$ApplicationDraftCopyWithImpl<$Res>
    implements _$ApplicationDraftCopyWith<$Res> {
  __$ApplicationDraftCopyWithImpl(this._self, this._then);

  final _ApplicationDraft _self;
  final $Res Function(_ApplicationDraft) _then;

/// Create a copy of ApplicationDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? jobId = null,Object? language = null,Object? resume = null,Object? coverLetter = null,Object? changes = null,Object? keywords = null,Object? rejected = null,}) {
  return _then(_ApplicationDraft(
jobId: null == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as ResumeLanguage,resume: null == resume ? _self.resume : resume // ignore: cast_nullable_to_non_nullable
as TailoredResume,coverLetter: null == coverLetter ? _self.coverLetter : coverLetter // ignore: cast_nullable_to_non_nullable
as String,changes: null == changes ? _self._changes : changes // ignore: cast_nullable_to_non_nullable
as List<ResumeChange>,keywords: null == keywords ? _self._keywords : keywords // ignore: cast_nullable_to_non_nullable
as List<String>,rejected: null == rejected ? _self._rejected : rejected // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of ApplicationDraft
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TailoredResumeCopyWith<$Res> get resume {
  
  return $TailoredResumeCopyWith<$Res>(_self.resume, (value) {
    return _then(_self.copyWith(resume: value));
  });
}
}

// dart format on
