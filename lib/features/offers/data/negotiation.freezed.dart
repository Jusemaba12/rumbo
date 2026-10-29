// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'negotiation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NegotiationDraft implements DiagnosticableTreeMixin {

 String get email; List<String> get talkingPoints; List<String> get risks;
/// Create a copy of NegotiationDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NegotiationDraftCopyWith<NegotiationDraft> get copyWith => _$NegotiationDraftCopyWithImpl<NegotiationDraft>(this as NegotiationDraft, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  final _this = this as NegotiationDraft;
  properties
    ..add(DiagnosticsProperty('type', 'NegotiationDraft'))
    ..add(DiagnosticsProperty('email', _this.email))..add(DiagnosticsProperty('talkingPoints', _this.talkingPoints))..add(DiagnosticsProperty('risks', _this.risks));
}

@override
bool operator ==(Object other) {
  final _this = this as NegotiationDraft;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NegotiationDraft&&(identical(other.email, _this.email) || other.email == _this.email)&&const DeepCollectionEquality().equals(other.talkingPoints, _this.talkingPoints)&&const DeepCollectionEquality().equals(other.risks, _this.risks));
}


@override
int get hashCode {
  final _this = this as NegotiationDraft;
  return Object.hash(runtimeType,_this.email,const DeepCollectionEquality().hash(_this.talkingPoints),const DeepCollectionEquality().hash(_this.risks));
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  final _this = this as NegotiationDraft;
  return 'NegotiationDraft(email: ${_this.email}, talkingPoints: ${_this.talkingPoints}, risks: ${_this.risks})';
}


}

/// @nodoc
abstract mixin class $NegotiationDraftCopyWith<$Res>  {
  factory $NegotiationDraftCopyWith(NegotiationDraft value, $Res Function(NegotiationDraft) _then) = _$NegotiationDraftCopyWithImpl;
@useResult
$Res call({
 String email, List<String> talkingPoints, List<String> risks
});




}
/// @nodoc
class _$NegotiationDraftCopyWithImpl<$Res>
    implements $NegotiationDraftCopyWith<$Res> {
  _$NegotiationDraftCopyWithImpl(this._self, this._then);

  final NegotiationDraft _self;
  final $Res Function(NegotiationDraft) _then;

/// Create a copy of NegotiationDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? talkingPoints = null,Object? risks = null,}) {
  return _then(NegotiationDraft(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,talkingPoints: null == talkingPoints ? _self.talkingPoints : talkingPoints // ignore: cast_nullable_to_non_nullable
as List<String>,risks: null == risks ? _self.risks : risks // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [NegotiationDraft].
extension NegotiationDraftPatterns on NegotiationDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NegotiationDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NegotiationDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NegotiationDraft value)  $default,){
final _that = this;
switch (_that) {
case _NegotiationDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NegotiationDraft value)?  $default,){
final _that = this;
switch (_that) {
case _NegotiationDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  List<String> talkingPoints,  List<String> risks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NegotiationDraft() when $default != null:
return $default(_that.email,_that.talkingPoints,_that.risks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  List<String> talkingPoints,  List<String> risks)  $default,) {final _that = this;
switch (_that) {
case _NegotiationDraft():
return $default(_that.email,_that.talkingPoints,_that.risks);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  List<String> talkingPoints,  List<String> risks)?  $default,) {final _that = this;
switch (_that) {
case _NegotiationDraft() when $default != null:
return $default(_that.email,_that.talkingPoints,_that.risks);case _:
  return null;

}
}

}

/// @nodoc


class _NegotiationDraft with DiagnosticableTreeMixin implements NegotiationDraft {
  const _NegotiationDraft({required this.email,  List<String> talkingPoints = const [],  List<String> risks = const []}): _talkingPoints = talkingPoints,_risks = risks;
  

@override final  String email;
 final  List<String> _talkingPoints;
@override@JsonKey() List<String> get talkingPoints {
  if (_talkingPoints is EqualUnmodifiableListView) return _talkingPoints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_talkingPoints);
}

 final  List<String> _risks;
@override@JsonKey() List<String> get risks {
  if (_risks is EqualUnmodifiableListView) return _risks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_risks);
}


/// Create a copy of NegotiationDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NegotiationDraftCopyWith<_NegotiationDraft> get copyWith => __$NegotiationDraftCopyWithImpl<_NegotiationDraft>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
    ..add(DiagnosticsProperty('type', 'NegotiationDraft'))
    ..add(DiagnosticsProperty('email', email))..add(DiagnosticsProperty('talkingPoints', talkingPoints))..add(DiagnosticsProperty('risks', risks));
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NegotiationDraft&&(identical(other.email, email) || other.email == email)&&const DeepCollectionEquality().equals(other.talkingPoints, _talkingPoints)&&const DeepCollectionEquality().equals(other.risks, _risks));
}


@override
int get hashCode {
    return Object.hash(runtimeType,email,const DeepCollectionEquality().hash(_talkingPoints),const DeepCollectionEquality().hash(_risks));
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
    return 'NegotiationDraft(email: $email, talkingPoints: $talkingPoints, risks: $risks)';
}


}

/// @nodoc
abstract mixin class _$NegotiationDraftCopyWith<$Res> implements $NegotiationDraftCopyWith<$Res> {
  factory _$NegotiationDraftCopyWith(_NegotiationDraft value, $Res Function(_NegotiationDraft) _then) = __$NegotiationDraftCopyWithImpl;
@override @useResult
$Res call({
 String email, List<String> talkingPoints, List<String> risks
});




}
/// @nodoc
class __$NegotiationDraftCopyWithImpl<$Res>
    implements _$NegotiationDraftCopyWith<$Res> {
  __$NegotiationDraftCopyWithImpl(this._self, this._then);

  final _NegotiationDraft _self;
  final $Res Function(_NegotiationDraft) _then;

/// Create a copy of NegotiationDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? talkingPoints = null,Object? risks = null,}) {
  return _then(_NegotiationDraft(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,talkingPoints: null == talkingPoints ? _self._talkingPoints : talkingPoints // ignore: cast_nullable_to_non_nullable
as List<String>,risks: null == risks ? _self._risks : risks // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
