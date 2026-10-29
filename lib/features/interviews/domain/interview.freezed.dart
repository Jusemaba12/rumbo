// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'interview.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Interview {

 String get id; String get applicationId; InterviewKind get kind; DateTime get scheduledAt; int get durationMinutes;/// Enlace de la videollamada o dirección.
 String get location; String get notes; InterviewOutcome get outcome;
/// Create a copy of Interview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InterviewCopyWith<Interview> get copyWith => _$InterviewCopyWithImpl<Interview>(this as Interview, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Interview;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Interview&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.applicationId, _this.applicationId) || other.applicationId == _this.applicationId)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.scheduledAt, _this.scheduledAt) || other.scheduledAt == _this.scheduledAt)&&(identical(other.durationMinutes, _this.durationMinutes) || other.durationMinutes == _this.durationMinutes)&&(identical(other.location, _this.location) || other.location == _this.location)&&(identical(other.notes, _this.notes) || other.notes == _this.notes)&&(identical(other.outcome, _this.outcome) || other.outcome == _this.outcome));
}


@override
int get hashCode {
  final _this = this as Interview;
  return Object.hash(runtimeType,_this.id,_this.applicationId,_this.kind,_this.scheduledAt,_this.durationMinutes,_this.location,_this.notes,_this.outcome);
}

@override
String toString() {
  final _this = this as Interview;
  return 'Interview(id: ${_this.id}, applicationId: ${_this.applicationId}, kind: ${_this.kind}, scheduledAt: ${_this.scheduledAt}, durationMinutes: ${_this.durationMinutes}, location: ${_this.location}, notes: ${_this.notes}, outcome: ${_this.outcome})';
}


}

/// @nodoc
abstract mixin class $InterviewCopyWith<$Res>  {
  factory $InterviewCopyWith(Interview value, $Res Function(Interview) _then) = _$InterviewCopyWithImpl;
@useResult
$Res call({
 String id, String applicationId, InterviewKind kind, DateTime scheduledAt, int durationMinutes, String location, String notes, InterviewOutcome outcome
});




}
/// @nodoc
class _$InterviewCopyWithImpl<$Res>
    implements $InterviewCopyWith<$Res> {
  _$InterviewCopyWithImpl(this._self, this._then);

  final Interview _self;
  final $Res Function(Interview) _then;

/// Create a copy of Interview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? applicationId = null,Object? kind = null,Object? scheduledAt = null,Object? durationMinutes = null,Object? location = null,Object? notes = null,Object? outcome = null,}) {
  return _then(Interview(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,applicationId: null == applicationId ? _self.applicationId : applicationId // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as InterviewKind,scheduledAt: null == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,outcome: null == outcome ? _self.outcome : outcome // ignore: cast_nullable_to_non_nullable
as InterviewOutcome,
  ));
}

}


/// Adds pattern-matching-related methods to [Interview].
extension InterviewPatterns on Interview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Interview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Interview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Interview value)  $default,){
final _that = this;
switch (_that) {
case _Interview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Interview value)?  $default,){
final _that = this;
switch (_that) {
case _Interview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String applicationId,  InterviewKind kind,  DateTime scheduledAt,  int durationMinutes,  String location,  String notes,  InterviewOutcome outcome)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Interview() when $default != null:
return $default(_that.id,_that.applicationId,_that.kind,_that.scheduledAt,_that.durationMinutes,_that.location,_that.notes,_that.outcome);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String applicationId,  InterviewKind kind,  DateTime scheduledAt,  int durationMinutes,  String location,  String notes,  InterviewOutcome outcome)  $default,) {final _that = this;
switch (_that) {
case _Interview():
return $default(_that.id,_that.applicationId,_that.kind,_that.scheduledAt,_that.durationMinutes,_that.location,_that.notes,_that.outcome);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String applicationId,  InterviewKind kind,  DateTime scheduledAt,  int durationMinutes,  String location,  String notes,  InterviewOutcome outcome)?  $default,) {final _that = this;
switch (_that) {
case _Interview() when $default != null:
return $default(_that.id,_that.applicationId,_that.kind,_that.scheduledAt,_that.durationMinutes,_that.location,_that.notes,_that.outcome);case _:
  return null;

}
}

}

/// @nodoc


class _Interview extends Interview {
  const _Interview({this.id = '', required this.applicationId, this.kind = InterviewKind.screening, required this.scheduledAt, this.durationMinutes = 60, this.location = '', this.notes = '', this.outcome = InterviewOutcome.pending}): super._();
  

@override@JsonKey() final  String id;
@override final  String applicationId;
@override@JsonKey() final  InterviewKind kind;
@override final  DateTime scheduledAt;
@override@JsonKey() final  int durationMinutes;
/// Enlace de la videollamada o dirección.
@override@JsonKey() final  String location;
@override@JsonKey() final  String notes;
@override@JsonKey() final  InterviewOutcome outcome;

/// Create a copy of Interview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InterviewCopyWith<_Interview> get copyWith => __$InterviewCopyWithImpl<_Interview>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Interview&&(identical(other.id, id) || other.id == id)&&(identical(other.applicationId, applicationId) || other.applicationId == applicationId)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.location, location) || other.location == location)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.outcome, outcome) || other.outcome == outcome));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,applicationId,kind,scheduledAt,durationMinutes,location,notes,outcome);
}

@override
String toString() {
    return 'Interview(id: $id, applicationId: $applicationId, kind: $kind, scheduledAt: $scheduledAt, durationMinutes: $durationMinutes, location: $location, notes: $notes, outcome: $outcome)';
}


}

/// @nodoc
abstract mixin class _$InterviewCopyWith<$Res> implements $InterviewCopyWith<$Res> {
  factory _$InterviewCopyWith(_Interview value, $Res Function(_Interview) _then) = __$InterviewCopyWithImpl;
@override @useResult
$Res call({
 String id, String applicationId, InterviewKind kind, DateTime scheduledAt, int durationMinutes, String location, String notes, InterviewOutcome outcome
});




}
/// @nodoc
class __$InterviewCopyWithImpl<$Res>
    implements _$InterviewCopyWith<$Res> {
  __$InterviewCopyWithImpl(this._self, this._then);

  final _Interview _self;
  final $Res Function(_Interview) _then;

/// Create a copy of Interview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? applicationId = null,Object? kind = null,Object? scheduledAt = null,Object? durationMinutes = null,Object? location = null,Object? notes = null,Object? outcome = null,}) {
  return _then(_Interview(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,applicationId: null == applicationId ? _self.applicationId : applicationId // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as InterviewKind,scheduledAt: null == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,outcome: null == outcome ? _self.outcome : outcome // ignore: cast_nullable_to_non_nullable
as InterviewOutcome,
  ));
}


}

// dart format on
