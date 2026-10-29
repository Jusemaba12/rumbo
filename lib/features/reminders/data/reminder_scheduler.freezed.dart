// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reminder_scheduler.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ScheduledNotice implements DiagnosticableTreeMixin {

 int get id; DateTime get at; String get title; String get body;/// Pantalla que abre al tocarlo.
 String? get route;
/// Create a copy of ScheduledNotice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduledNoticeCopyWith<ScheduledNotice> get copyWith => _$ScheduledNoticeCopyWithImpl<ScheduledNotice>(this as ScheduledNotice, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  final _this = this as ScheduledNotice;
  properties
    ..add(DiagnosticsProperty('type', 'ScheduledNotice'))
    ..add(DiagnosticsProperty('id', _this.id))..add(DiagnosticsProperty('at', _this.at))..add(DiagnosticsProperty('title', _this.title))..add(DiagnosticsProperty('body', _this.body))..add(DiagnosticsProperty('route', _this.route));
}

@override
bool operator ==(Object other) {
  final _this = this as ScheduledNotice;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduledNotice&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.at, _this.at) || other.at == _this.at)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.body, _this.body) || other.body == _this.body)&&(identical(other.route, _this.route) || other.route == _this.route));
}


@override
int get hashCode {
  final _this = this as ScheduledNotice;
  return Object.hash(runtimeType,_this.id,_this.at,_this.title,_this.body,_this.route);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  final _this = this as ScheduledNotice;
  return 'ScheduledNotice(id: ${_this.id}, at: ${_this.at}, title: ${_this.title}, body: ${_this.body}, route: ${_this.route})';
}


}

/// @nodoc
abstract mixin class $ScheduledNoticeCopyWith<$Res>  {
  factory $ScheduledNoticeCopyWith(ScheduledNotice value, $Res Function(ScheduledNotice) _then) = _$ScheduledNoticeCopyWithImpl;
@useResult
$Res call({
 int id, DateTime at, String title, String body, String? route
});




}
/// @nodoc
class _$ScheduledNoticeCopyWithImpl<$Res>
    implements $ScheduledNoticeCopyWith<$Res> {
  _$ScheduledNoticeCopyWithImpl(this._self, this._then);

  final ScheduledNotice _self;
  final $Res Function(ScheduledNotice) _then;

/// Create a copy of ScheduledNotice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? at = null,Object? title = null,Object? body = null,Object? route = freezed,}) {
  return _then(ScheduledNotice(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,route: freezed == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ScheduledNotice].
extension ScheduledNoticePatterns on ScheduledNotice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScheduledNotice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScheduledNotice() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScheduledNotice value)  $default,){
final _that = this;
switch (_that) {
case _ScheduledNotice():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScheduledNotice value)?  $default,){
final _that = this;
switch (_that) {
case _ScheduledNotice() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  DateTime at,  String title,  String body,  String? route)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScheduledNotice() when $default != null:
return $default(_that.id,_that.at,_that.title,_that.body,_that.route);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  DateTime at,  String title,  String body,  String? route)  $default,) {final _that = this;
switch (_that) {
case _ScheduledNotice():
return $default(_that.id,_that.at,_that.title,_that.body,_that.route);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  DateTime at,  String title,  String body,  String? route)?  $default,) {final _that = this;
switch (_that) {
case _ScheduledNotice() when $default != null:
return $default(_that.id,_that.at,_that.title,_that.body,_that.route);case _:
  return null;

}
}

}

/// @nodoc


class _ScheduledNotice with DiagnosticableTreeMixin implements ScheduledNotice {
  const _ScheduledNotice({required this.id, required this.at, required this.title, required this.body, this.route});
  

@override final  int id;
@override final  DateTime at;
@override final  String title;
@override final  String body;
/// Pantalla que abre al tocarlo.
@override final  String? route;

/// Create a copy of ScheduledNotice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduledNoticeCopyWith<_ScheduledNotice> get copyWith => __$ScheduledNoticeCopyWithImpl<_ScheduledNotice>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
    ..add(DiagnosticsProperty('type', 'ScheduledNotice'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('at', at))..add(DiagnosticsProperty('title', title))..add(DiagnosticsProperty('body', body))..add(DiagnosticsProperty('route', route));
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScheduledNotice&&(identical(other.id, id) || other.id == id)&&(identical(other.at, at) || other.at == at)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.route, route) || other.route == route));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,at,title,body,route);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
    return 'ScheduledNotice(id: $id, at: $at, title: $title, body: $body, route: $route)';
}


}

/// @nodoc
abstract mixin class _$ScheduledNoticeCopyWith<$Res> implements $ScheduledNoticeCopyWith<$Res> {
  factory _$ScheduledNoticeCopyWith(_ScheduledNotice value, $Res Function(_ScheduledNotice) _then) = __$ScheduledNoticeCopyWithImpl;
@override @useResult
$Res call({
 int id, DateTime at, String title, String body, String? route
});




}
/// @nodoc
class __$ScheduledNoticeCopyWithImpl<$Res>
    implements _$ScheduledNoticeCopyWith<$Res> {
  __$ScheduledNoticeCopyWithImpl(this._self, this._then);

  final _ScheduledNotice _self;
  final $Res Function(_ScheduledNotice) _then;

/// Create a copy of ScheduledNotice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? at = null,Object? title = null,Object? body = null,Object? route = freezed,}) {
  return _then(_ScheduledNotice(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,at: null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,route: freezed == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
