// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reminder_plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReminderSettings {

/// Seguimientos y entrevistas.
 bool get processes;/// Aviso diario para revisar sugerencias y tareas.
 bool get daily;
/// Create a copy of ReminderSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReminderSettingsCopyWith<ReminderSettings> get copyWith => _$ReminderSettingsCopyWithImpl<ReminderSettings>(this as ReminderSettings, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ReminderSettings;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReminderSettings&&(identical(other.processes, _this.processes) || other.processes == _this.processes)&&(identical(other.daily, _this.daily) || other.daily == _this.daily));
}


@override
int get hashCode {
  final _this = this as ReminderSettings;
  return Object.hash(runtimeType,_this.processes,_this.daily);
}

@override
String toString() {
  final _this = this as ReminderSettings;
  return 'ReminderSettings(processes: ${_this.processes}, daily: ${_this.daily})';
}


}

/// @nodoc
abstract mixin class $ReminderSettingsCopyWith<$Res>  {
  factory $ReminderSettingsCopyWith(ReminderSettings value, $Res Function(ReminderSettings) _then) = _$ReminderSettingsCopyWithImpl;
@useResult
$Res call({
 bool processes, bool daily
});




}
/// @nodoc
class _$ReminderSettingsCopyWithImpl<$Res>
    implements $ReminderSettingsCopyWith<$Res> {
  _$ReminderSettingsCopyWithImpl(this._self, this._then);

  final ReminderSettings _self;
  final $Res Function(ReminderSettings) _then;

/// Create a copy of ReminderSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? processes = null,Object? daily = null,}) {
  return _then(ReminderSettings(
processes: null == processes ? _self.processes : processes // ignore: cast_nullable_to_non_nullable
as bool,daily: null == daily ? _self.daily : daily // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ReminderSettings].
extension ReminderSettingsPatterns on ReminderSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReminderSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReminderSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReminderSettings value)  $default,){
final _that = this;
switch (_that) {
case _ReminderSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReminderSettings value)?  $default,){
final _that = this;
switch (_that) {
case _ReminderSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool processes,  bool daily)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReminderSettings() when $default != null:
return $default(_that.processes,_that.daily);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool processes,  bool daily)  $default,) {final _that = this;
switch (_that) {
case _ReminderSettings():
return $default(_that.processes,_that.daily);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool processes,  bool daily)?  $default,) {final _that = this;
switch (_that) {
case _ReminderSettings() when $default != null:
return $default(_that.processes,_that.daily);case _:
  return null;

}
}

}

/// @nodoc


class _ReminderSettings implements ReminderSettings {
  const _ReminderSettings({this.processes = true, this.daily = false});
  

/// Seguimientos y entrevistas.
@override@JsonKey() final  bool processes;
/// Aviso diario para revisar sugerencias y tareas.
@override@JsonKey() final  bool daily;

/// Create a copy of ReminderSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReminderSettingsCopyWith<_ReminderSettings> get copyWith => __$ReminderSettingsCopyWithImpl<_ReminderSettings>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReminderSettings&&(identical(other.processes, processes) || other.processes == processes)&&(identical(other.daily, daily) || other.daily == daily));
}


@override
int get hashCode {
    return Object.hash(runtimeType,processes,daily);
}

@override
String toString() {
    return 'ReminderSettings(processes: $processes, daily: $daily)';
}


}

/// @nodoc
abstract mixin class _$ReminderSettingsCopyWith<$Res> implements $ReminderSettingsCopyWith<$Res> {
  factory _$ReminderSettingsCopyWith(_ReminderSettings value, $Res Function(_ReminderSettings) _then) = __$ReminderSettingsCopyWithImpl;
@override @useResult
$Res call({
 bool processes, bool daily
});




}
/// @nodoc
class __$ReminderSettingsCopyWithImpl<$Res>
    implements _$ReminderSettingsCopyWith<$Res> {
  __$ReminderSettingsCopyWithImpl(this._self, this._then);

  final _ReminderSettings _self;
  final $Res Function(_ReminderSettings) _then;

/// Create a copy of ReminderSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? processes = null,Object? daily = null,}) {
  return _then(_ReminderSettings(
processes: null == processes ? _self.processes : processes // ignore: cast_nullable_to_non_nullable
as bool,daily: null == daily ? _self.daily : daily // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$PlannedReminder {

 ReminderKind get kind;/// Hora local del aviso.
 DateTime get at; String? get applicationId; String get company; String get role; DateTime? get interviewAt;
/// Create a copy of PlannedReminder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlannedReminderCopyWith<PlannedReminder> get copyWith => _$PlannedReminderCopyWithImpl<PlannedReminder>(this as PlannedReminder, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PlannedReminder;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlannedReminder&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.at, _this.at) || other.at == _this.at)&&(identical(other.applicationId, _this.applicationId) || other.applicationId == _this.applicationId)&&(identical(other.company, _this.company) || other.company == _this.company)&&(identical(other.role, _this.role) || other.role == _this.role)&&(identical(other.interviewAt, _this.interviewAt) || other.interviewAt == _this.interviewAt));
}


@override
int get hashCode {
  final _this = this as PlannedReminder;
  return Object.hash(runtimeType,_this.kind,_this.at,_this.applicationId,_this.company,_this.role,_this.interviewAt);
}

@override
String toString() {
  final _this = this as PlannedReminder;
  return 'PlannedReminder(kind: ${_this.kind}, at: ${_this.at}, applicationId: ${_this.applicationId}, company: ${_this.company}, role: ${_this.role}, interviewAt: ${_this.interviewAt})';
}


}

/// @nodoc
abstract mixin class $PlannedReminderCopyWith<$Res>  {
  factory $PlannedReminderCopyWith(PlannedReminder value, $Res Function(PlannedReminder) _then) = _$PlannedReminderCopyWithImpl;
@useResult
$Res call({
 ReminderKind kind, DateTime at, String? applicationId, String company, String role, DateTime? interviewAt
});




}
/// @nodoc
class _$PlannedReminderCopyWithImpl<$Res>
    implements $PlannedReminderCopyWith<$Res> {
  _$PlannedReminderCopyWithImpl(this._self, this._then);

  final PlannedReminder _self;
  final $Res Function(PlannedReminder) _then;

/// Create a copy of PlannedReminder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? at = null,Object? applicationId = freezed,Object? company = null,Object? role = null,Object? interviewAt = freezed,}) {
  return _then(PlannedReminder(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ReminderKind,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,applicationId: freezed == applicationId ? _self.applicationId : applicationId // ignore: cast_nullable_to_non_nullable
as String?,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,interviewAt: freezed == interviewAt ? _self.interviewAt : interviewAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlannedReminder].
extension PlannedReminderPatterns on PlannedReminder {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlannedReminder value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlannedReminder() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlannedReminder value)  $default,){
final _that = this;
switch (_that) {
case _PlannedReminder():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlannedReminder value)?  $default,){
final _that = this;
switch (_that) {
case _PlannedReminder() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ReminderKind kind,  DateTime at,  String? applicationId,  String company,  String role,  DateTime? interviewAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlannedReminder() when $default != null:
return $default(_that.kind,_that.at,_that.applicationId,_that.company,_that.role,_that.interviewAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ReminderKind kind,  DateTime at,  String? applicationId,  String company,  String role,  DateTime? interviewAt)  $default,) {final _that = this;
switch (_that) {
case _PlannedReminder():
return $default(_that.kind,_that.at,_that.applicationId,_that.company,_that.role,_that.interviewAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ReminderKind kind,  DateTime at,  String? applicationId,  String company,  String role,  DateTime? interviewAt)?  $default,) {final _that = this;
switch (_that) {
case _PlannedReminder() when $default != null:
return $default(_that.kind,_that.at,_that.applicationId,_that.company,_that.role,_that.interviewAt);case _:
  return null;

}
}

}

/// @nodoc


class _PlannedReminder extends PlannedReminder {
  const _PlannedReminder({required this.kind, required this.at, this.applicationId, this.company = '', this.role = '', this.interviewAt}): super._();
  

@override final  ReminderKind kind;
/// Hora local del aviso.
@override final  DateTime at;
@override final  String? applicationId;
@override@JsonKey() final  String company;
@override@JsonKey() final  String role;
@override final  DateTime? interviewAt;

/// Create a copy of PlannedReminder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlannedReminderCopyWith<_PlannedReminder> get copyWith => __$PlannedReminderCopyWithImpl<_PlannedReminder>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlannedReminder&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.at, at) || other.at == at)&&(identical(other.applicationId, applicationId) || other.applicationId == applicationId)&&(identical(other.company, company) || other.company == company)&&(identical(other.role, role) || other.role == role)&&(identical(other.interviewAt, interviewAt) || other.interviewAt == interviewAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,kind,at,applicationId,company,role,interviewAt);
}

@override
String toString() {
    return 'PlannedReminder(kind: $kind, at: $at, applicationId: $applicationId, company: $company, role: $role, interviewAt: $interviewAt)';
}


}

/// @nodoc
abstract mixin class _$PlannedReminderCopyWith<$Res> implements $PlannedReminderCopyWith<$Res> {
  factory _$PlannedReminderCopyWith(_PlannedReminder value, $Res Function(_PlannedReminder) _then) = __$PlannedReminderCopyWithImpl;
@override @useResult
$Res call({
 ReminderKind kind, DateTime at, String? applicationId, String company, String role, DateTime? interviewAt
});




}
/// @nodoc
class __$PlannedReminderCopyWithImpl<$Res>
    implements _$PlannedReminderCopyWith<$Res> {
  __$PlannedReminderCopyWithImpl(this._self, this._then);

  final _PlannedReminder _self;
  final $Res Function(_PlannedReminder) _then;

/// Create a copy of PlannedReminder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? at = null,Object? applicationId = freezed,Object? company = null,Object? role = null,Object? interviewAt = freezed,}) {
  return _then(_PlannedReminder(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ReminderKind,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,applicationId: freezed == applicationId ? _self.applicationId : applicationId // ignore: cast_nullable_to_non_nullable
as String?,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,interviewAt: freezed == interviewAt ? _self.interviewAt : interviewAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
