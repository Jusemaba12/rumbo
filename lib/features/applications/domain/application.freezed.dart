// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'application.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Application {

 String get id; String get jobId; String? get resumeVersionId; ApplicationStatus get status; String? get coverLetter; String get notes; DateTime? get appliedAt; DateTime? get nextFollowUpAt; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of Application
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApplicationCopyWith<Application> get copyWith => _$ApplicationCopyWithImpl<Application>(this as Application, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Application;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Application&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.jobId, _this.jobId) || other.jobId == _this.jobId)&&(identical(other.resumeVersionId, _this.resumeVersionId) || other.resumeVersionId == _this.resumeVersionId)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.coverLetter, _this.coverLetter) || other.coverLetter == _this.coverLetter)&&(identical(other.notes, _this.notes) || other.notes == _this.notes)&&(identical(other.appliedAt, _this.appliedAt) || other.appliedAt == _this.appliedAt)&&(identical(other.nextFollowUpAt, _this.nextFollowUpAt) || other.nextFollowUpAt == _this.nextFollowUpAt)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}


@override
int get hashCode {
  final _this = this as Application;
  return Object.hash(runtimeType,_this.id,_this.jobId,_this.resumeVersionId,_this.status,_this.coverLetter,_this.notes,_this.appliedAt,_this.nextFollowUpAt,_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as Application;
  return 'Application(id: ${_this.id}, jobId: ${_this.jobId}, resumeVersionId: ${_this.resumeVersionId}, status: ${_this.status}, coverLetter: ${_this.coverLetter}, notes: ${_this.notes}, appliedAt: ${_this.appliedAt}, nextFollowUpAt: ${_this.nextFollowUpAt}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $ApplicationCopyWith<$Res>  {
  factory $ApplicationCopyWith(Application value, $Res Function(Application) _then) = _$ApplicationCopyWithImpl;
@useResult
$Res call({
 String id, String jobId, String? resumeVersionId, ApplicationStatus status, String? coverLetter, String notes, DateTime? appliedAt, DateTime? nextFollowUpAt, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$ApplicationCopyWithImpl<$Res>
    implements $ApplicationCopyWith<$Res> {
  _$ApplicationCopyWithImpl(this._self, this._then);

  final Application _self;
  final $Res Function(Application) _then;

/// Create a copy of Application
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? jobId = null,Object? resumeVersionId = freezed,Object? status = null,Object? coverLetter = freezed,Object? notes = null,Object? appliedAt = freezed,Object? nextFollowUpAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(Application(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,jobId: null == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String,resumeVersionId: freezed == resumeVersionId ? _self.resumeVersionId : resumeVersionId // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ApplicationStatus,coverLetter: freezed == coverLetter ? _self.coverLetter : coverLetter // ignore: cast_nullable_to_non_nullable
as String?,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,appliedAt: freezed == appliedAt ? _self.appliedAt : appliedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,nextFollowUpAt: freezed == nextFollowUpAt ? _self.nextFollowUpAt : nextFollowUpAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Application].
extension ApplicationPatterns on Application {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Application value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Application() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Application value)  $default,){
final _that = this;
switch (_that) {
case _Application():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Application value)?  $default,){
final _that = this;
switch (_that) {
case _Application() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String jobId,  String? resumeVersionId,  ApplicationStatus status,  String? coverLetter,  String notes,  DateTime? appliedAt,  DateTime? nextFollowUpAt,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Application() when $default != null:
return $default(_that.id,_that.jobId,_that.resumeVersionId,_that.status,_that.coverLetter,_that.notes,_that.appliedAt,_that.nextFollowUpAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String jobId,  String? resumeVersionId,  ApplicationStatus status,  String? coverLetter,  String notes,  DateTime? appliedAt,  DateTime? nextFollowUpAt,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Application():
return $default(_that.id,_that.jobId,_that.resumeVersionId,_that.status,_that.coverLetter,_that.notes,_that.appliedAt,_that.nextFollowUpAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String jobId,  String? resumeVersionId,  ApplicationStatus status,  String? coverLetter,  String notes,  DateTime? appliedAt,  DateTime? nextFollowUpAt,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Application() when $default != null:
return $default(_that.id,_that.jobId,_that.resumeVersionId,_that.status,_that.coverLetter,_that.notes,_that.appliedAt,_that.nextFollowUpAt,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _Application implements Application {
  const _Application({this.id = '', required this.jobId, this.resumeVersionId, this.status = ApplicationStatus.saved, this.coverLetter, this.notes = '', this.appliedAt, this.nextFollowUpAt, this.createdAt, this.updatedAt});
  

@override@JsonKey() final  String id;
@override final  String jobId;
@override final  String? resumeVersionId;
@override@JsonKey() final  ApplicationStatus status;
@override final  String? coverLetter;
@override@JsonKey() final  String notes;
@override final  DateTime? appliedAt;
@override final  DateTime? nextFollowUpAt;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of Application
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApplicationCopyWith<_Application> get copyWith => __$ApplicationCopyWithImpl<_Application>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Application&&(identical(other.id, id) || other.id == id)&&(identical(other.jobId, jobId) || other.jobId == jobId)&&(identical(other.resumeVersionId, resumeVersionId) || other.resumeVersionId == resumeVersionId)&&(identical(other.status, status) || other.status == status)&&(identical(other.coverLetter, coverLetter) || other.coverLetter == coverLetter)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.appliedAt, appliedAt) || other.appliedAt == appliedAt)&&(identical(other.nextFollowUpAt, nextFollowUpAt) || other.nextFollowUpAt == nextFollowUpAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,jobId,resumeVersionId,status,coverLetter,notes,appliedAt,nextFollowUpAt,createdAt,updatedAt);
}

@override
String toString() {
    return 'Application(id: $id, jobId: $jobId, resumeVersionId: $resumeVersionId, status: $status, coverLetter: $coverLetter, notes: $notes, appliedAt: $appliedAt, nextFollowUpAt: $nextFollowUpAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ApplicationCopyWith<$Res> implements $ApplicationCopyWith<$Res> {
  factory _$ApplicationCopyWith(_Application value, $Res Function(_Application) _then) = __$ApplicationCopyWithImpl;
@override @useResult
$Res call({
 String id, String jobId, String? resumeVersionId, ApplicationStatus status, String? coverLetter, String notes, DateTime? appliedAt, DateTime? nextFollowUpAt, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$ApplicationCopyWithImpl<$Res>
    implements _$ApplicationCopyWith<$Res> {
  __$ApplicationCopyWithImpl(this._self, this._then);

  final _Application _self;
  final $Res Function(_Application) _then;

/// Create a copy of Application
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? jobId = null,Object? resumeVersionId = freezed,Object? status = null,Object? coverLetter = freezed,Object? notes = null,Object? appliedAt = freezed,Object? nextFollowUpAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_Application(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,jobId: null == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String,resumeVersionId: freezed == resumeVersionId ? _self.resumeVersionId : resumeVersionId // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ApplicationStatus,coverLetter: freezed == coverLetter ? _self.coverLetter : coverLetter // ignore: cast_nullable_to_non_nullable
as String?,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,appliedAt: freezed == appliedAt ? _self.appliedAt : appliedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,nextFollowUpAt: freezed == nextFollowUpAt ? _self.nextFollowUpAt : nextFollowUpAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$ApplicationEvent {

 String get id; ApplicationStatus? get fromStatus; ApplicationStatus get toStatus; EventOrigin get origin; String? get note; DateTime get createdAt;
/// Create a copy of ApplicationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApplicationEventCopyWith<ApplicationEvent> get copyWith => _$ApplicationEventCopyWithImpl<ApplicationEvent>(this as ApplicationEvent, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ApplicationEvent;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApplicationEvent&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.fromStatus, _this.fromStatus) || other.fromStatus == _this.fromStatus)&&(identical(other.toStatus, _this.toStatus) || other.toStatus == _this.toStatus)&&(identical(other.origin, _this.origin) || other.origin == _this.origin)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}


@override
int get hashCode {
  final _this = this as ApplicationEvent;
  return Object.hash(runtimeType,_this.id,_this.fromStatus,_this.toStatus,_this.origin,_this.note,_this.createdAt);
}

@override
String toString() {
  final _this = this as ApplicationEvent;
  return 'ApplicationEvent(id: ${_this.id}, fromStatus: ${_this.fromStatus}, toStatus: ${_this.toStatus}, origin: ${_this.origin}, note: ${_this.note}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $ApplicationEventCopyWith<$Res>  {
  factory $ApplicationEventCopyWith(ApplicationEvent value, $Res Function(ApplicationEvent) _then) = _$ApplicationEventCopyWithImpl;
@useResult
$Res call({
 String id, ApplicationStatus? fromStatus, ApplicationStatus toStatus, EventOrigin origin, String? note, DateTime createdAt
});




}
/// @nodoc
class _$ApplicationEventCopyWithImpl<$Res>
    implements $ApplicationEventCopyWith<$Res> {
  _$ApplicationEventCopyWithImpl(this._self, this._then);

  final ApplicationEvent _self;
  final $Res Function(ApplicationEvent) _then;

/// Create a copy of ApplicationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fromStatus = freezed,Object? toStatus = null,Object? origin = null,Object? note = freezed,Object? createdAt = null,}) {
  return _then(ApplicationEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fromStatus: freezed == fromStatus ? _self.fromStatus : fromStatus // ignore: cast_nullable_to_non_nullable
as ApplicationStatus?,toStatus: null == toStatus ? _self.toStatus : toStatus // ignore: cast_nullable_to_non_nullable
as ApplicationStatus,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as EventOrigin,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ApplicationEvent].
extension ApplicationEventPatterns on ApplicationEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApplicationEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApplicationEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApplicationEvent value)  $default,){
final _that = this;
switch (_that) {
case _ApplicationEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApplicationEvent value)?  $default,){
final _that = this;
switch (_that) {
case _ApplicationEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  ApplicationStatus? fromStatus,  ApplicationStatus toStatus,  EventOrigin origin,  String? note,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApplicationEvent() when $default != null:
return $default(_that.id,_that.fromStatus,_that.toStatus,_that.origin,_that.note,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  ApplicationStatus? fromStatus,  ApplicationStatus toStatus,  EventOrigin origin,  String? note,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _ApplicationEvent():
return $default(_that.id,_that.fromStatus,_that.toStatus,_that.origin,_that.note,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  ApplicationStatus? fromStatus,  ApplicationStatus toStatus,  EventOrigin origin,  String? note,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ApplicationEvent() when $default != null:
return $default(_that.id,_that.fromStatus,_that.toStatus,_that.origin,_that.note,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _ApplicationEvent implements ApplicationEvent {
  const _ApplicationEvent({required this.id, this.fromStatus, required this.toStatus, this.origin = EventOrigin.manual, this.note, required this.createdAt});
  

@override final  String id;
@override final  ApplicationStatus? fromStatus;
@override final  ApplicationStatus toStatus;
@override@JsonKey() final  EventOrigin origin;
@override final  String? note;
@override final  DateTime createdAt;

/// Create a copy of ApplicationEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApplicationEventCopyWith<_ApplicationEvent> get copyWith => __$ApplicationEventCopyWithImpl<_ApplicationEvent>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApplicationEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.fromStatus, fromStatus) || other.fromStatus == fromStatus)&&(identical(other.toStatus, toStatus) || other.toStatus == toStatus)&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.note, note) || other.note == note)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,fromStatus,toStatus,origin,note,createdAt);
}

@override
String toString() {
    return 'ApplicationEvent(id: $id, fromStatus: $fromStatus, toStatus: $toStatus, origin: $origin, note: $note, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ApplicationEventCopyWith<$Res> implements $ApplicationEventCopyWith<$Res> {
  factory _$ApplicationEventCopyWith(_ApplicationEvent value, $Res Function(_ApplicationEvent) _then) = __$ApplicationEventCopyWithImpl;
@override @useResult
$Res call({
 String id, ApplicationStatus? fromStatus, ApplicationStatus toStatus, EventOrigin origin, String? note, DateTime createdAt
});




}
/// @nodoc
class __$ApplicationEventCopyWithImpl<$Res>
    implements _$ApplicationEventCopyWith<$Res> {
  __$ApplicationEventCopyWithImpl(this._self, this._then);

  final _ApplicationEvent _self;
  final $Res Function(_ApplicationEvent) _then;

/// Create a copy of ApplicationEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fromStatus = freezed,Object? toStatus = null,Object? origin = null,Object? note = freezed,Object? createdAt = null,}) {
  return _then(_ApplicationEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fromStatus: freezed == fromStatus ? _self.fromStatus : fromStatus // ignore: cast_nullable_to_non_nullable
as ApplicationStatus?,toStatus: null == toStatus ? _self.toStatus : toStatus // ignore: cast_nullable_to_non_nullable
as ApplicationStatus,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as EventOrigin,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
mixin _$ApplicationWithJob {

 Application get application; Job get job;
/// Create a copy of ApplicationWithJob
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApplicationWithJobCopyWith<ApplicationWithJob> get copyWith => _$ApplicationWithJobCopyWithImpl<ApplicationWithJob>(this as ApplicationWithJob, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ApplicationWithJob;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApplicationWithJob&&(identical(other.application, _this.application) || other.application == _this.application)&&(identical(other.job, _this.job) || other.job == _this.job));
}


@override
int get hashCode {
  final _this = this as ApplicationWithJob;
  return Object.hash(runtimeType,_this.application,_this.job);
}

@override
String toString() {
  final _this = this as ApplicationWithJob;
  return 'ApplicationWithJob(application: ${_this.application}, job: ${_this.job})';
}


}

/// @nodoc
abstract mixin class $ApplicationWithJobCopyWith<$Res>  {
  factory $ApplicationWithJobCopyWith(ApplicationWithJob value, $Res Function(ApplicationWithJob) _then) = _$ApplicationWithJobCopyWithImpl;
@useResult
$Res call({
 Application application, Job job
});


$ApplicationCopyWith<$Res> get application;$JobCopyWith<$Res> get job;

}
/// @nodoc
class _$ApplicationWithJobCopyWithImpl<$Res>
    implements $ApplicationWithJobCopyWith<$Res> {
  _$ApplicationWithJobCopyWithImpl(this._self, this._then);

  final ApplicationWithJob _self;
  final $Res Function(ApplicationWithJob) _then;

/// Create a copy of ApplicationWithJob
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? application = null,Object? job = null,}) {
  return _then(ApplicationWithJob(
application: null == application ? _self.application : application // ignore: cast_nullable_to_non_nullable
as Application,job: null == job ? _self.job : job // ignore: cast_nullable_to_non_nullable
as Job,
  ));
}
/// Create a copy of ApplicationWithJob
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApplicationCopyWith<$Res> get application {
  
  return $ApplicationCopyWith<$Res>(_self.application, (value) {
    return _then(_self.copyWith(application: value));
  });
}/// Create a copy of ApplicationWithJob
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JobCopyWith<$Res> get job {
  
  return $JobCopyWith<$Res>(_self.job, (value) {
    return _then(_self.copyWith(job: value));
  });
}
}


/// Adds pattern-matching-related methods to [ApplicationWithJob].
extension ApplicationWithJobPatterns on ApplicationWithJob {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApplicationWithJob value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApplicationWithJob() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApplicationWithJob value)  $default,){
final _that = this;
switch (_that) {
case _ApplicationWithJob():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApplicationWithJob value)?  $default,){
final _that = this;
switch (_that) {
case _ApplicationWithJob() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Application application,  Job job)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApplicationWithJob() when $default != null:
return $default(_that.application,_that.job);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Application application,  Job job)  $default,) {final _that = this;
switch (_that) {
case _ApplicationWithJob():
return $default(_that.application,_that.job);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Application application,  Job job)?  $default,) {final _that = this;
switch (_that) {
case _ApplicationWithJob() when $default != null:
return $default(_that.application,_that.job);case _:
  return null;

}
}

}

/// @nodoc


class _ApplicationWithJob implements ApplicationWithJob {
  const _ApplicationWithJob({required this.application, required this.job});
  

@override final  Application application;
@override final  Job job;

/// Create a copy of ApplicationWithJob
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApplicationWithJobCopyWith<_ApplicationWithJob> get copyWith => __$ApplicationWithJobCopyWithImpl<_ApplicationWithJob>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApplicationWithJob&&(identical(other.application, application) || other.application == application)&&(identical(other.job, job) || other.job == job));
}


@override
int get hashCode {
    return Object.hash(runtimeType,application,job);
}

@override
String toString() {
    return 'ApplicationWithJob(application: $application, job: $job)';
}


}

/// @nodoc
abstract mixin class _$ApplicationWithJobCopyWith<$Res> implements $ApplicationWithJobCopyWith<$Res> {
  factory _$ApplicationWithJobCopyWith(_ApplicationWithJob value, $Res Function(_ApplicationWithJob) _then) = __$ApplicationWithJobCopyWithImpl;
@override @useResult
$Res call({
 Application application, Job job
});


@override $ApplicationCopyWith<$Res> get application;@override $JobCopyWith<$Res> get job;

}
/// @nodoc
class __$ApplicationWithJobCopyWithImpl<$Res>
    implements _$ApplicationWithJobCopyWith<$Res> {
  __$ApplicationWithJobCopyWithImpl(this._self, this._then);

  final _ApplicationWithJob _self;
  final $Res Function(_ApplicationWithJob) _then;

/// Create a copy of ApplicationWithJob
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? application = null,Object? job = null,}) {
  return _then(_ApplicationWithJob(
application: null == application ? _self.application : application // ignore: cast_nullable_to_non_nullable
as Application,job: null == job ? _self.job : job // ignore: cast_nullable_to_non_nullable
as Job,
  ));
}

/// Create a copy of ApplicationWithJob
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApplicationCopyWith<$Res> get application {
  
  return $ApplicationCopyWith<$Res>(_self.application, (value) {
    return _then(_self.copyWith(application: value));
  });
}/// Create a copy of ApplicationWithJob
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JobCopyWith<$Res> get job {
  
  return $JobCopyWith<$Res>(_self.job, (value) {
    return _then(_self.copyWith(job: value));
  });
}
}

// dart format on
