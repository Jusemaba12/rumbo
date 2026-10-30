// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'email_update.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EmailUpdate {

 String get id; String get applicationId; String get sender; String get subject; String get summary; ApplicationStatus? get suggestedStatus; DateTime? get interviewAt; DateTime? get receivedAt;
/// Create a copy of EmailUpdate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmailUpdateCopyWith<EmailUpdate> get copyWith => _$EmailUpdateCopyWithImpl<EmailUpdate>(this as EmailUpdate, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as EmailUpdate;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailUpdate&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.applicationId, _this.applicationId) || other.applicationId == _this.applicationId)&&(identical(other.sender, _this.sender) || other.sender == _this.sender)&&(identical(other.subject, _this.subject) || other.subject == _this.subject)&&(identical(other.summary, _this.summary) || other.summary == _this.summary)&&(identical(other.suggestedStatus, _this.suggestedStatus) || other.suggestedStatus == _this.suggestedStatus)&&(identical(other.interviewAt, _this.interviewAt) || other.interviewAt == _this.interviewAt)&&(identical(other.receivedAt, _this.receivedAt) || other.receivedAt == _this.receivedAt));
}


@override
int get hashCode {
  final _this = this as EmailUpdate;
  return Object.hash(runtimeType,_this.id,_this.applicationId,_this.sender,_this.subject,_this.summary,_this.suggestedStatus,_this.interviewAt,_this.receivedAt);
}

@override
String toString() {
  final _this = this as EmailUpdate;
  return 'EmailUpdate(id: ${_this.id}, applicationId: ${_this.applicationId}, sender: ${_this.sender}, subject: ${_this.subject}, summary: ${_this.summary}, suggestedStatus: ${_this.suggestedStatus}, interviewAt: ${_this.interviewAt}, receivedAt: ${_this.receivedAt})';
}


}

/// @nodoc
abstract mixin class $EmailUpdateCopyWith<$Res>  {
  factory $EmailUpdateCopyWith(EmailUpdate value, $Res Function(EmailUpdate) _then) = _$EmailUpdateCopyWithImpl;
@useResult
$Res call({
 String id, String applicationId, String sender, String subject, String summary, ApplicationStatus? suggestedStatus, DateTime? interviewAt, DateTime? receivedAt
});




}
/// @nodoc
class _$EmailUpdateCopyWithImpl<$Res>
    implements $EmailUpdateCopyWith<$Res> {
  _$EmailUpdateCopyWithImpl(this._self, this._then);

  final EmailUpdate _self;
  final $Res Function(EmailUpdate) _then;

/// Create a copy of EmailUpdate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? applicationId = null,Object? sender = null,Object? subject = null,Object? summary = null,Object? suggestedStatus = freezed,Object? interviewAt = freezed,Object? receivedAt = freezed,}) {
  return _then(EmailUpdate(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,applicationId: null == applicationId ? _self.applicationId : applicationId // ignore: cast_nullable_to_non_nullable
as String,sender: null == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,suggestedStatus: freezed == suggestedStatus ? _self.suggestedStatus : suggestedStatus // ignore: cast_nullable_to_non_nullable
as ApplicationStatus?,interviewAt: freezed == interviewAt ? _self.interviewAt : interviewAt // ignore: cast_nullable_to_non_nullable
as DateTime?,receivedAt: freezed == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [EmailUpdate].
extension EmailUpdatePatterns on EmailUpdate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmailUpdate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmailUpdate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmailUpdate value)  $default,){
final _that = this;
switch (_that) {
case _EmailUpdate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmailUpdate value)?  $default,){
final _that = this;
switch (_that) {
case _EmailUpdate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String applicationId,  String sender,  String subject,  String summary,  ApplicationStatus? suggestedStatus,  DateTime? interviewAt,  DateTime? receivedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmailUpdate() when $default != null:
return $default(_that.id,_that.applicationId,_that.sender,_that.subject,_that.summary,_that.suggestedStatus,_that.interviewAt,_that.receivedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String applicationId,  String sender,  String subject,  String summary,  ApplicationStatus? suggestedStatus,  DateTime? interviewAt,  DateTime? receivedAt)  $default,) {final _that = this;
switch (_that) {
case _EmailUpdate():
return $default(_that.id,_that.applicationId,_that.sender,_that.subject,_that.summary,_that.suggestedStatus,_that.interviewAt,_that.receivedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String applicationId,  String sender,  String subject,  String summary,  ApplicationStatus? suggestedStatus,  DateTime? interviewAt,  DateTime? receivedAt)?  $default,) {final _that = this;
switch (_that) {
case _EmailUpdate() when $default != null:
return $default(_that.id,_that.applicationId,_that.sender,_that.subject,_that.summary,_that.suggestedStatus,_that.interviewAt,_that.receivedAt);case _:
  return null;

}
}

}

/// @nodoc


class _EmailUpdate implements EmailUpdate {
  const _EmailUpdate({required this.id, required this.applicationId, this.sender = '', this.subject = '', this.summary = '', this.suggestedStatus, this.interviewAt, this.receivedAt});
  

@override final  String id;
@override final  String applicationId;
@override@JsonKey() final  String sender;
@override@JsonKey() final  String subject;
@override@JsonKey() final  String summary;
@override final  ApplicationStatus? suggestedStatus;
@override final  DateTime? interviewAt;
@override final  DateTime? receivedAt;

/// Create a copy of EmailUpdate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmailUpdateCopyWith<_EmailUpdate> get copyWith => __$EmailUpdateCopyWithImpl<_EmailUpdate>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmailUpdate&&(identical(other.id, id) || other.id == id)&&(identical(other.applicationId, applicationId) || other.applicationId == applicationId)&&(identical(other.sender, sender) || other.sender == sender)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.suggestedStatus, suggestedStatus) || other.suggestedStatus == suggestedStatus)&&(identical(other.interviewAt, interviewAt) || other.interviewAt == interviewAt)&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,applicationId,sender,subject,summary,suggestedStatus,interviewAt,receivedAt);
}

@override
String toString() {
    return 'EmailUpdate(id: $id, applicationId: $applicationId, sender: $sender, subject: $subject, summary: $summary, suggestedStatus: $suggestedStatus, interviewAt: $interviewAt, receivedAt: $receivedAt)';
}


}

/// @nodoc
abstract mixin class _$EmailUpdateCopyWith<$Res> implements $EmailUpdateCopyWith<$Res> {
  factory _$EmailUpdateCopyWith(_EmailUpdate value, $Res Function(_EmailUpdate) _then) = __$EmailUpdateCopyWithImpl;
@override @useResult
$Res call({
 String id, String applicationId, String sender, String subject, String summary, ApplicationStatus? suggestedStatus, DateTime? interviewAt, DateTime? receivedAt
});




}
/// @nodoc
class __$EmailUpdateCopyWithImpl<$Res>
    implements _$EmailUpdateCopyWith<$Res> {
  __$EmailUpdateCopyWithImpl(this._self, this._then);

  final _EmailUpdate _self;
  final $Res Function(_EmailUpdate) _then;

/// Create a copy of EmailUpdate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? applicationId = null,Object? sender = null,Object? subject = null,Object? summary = null,Object? suggestedStatus = freezed,Object? interviewAt = freezed,Object? receivedAt = freezed,}) {
  return _then(_EmailUpdate(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,applicationId: null == applicationId ? _self.applicationId : applicationId // ignore: cast_nullable_to_non_nullable
as String,sender: null == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,suggestedStatus: freezed == suggestedStatus ? _self.suggestedStatus : suggestedStatus // ignore: cast_nullable_to_non_nullable
as ApplicationStatus?,interviewAt: freezed == interviewAt ? _self.interviewAt : interviewAt // ignore: cast_nullable_to_non_nullable
as DateTime?,receivedAt: freezed == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$EmailSyncStatus {

 DateTime get createdAt;/// Última vez que el script habló con Rumbo; nula si aún no se instaló.
 DateTime? get lastUsedAt;
/// Create a copy of EmailSyncStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmailSyncStatusCopyWith<EmailSyncStatus> get copyWith => _$EmailSyncStatusCopyWithImpl<EmailSyncStatus>(this as EmailSyncStatus, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as EmailSyncStatus;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailSyncStatus&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.lastUsedAt, _this.lastUsedAt) || other.lastUsedAt == _this.lastUsedAt));
}


@override
int get hashCode {
  final _this = this as EmailSyncStatus;
  return Object.hash(runtimeType,_this.createdAt,_this.lastUsedAt);
}

@override
String toString() {
  final _this = this as EmailSyncStatus;
  return 'EmailSyncStatus(createdAt: ${_this.createdAt}, lastUsedAt: ${_this.lastUsedAt})';
}


}

/// @nodoc
abstract mixin class $EmailSyncStatusCopyWith<$Res>  {
  factory $EmailSyncStatusCopyWith(EmailSyncStatus value, $Res Function(EmailSyncStatus) _then) = _$EmailSyncStatusCopyWithImpl;
@useResult
$Res call({
 DateTime createdAt, DateTime? lastUsedAt
});




}
/// @nodoc
class _$EmailSyncStatusCopyWithImpl<$Res>
    implements $EmailSyncStatusCopyWith<$Res> {
  _$EmailSyncStatusCopyWithImpl(this._self, this._then);

  final EmailSyncStatus _self;
  final $Res Function(EmailSyncStatus) _then;

/// Create a copy of EmailSyncStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? createdAt = null,Object? lastUsedAt = freezed,}) {
  return _then(EmailSyncStatus(
createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastUsedAt: freezed == lastUsedAt ? _self.lastUsedAt : lastUsedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [EmailSyncStatus].
extension EmailSyncStatusPatterns on EmailSyncStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmailSyncStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmailSyncStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmailSyncStatus value)  $default,){
final _that = this;
switch (_that) {
case _EmailSyncStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmailSyncStatus value)?  $default,){
final _that = this;
switch (_that) {
case _EmailSyncStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime createdAt,  DateTime? lastUsedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmailSyncStatus() when $default != null:
return $default(_that.createdAt,_that.lastUsedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime createdAt,  DateTime? lastUsedAt)  $default,) {final _that = this;
switch (_that) {
case _EmailSyncStatus():
return $default(_that.createdAt,_that.lastUsedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime createdAt,  DateTime? lastUsedAt)?  $default,) {final _that = this;
switch (_that) {
case _EmailSyncStatus() when $default != null:
return $default(_that.createdAt,_that.lastUsedAt);case _:
  return null;

}
}

}

/// @nodoc


class _EmailSyncStatus implements EmailSyncStatus {
  const _EmailSyncStatus({required this.createdAt, this.lastUsedAt});
  

@override final  DateTime createdAt;
/// Última vez que el script habló con Rumbo; nula si aún no se instaló.
@override final  DateTime? lastUsedAt;

/// Create a copy of EmailSyncStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmailSyncStatusCopyWith<_EmailSyncStatus> get copyWith => __$EmailSyncStatusCopyWithImpl<_EmailSyncStatus>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmailSyncStatus&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastUsedAt, lastUsedAt) || other.lastUsedAt == lastUsedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,createdAt,lastUsedAt);
}

@override
String toString() {
    return 'EmailSyncStatus(createdAt: $createdAt, lastUsedAt: $lastUsedAt)';
}


}

/// @nodoc
abstract mixin class _$EmailSyncStatusCopyWith<$Res> implements $EmailSyncStatusCopyWith<$Res> {
  factory _$EmailSyncStatusCopyWith(_EmailSyncStatus value, $Res Function(_EmailSyncStatus) _then) = __$EmailSyncStatusCopyWithImpl;
@override @useResult
$Res call({
 DateTime createdAt, DateTime? lastUsedAt
});




}
/// @nodoc
class __$EmailSyncStatusCopyWithImpl<$Res>
    implements _$EmailSyncStatusCopyWith<$Res> {
  __$EmailSyncStatusCopyWithImpl(this._self, this._then);

  final _EmailSyncStatus _self;
  final $Res Function(_EmailSyncStatus) _then;

/// Create a copy of EmailSyncStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? createdAt = null,Object? lastUsedAt = freezed,}) {
  return _then(_EmailSyncStatus(
createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastUsedAt: freezed == lastUsedAt ? _self.lastUsedAt : lastUsedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
