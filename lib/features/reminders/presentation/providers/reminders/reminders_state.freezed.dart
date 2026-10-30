// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reminders_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RemindersState {

 ReminderSettings get settings; bool get denied;
/// Create a copy of RemindersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RemindersStateCopyWith<RemindersState> get copyWith => _$RemindersStateCopyWithImpl<RemindersState>(this as RemindersState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RemindersState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RemindersState&&(identical(other.settings, _this.settings) || other.settings == _this.settings)&&(identical(other.denied, _this.denied) || other.denied == _this.denied));
}


@override
int get hashCode {
  final _this = this as RemindersState;
  return Object.hash(runtimeType,_this.settings,_this.denied);
}

@override
String toString() {
  final _this = this as RemindersState;
  return 'RemindersState(settings: ${_this.settings}, denied: ${_this.denied})';
}


}

/// @nodoc
abstract mixin class $RemindersStateCopyWith<$Res>  {
  factory $RemindersStateCopyWith(RemindersState value, $Res Function(RemindersState) _then) = _$RemindersStateCopyWithImpl;
@useResult
$Res call({
 ReminderSettings settings, bool denied
});


$ReminderSettingsCopyWith<$Res> get settings;

}
/// @nodoc
class _$RemindersStateCopyWithImpl<$Res>
    implements $RemindersStateCopyWith<$Res> {
  _$RemindersStateCopyWithImpl(this._self, this._then);

  final RemindersState _self;
  final $Res Function(RemindersState) _then;

/// Create a copy of RemindersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? settings = null,Object? denied = null,}) {
  return _then(RemindersState(
settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as ReminderSettings,denied: null == denied ? _self.denied : denied // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of RemindersState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReminderSettingsCopyWith<$Res> get settings {
  
  return $ReminderSettingsCopyWith<$Res>(_self.settings, (value) {
    return _then(_self.copyWith(settings: value));
  });
}
}


/// Adds pattern-matching-related methods to [RemindersState].
extension RemindersStatePatterns on RemindersState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RemindersState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RemindersState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RemindersState value)  $default,){
final _that = this;
switch (_that) {
case _RemindersState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RemindersState value)?  $default,){
final _that = this;
switch (_that) {
case _RemindersState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ReminderSettings settings,  bool denied)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RemindersState() when $default != null:
return $default(_that.settings,_that.denied);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ReminderSettings settings,  bool denied)  $default,) {final _that = this;
switch (_that) {
case _RemindersState():
return $default(_that.settings,_that.denied);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ReminderSettings settings,  bool denied)?  $default,) {final _that = this;
switch (_that) {
case _RemindersState() when $default != null:
return $default(_that.settings,_that.denied);case _:
  return null;

}
}

}

/// @nodoc


class _RemindersState implements RemindersState {
  const _RemindersState({required this.settings, this.denied = false});
  

@override final  ReminderSettings settings;
@override@JsonKey() final  bool denied;

/// Create a copy of RemindersState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RemindersStateCopyWith<_RemindersState> get copyWith => __$RemindersStateCopyWithImpl<_RemindersState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RemindersState&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.denied, denied) || other.denied == denied));
}


@override
int get hashCode {
    return Object.hash(runtimeType,settings,denied);
}

@override
String toString() {
    return 'RemindersState(settings: $settings, denied: $denied)';
}


}

/// @nodoc
abstract mixin class _$RemindersStateCopyWith<$Res> implements $RemindersStateCopyWith<$Res> {
  factory _$RemindersStateCopyWith(_RemindersState value, $Res Function(_RemindersState) _then) = __$RemindersStateCopyWithImpl;
@override @useResult
$Res call({
 ReminderSettings settings, bool denied
});


@override $ReminderSettingsCopyWith<$Res> get settings;

}
/// @nodoc
class __$RemindersStateCopyWithImpl<$Res>
    implements _$RemindersStateCopyWith<$Res> {
  __$RemindersStateCopyWithImpl(this._self, this._then);

  final _RemindersState _self;
  final $Res Function(_RemindersState) _then;

/// Create a copy of RemindersState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? settings = null,Object? denied = null,}) {
  return _then(_RemindersState(
settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as ReminderSettings,denied: null == denied ? _self.denied : denied // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of RemindersState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReminderSettingsCopyWith<$Res> get settings {
  
  return $ReminderSettingsCopyWith<$Res>(_self.settings, (value) {
    return _then(_self.copyWith(settings: value));
  });
}
}

// dart format on
