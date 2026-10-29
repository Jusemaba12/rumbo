// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'email_drafter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EmailDraft implements DiagnosticableTreeMixin {

 String get subject; String get body; String get to;
/// Create a copy of EmailDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmailDraftCopyWith<EmailDraft> get copyWith => _$EmailDraftCopyWithImpl<EmailDraft>(this as EmailDraft, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  final _this = this as EmailDraft;
  properties
    ..add(DiagnosticsProperty('type', 'EmailDraft'))
    ..add(DiagnosticsProperty('subject', _this.subject))..add(DiagnosticsProperty('body', _this.body))..add(DiagnosticsProperty('to', _this.to));
}

@override
bool operator ==(Object other) {
  final _this = this as EmailDraft;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailDraft&&(identical(other.subject, _this.subject) || other.subject == _this.subject)&&(identical(other.body, _this.body) || other.body == _this.body)&&(identical(other.to, _this.to) || other.to == _this.to));
}


@override
int get hashCode {
  final _this = this as EmailDraft;
  return Object.hash(runtimeType,_this.subject,_this.body,_this.to);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  final _this = this as EmailDraft;
  return 'EmailDraft(subject: ${_this.subject}, body: ${_this.body}, to: ${_this.to})';
}


}

/// @nodoc
abstract mixin class $EmailDraftCopyWith<$Res>  {
  factory $EmailDraftCopyWith(EmailDraft value, $Res Function(EmailDraft) _then) = _$EmailDraftCopyWithImpl;
@useResult
$Res call({
 String subject, String body, String to
});




}
/// @nodoc
class _$EmailDraftCopyWithImpl<$Res>
    implements $EmailDraftCopyWith<$Res> {
  _$EmailDraftCopyWithImpl(this._self, this._then);

  final EmailDraft _self;
  final $Res Function(EmailDraft) _then;

/// Create a copy of EmailDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? subject = null,Object? body = null,Object? to = null,}) {
  return _then(EmailDraft(
subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EmailDraft].
extension EmailDraftPatterns on EmailDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmailDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmailDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmailDraft value)  $default,){
final _that = this;
switch (_that) {
case _EmailDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmailDraft value)?  $default,){
final _that = this;
switch (_that) {
case _EmailDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String subject,  String body,  String to)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmailDraft() when $default != null:
return $default(_that.subject,_that.body,_that.to);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String subject,  String body,  String to)  $default,) {final _that = this;
switch (_that) {
case _EmailDraft():
return $default(_that.subject,_that.body,_that.to);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String subject,  String body,  String to)?  $default,) {final _that = this;
switch (_that) {
case _EmailDraft() when $default != null:
return $default(_that.subject,_that.body,_that.to);case _:
  return null;

}
}

}

/// @nodoc


class _EmailDraft with DiagnosticableTreeMixin implements EmailDraft {
  const _EmailDraft({required this.subject, required this.body, this.to = ''});
  

@override final  String subject;
@override final  String body;
@override@JsonKey() final  String to;

/// Create a copy of EmailDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmailDraftCopyWith<_EmailDraft> get copyWith => __$EmailDraftCopyWithImpl<_EmailDraft>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
    ..add(DiagnosticsProperty('type', 'EmailDraft'))
    ..add(DiagnosticsProperty('subject', subject))..add(DiagnosticsProperty('body', body))..add(DiagnosticsProperty('to', to));
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmailDraft&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.body, body) || other.body == body)&&(identical(other.to, to) || other.to == to));
}


@override
int get hashCode {
    return Object.hash(runtimeType,subject,body,to);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
    return 'EmailDraft(subject: $subject, body: $body, to: $to)';
}


}

/// @nodoc
abstract mixin class _$EmailDraftCopyWith<$Res> implements $EmailDraftCopyWith<$Res> {
  factory _$EmailDraftCopyWith(_EmailDraft value, $Res Function(_EmailDraft) _then) = __$EmailDraftCopyWithImpl;
@override @useResult
$Res call({
 String subject, String body, String to
});




}
/// @nodoc
class __$EmailDraftCopyWithImpl<$Res>
    implements _$EmailDraftCopyWith<$Res> {
  __$EmailDraftCopyWithImpl(this._self, this._then);

  final _EmailDraft _self;
  final $Res Function(_EmailDraft) _then;

/// Create a copy of EmailDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? subject = null,Object? body = null,Object? to = null,}) {
  return _then(_EmailDraft(
subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
