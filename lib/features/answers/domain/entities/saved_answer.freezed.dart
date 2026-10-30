// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_answer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SavedAnswer {

 String get id; String get question; String get answer; DateTime? get updatedAt;
/// Create a copy of SavedAnswer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavedAnswerCopyWith<SavedAnswer> get copyWith => _$SavedAnswerCopyWithImpl<SavedAnswer>(this as SavedAnswer, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SavedAnswer;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavedAnswer&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.question, _this.question) || other.question == _this.question)&&(identical(other.answer, _this.answer) || other.answer == _this.answer)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}


@override
int get hashCode {
  final _this = this as SavedAnswer;
  return Object.hash(runtimeType,_this.id,_this.question,_this.answer,_this.updatedAt);
}

@override
String toString() {
  final _this = this as SavedAnswer;
  return 'SavedAnswer(id: ${_this.id}, question: ${_this.question}, answer: ${_this.answer}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $SavedAnswerCopyWith<$Res>  {
  factory $SavedAnswerCopyWith(SavedAnswer value, $Res Function(SavedAnswer) _then) = _$SavedAnswerCopyWithImpl;
@useResult
$Res call({
 String id, String question, String answer, DateTime? updatedAt
});




}
/// @nodoc
class _$SavedAnswerCopyWithImpl<$Res>
    implements $SavedAnswerCopyWith<$Res> {
  _$SavedAnswerCopyWithImpl(this._self, this._then);

  final SavedAnswer _self;
  final $Res Function(SavedAnswer) _then;

/// Create a copy of SavedAnswer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? question = null,Object? answer = null,Object? updatedAt = freezed,}) {
  return _then(SavedAnswer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [SavedAnswer].
extension SavedAnswerPatterns on SavedAnswer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavedAnswer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavedAnswer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavedAnswer value)  $default,){
final _that = this;
switch (_that) {
case _SavedAnswer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavedAnswer value)?  $default,){
final _that = this;
switch (_that) {
case _SavedAnswer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String question,  String answer,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavedAnswer() when $default != null:
return $default(_that.id,_that.question,_that.answer,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String question,  String answer,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _SavedAnswer():
return $default(_that.id,_that.question,_that.answer,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String question,  String answer,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _SavedAnswer() when $default != null:
return $default(_that.id,_that.question,_that.answer,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _SavedAnswer implements SavedAnswer {
  const _SavedAnswer({this.id = '', required this.question, this.answer = '', this.updatedAt});
  

@override@JsonKey() final  String id;
@override final  String question;
@override@JsonKey() final  String answer;
@override final  DateTime? updatedAt;

/// Create a copy of SavedAnswer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavedAnswerCopyWith<_SavedAnswer> get copyWith => __$SavedAnswerCopyWithImpl<_SavedAnswer>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavedAnswer&&(identical(other.id, id) || other.id == id)&&(identical(other.question, question) || other.question == question)&&(identical(other.answer, answer) || other.answer == answer)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,question,answer,updatedAt);
}

@override
String toString() {
    return 'SavedAnswer(id: $id, question: $question, answer: $answer, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$SavedAnswerCopyWith<$Res> implements $SavedAnswerCopyWith<$Res> {
  factory _$SavedAnswerCopyWith(_SavedAnswer value, $Res Function(_SavedAnswer) _then) = __$SavedAnswerCopyWithImpl;
@override @useResult
$Res call({
 String id, String question, String answer, DateTime? updatedAt
});




}
/// @nodoc
class __$SavedAnswerCopyWithImpl<$Res>
    implements _$SavedAnswerCopyWith<$Res> {
  __$SavedAnswerCopyWithImpl(this._self, this._then);

  final _SavedAnswer _self;
  final $Res Function(_SavedAnswer) _then;

/// Create a copy of SavedAnswer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? question = null,Object? answer = null,Object? updatedAt = freezed,}) {
  return _then(_SavedAnswer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
