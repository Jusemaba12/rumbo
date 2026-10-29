// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'practice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AnswerFeedback {

 int get score; List<String> get strengths; List<String> get improve; String get betterAnswer;
/// Create a copy of AnswerFeedback
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnswerFeedbackCopyWith<AnswerFeedback> get copyWith => _$AnswerFeedbackCopyWithImpl<AnswerFeedback>(this as AnswerFeedback, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AnswerFeedback;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnswerFeedback&&(identical(other.score, _this.score) || other.score == _this.score)&&const DeepCollectionEquality().equals(other.strengths, _this.strengths)&&const DeepCollectionEquality().equals(other.improve, _this.improve)&&(identical(other.betterAnswer, _this.betterAnswer) || other.betterAnswer == _this.betterAnswer));
}


@override
int get hashCode {
  final _this = this as AnswerFeedback;
  return Object.hash(runtimeType,_this.score,const DeepCollectionEquality().hash(_this.strengths),const DeepCollectionEquality().hash(_this.improve),_this.betterAnswer);
}

@override
String toString() {
  final _this = this as AnswerFeedback;
  return 'AnswerFeedback(score: ${_this.score}, strengths: ${_this.strengths}, improve: ${_this.improve}, betterAnswer: ${_this.betterAnswer})';
}


}

/// @nodoc
abstract mixin class $AnswerFeedbackCopyWith<$Res>  {
  factory $AnswerFeedbackCopyWith(AnswerFeedback value, $Res Function(AnswerFeedback) _then) = _$AnswerFeedbackCopyWithImpl;
@useResult
$Res call({
 int score, List<String> strengths, List<String> improve, String betterAnswer
});




}
/// @nodoc
class _$AnswerFeedbackCopyWithImpl<$Res>
    implements $AnswerFeedbackCopyWith<$Res> {
  _$AnswerFeedbackCopyWithImpl(this._self, this._then);

  final AnswerFeedback _self;
  final $Res Function(AnswerFeedback) _then;

/// Create a copy of AnswerFeedback
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? score = null,Object? strengths = null,Object? improve = null,Object? betterAnswer = null,}) {
  return _then(AnswerFeedback(
score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,strengths: null == strengths ? _self.strengths : strengths // ignore: cast_nullable_to_non_nullable
as List<String>,improve: null == improve ? _self.improve : improve // ignore: cast_nullable_to_non_nullable
as List<String>,betterAnswer: null == betterAnswer ? _self.betterAnswer : betterAnswer // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AnswerFeedback].
extension AnswerFeedbackPatterns on AnswerFeedback {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnswerFeedback value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnswerFeedback() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnswerFeedback value)  $default,){
final _that = this;
switch (_that) {
case _AnswerFeedback():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnswerFeedback value)?  $default,){
final _that = this;
switch (_that) {
case _AnswerFeedback() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int score,  List<String> strengths,  List<String> improve,  String betterAnswer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnswerFeedback() when $default != null:
return $default(_that.score,_that.strengths,_that.improve,_that.betterAnswer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int score,  List<String> strengths,  List<String> improve,  String betterAnswer)  $default,) {final _that = this;
switch (_that) {
case _AnswerFeedback():
return $default(_that.score,_that.strengths,_that.improve,_that.betterAnswer);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int score,  List<String> strengths,  List<String> improve,  String betterAnswer)?  $default,) {final _that = this;
switch (_that) {
case _AnswerFeedback() when $default != null:
return $default(_that.score,_that.strengths,_that.improve,_that.betterAnswer);case _:
  return null;

}
}

}

/// @nodoc


class _AnswerFeedback implements AnswerFeedback {
  const _AnswerFeedback({required this.score,  List<String> strengths = const [],  List<String> improve = const [], this.betterAnswer = ''}): _strengths = strengths,_improve = improve;
  

@override final  int score;
 final  List<String> _strengths;
@override@JsonKey() List<String> get strengths {
  if (_strengths is EqualUnmodifiableListView) return _strengths;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_strengths);
}

 final  List<String> _improve;
@override@JsonKey() List<String> get improve {
  if (_improve is EqualUnmodifiableListView) return _improve;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_improve);
}

@override@JsonKey() final  String betterAnswer;

/// Create a copy of AnswerFeedback
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnswerFeedbackCopyWith<_AnswerFeedback> get copyWith => __$AnswerFeedbackCopyWithImpl<_AnswerFeedback>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnswerFeedback&&(identical(other.score, score) || other.score == score)&&const DeepCollectionEquality().equals(other.strengths, _strengths)&&const DeepCollectionEquality().equals(other.improve, _improve)&&(identical(other.betterAnswer, betterAnswer) || other.betterAnswer == betterAnswer));
}


@override
int get hashCode {
    return Object.hash(runtimeType,score,const DeepCollectionEquality().hash(_strengths),const DeepCollectionEquality().hash(_improve),betterAnswer);
}

@override
String toString() {
    return 'AnswerFeedback(score: $score, strengths: $strengths, improve: $improve, betterAnswer: $betterAnswer)';
}


}

/// @nodoc
abstract mixin class _$AnswerFeedbackCopyWith<$Res> implements $AnswerFeedbackCopyWith<$Res> {
  factory _$AnswerFeedbackCopyWith(_AnswerFeedback value, $Res Function(_AnswerFeedback) _then) = __$AnswerFeedbackCopyWithImpl;
@override @useResult
$Res call({
 int score, List<String> strengths, List<String> improve, String betterAnswer
});




}
/// @nodoc
class __$AnswerFeedbackCopyWithImpl<$Res>
    implements _$AnswerFeedbackCopyWith<$Res> {
  __$AnswerFeedbackCopyWithImpl(this._self, this._then);

  final _AnswerFeedback _self;
  final $Res Function(_AnswerFeedback) _then;

/// Create a copy of AnswerFeedback
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? score = null,Object? strengths = null,Object? improve = null,Object? betterAnswer = null,}) {
  return _then(_AnswerFeedback(
score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,strengths: null == strengths ? _self._strengths : strengths // ignore: cast_nullable_to_non_nullable
as List<String>,improve: null == improve ? _self._improve : improve // ignore: cast_nullable_to_non_nullable
as List<String>,betterAnswer: null == betterAnswer ? _self.betterAnswer : betterAnswer // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$PracticeSummary {

 int get score; String get overall; List<String> get strengths; List<String> get improve;
/// Create a copy of PracticeSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PracticeSummaryCopyWith<PracticeSummary> get copyWith => _$PracticeSummaryCopyWithImpl<PracticeSummary>(this as PracticeSummary, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PracticeSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PracticeSummary&&(identical(other.score, _this.score) || other.score == _this.score)&&(identical(other.overall, _this.overall) || other.overall == _this.overall)&&const DeepCollectionEquality().equals(other.strengths, _this.strengths)&&const DeepCollectionEquality().equals(other.improve, _this.improve));
}


@override
int get hashCode {
  final _this = this as PracticeSummary;
  return Object.hash(runtimeType,_this.score,_this.overall,const DeepCollectionEquality().hash(_this.strengths),const DeepCollectionEquality().hash(_this.improve));
}

@override
String toString() {
  final _this = this as PracticeSummary;
  return 'PracticeSummary(score: ${_this.score}, overall: ${_this.overall}, strengths: ${_this.strengths}, improve: ${_this.improve})';
}


}

/// @nodoc
abstract mixin class $PracticeSummaryCopyWith<$Res>  {
  factory $PracticeSummaryCopyWith(PracticeSummary value, $Res Function(PracticeSummary) _then) = _$PracticeSummaryCopyWithImpl;
@useResult
$Res call({
 int score, String overall, List<String> strengths, List<String> improve
});




}
/// @nodoc
class _$PracticeSummaryCopyWithImpl<$Res>
    implements $PracticeSummaryCopyWith<$Res> {
  _$PracticeSummaryCopyWithImpl(this._self, this._then);

  final PracticeSummary _self;
  final $Res Function(PracticeSummary) _then;

/// Create a copy of PracticeSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? score = null,Object? overall = null,Object? strengths = null,Object? improve = null,}) {
  return _then(PracticeSummary(
score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,overall: null == overall ? _self.overall : overall // ignore: cast_nullable_to_non_nullable
as String,strengths: null == strengths ? _self.strengths : strengths // ignore: cast_nullable_to_non_nullable
as List<String>,improve: null == improve ? _self.improve : improve // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [PracticeSummary].
extension PracticeSummaryPatterns on PracticeSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PracticeSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PracticeSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PracticeSummary value)  $default,){
final _that = this;
switch (_that) {
case _PracticeSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PracticeSummary value)?  $default,){
final _that = this;
switch (_that) {
case _PracticeSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int score,  String overall,  List<String> strengths,  List<String> improve)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PracticeSummary() when $default != null:
return $default(_that.score,_that.overall,_that.strengths,_that.improve);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int score,  String overall,  List<String> strengths,  List<String> improve)  $default,) {final _that = this;
switch (_that) {
case _PracticeSummary():
return $default(_that.score,_that.overall,_that.strengths,_that.improve);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int score,  String overall,  List<String> strengths,  List<String> improve)?  $default,) {final _that = this;
switch (_that) {
case _PracticeSummary() when $default != null:
return $default(_that.score,_that.overall,_that.strengths,_that.improve);case _:
  return null;

}
}

}

/// @nodoc


class _PracticeSummary implements PracticeSummary {
  const _PracticeSummary({required this.score, this.overall = '',  List<String> strengths = const [],  List<String> improve = const []}): _strengths = strengths,_improve = improve;
  

@override final  int score;
@override@JsonKey() final  String overall;
 final  List<String> _strengths;
@override@JsonKey() List<String> get strengths {
  if (_strengths is EqualUnmodifiableListView) return _strengths;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_strengths);
}

 final  List<String> _improve;
@override@JsonKey() List<String> get improve {
  if (_improve is EqualUnmodifiableListView) return _improve;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_improve);
}


/// Create a copy of PracticeSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PracticeSummaryCopyWith<_PracticeSummary> get copyWith => __$PracticeSummaryCopyWithImpl<_PracticeSummary>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PracticeSummary&&(identical(other.score, score) || other.score == score)&&(identical(other.overall, overall) || other.overall == overall)&&const DeepCollectionEquality().equals(other.strengths, _strengths)&&const DeepCollectionEquality().equals(other.improve, _improve));
}


@override
int get hashCode {
    return Object.hash(runtimeType,score,overall,const DeepCollectionEquality().hash(_strengths),const DeepCollectionEquality().hash(_improve));
}

@override
String toString() {
    return 'PracticeSummary(score: $score, overall: $overall, strengths: $strengths, improve: $improve)';
}


}

/// @nodoc
abstract mixin class _$PracticeSummaryCopyWith<$Res> implements $PracticeSummaryCopyWith<$Res> {
  factory _$PracticeSummaryCopyWith(_PracticeSummary value, $Res Function(_PracticeSummary) _then) = __$PracticeSummaryCopyWithImpl;
@override @useResult
$Res call({
 int score, String overall, List<String> strengths, List<String> improve
});




}
/// @nodoc
class __$PracticeSummaryCopyWithImpl<$Res>
    implements _$PracticeSummaryCopyWith<$Res> {
  __$PracticeSummaryCopyWithImpl(this._self, this._then);

  final _PracticeSummary _self;
  final $Res Function(_PracticeSummary) _then;

/// Create a copy of PracticeSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? score = null,Object? overall = null,Object? strengths = null,Object? improve = null,}) {
  return _then(_PracticeSummary(
score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,overall: null == overall ? _self.overall : overall // ignore: cast_nullable_to_non_nullable
as String,strengths: null == strengths ? _self._strengths : strengths // ignore: cast_nullable_to_non_nullable
as List<String>,improve: null == improve ? _self._improve : improve // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc
mixin _$PracticeTurn {

 String get question; String get answer; AnswerFeedback? get feedback;
/// Create a copy of PracticeTurn
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PracticeTurnCopyWith<PracticeTurn> get copyWith => _$PracticeTurnCopyWithImpl<PracticeTurn>(this as PracticeTurn, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PracticeTurn;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PracticeTurn&&(identical(other.question, _this.question) || other.question == _this.question)&&(identical(other.answer, _this.answer) || other.answer == _this.answer)&&(identical(other.feedback, _this.feedback) || other.feedback == _this.feedback));
}


@override
int get hashCode {
  final _this = this as PracticeTurn;
  return Object.hash(runtimeType,_this.question,_this.answer,_this.feedback);
}

@override
String toString() {
  final _this = this as PracticeTurn;
  return 'PracticeTurn(question: ${_this.question}, answer: ${_this.answer}, feedback: ${_this.feedback})';
}


}

/// @nodoc
abstract mixin class $PracticeTurnCopyWith<$Res>  {
  factory $PracticeTurnCopyWith(PracticeTurn value, $Res Function(PracticeTurn) _then) = _$PracticeTurnCopyWithImpl;
@useResult
$Res call({
 String question, String answer, AnswerFeedback? feedback
});


$AnswerFeedbackCopyWith<$Res>? get feedback;

}
/// @nodoc
class _$PracticeTurnCopyWithImpl<$Res>
    implements $PracticeTurnCopyWith<$Res> {
  _$PracticeTurnCopyWithImpl(this._self, this._then);

  final PracticeTurn _self;
  final $Res Function(PracticeTurn) _then;

/// Create a copy of PracticeTurn
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? question = null,Object? answer = null,Object? feedback = freezed,}) {
  return _then(PracticeTurn(
question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String,feedback: freezed == feedback ? _self.feedback : feedback // ignore: cast_nullable_to_non_nullable
as AnswerFeedback?,
  ));
}
/// Create a copy of PracticeTurn
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AnswerFeedbackCopyWith<$Res>? get feedback {
    if (_self.feedback == null) {
    return null;
  }

  return $AnswerFeedbackCopyWith<$Res>(_self.feedback!, (value) {
    return _then(_self.copyWith(feedback: value));
  });
}
}


/// Adds pattern-matching-related methods to [PracticeTurn].
extension PracticeTurnPatterns on PracticeTurn {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PracticeTurn value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PracticeTurn() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PracticeTurn value)  $default,){
final _that = this;
switch (_that) {
case _PracticeTurn():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PracticeTurn value)?  $default,){
final _that = this;
switch (_that) {
case _PracticeTurn() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String question,  String answer,  AnswerFeedback? feedback)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PracticeTurn() when $default != null:
return $default(_that.question,_that.answer,_that.feedback);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String question,  String answer,  AnswerFeedback? feedback)  $default,) {final _that = this;
switch (_that) {
case _PracticeTurn():
return $default(_that.question,_that.answer,_that.feedback);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String question,  String answer,  AnswerFeedback? feedback)?  $default,) {final _that = this;
switch (_that) {
case _PracticeTurn() when $default != null:
return $default(_that.question,_that.answer,_that.feedback);case _:
  return null;

}
}

}

/// @nodoc


class _PracticeTurn implements PracticeTurn {
  const _PracticeTurn({required this.question, required this.answer, this.feedback});
  

@override final  String question;
@override final  String answer;
@override final  AnswerFeedback? feedback;

/// Create a copy of PracticeTurn
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PracticeTurnCopyWith<_PracticeTurn> get copyWith => __$PracticeTurnCopyWithImpl<_PracticeTurn>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PracticeTurn&&(identical(other.question, question) || other.question == question)&&(identical(other.answer, answer) || other.answer == answer)&&(identical(other.feedback, feedback) || other.feedback == feedback));
}


@override
int get hashCode {
    return Object.hash(runtimeType,question,answer,feedback);
}

@override
String toString() {
    return 'PracticeTurn(question: $question, answer: $answer, feedback: $feedback)';
}


}

/// @nodoc
abstract mixin class _$PracticeTurnCopyWith<$Res> implements $PracticeTurnCopyWith<$Res> {
  factory _$PracticeTurnCopyWith(_PracticeTurn value, $Res Function(_PracticeTurn) _then) = __$PracticeTurnCopyWithImpl;
@override @useResult
$Res call({
 String question, String answer, AnswerFeedback? feedback
});


@override $AnswerFeedbackCopyWith<$Res>? get feedback;

}
/// @nodoc
class __$PracticeTurnCopyWithImpl<$Res>
    implements _$PracticeTurnCopyWith<$Res> {
  __$PracticeTurnCopyWithImpl(this._self, this._then);

  final _PracticeTurn _self;
  final $Res Function(_PracticeTurn) _then;

/// Create a copy of PracticeTurn
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? question = null,Object? answer = null,Object? feedback = freezed,}) {
  return _then(_PracticeTurn(
question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String,feedback: freezed == feedback ? _self.feedback : feedback // ignore: cast_nullable_to_non_nullable
as AnswerFeedback?,
  ));
}

/// Create a copy of PracticeTurn
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AnswerFeedbackCopyWith<$Res>? get feedback {
    if (_self.feedback == null) {
    return null;
  }

  return $AnswerFeedbackCopyWith<$Res>(_self.feedback!, (value) {
    return _then(_self.copyWith(feedback: value));
  });
}
}

/// @nodoc
mixin _$CoachReply {

 AnswerFeedback? get feedback; String? get nextQuestion; PracticeSummary? get summary;
/// Create a copy of CoachReply
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoachReplyCopyWith<CoachReply> get copyWith => _$CoachReplyCopyWithImpl<CoachReply>(this as CoachReply, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CoachReply;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoachReply&&(identical(other.feedback, _this.feedback) || other.feedback == _this.feedback)&&(identical(other.nextQuestion, _this.nextQuestion) || other.nextQuestion == _this.nextQuestion)&&(identical(other.summary, _this.summary) || other.summary == _this.summary));
}


@override
int get hashCode {
  final _this = this as CoachReply;
  return Object.hash(runtimeType,_this.feedback,_this.nextQuestion,_this.summary);
}

@override
String toString() {
  final _this = this as CoachReply;
  return 'CoachReply(feedback: ${_this.feedback}, nextQuestion: ${_this.nextQuestion}, summary: ${_this.summary})';
}


}

/// @nodoc
abstract mixin class $CoachReplyCopyWith<$Res>  {
  factory $CoachReplyCopyWith(CoachReply value, $Res Function(CoachReply) _then) = _$CoachReplyCopyWithImpl;
@useResult
$Res call({
 AnswerFeedback? feedback, String? nextQuestion, PracticeSummary? summary
});


$AnswerFeedbackCopyWith<$Res>? get feedback;$PracticeSummaryCopyWith<$Res>? get summary;

}
/// @nodoc
class _$CoachReplyCopyWithImpl<$Res>
    implements $CoachReplyCopyWith<$Res> {
  _$CoachReplyCopyWithImpl(this._self, this._then);

  final CoachReply _self;
  final $Res Function(CoachReply) _then;

/// Create a copy of CoachReply
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? feedback = freezed,Object? nextQuestion = freezed,Object? summary = freezed,}) {
  return _then(CoachReply(
feedback: freezed == feedback ? _self.feedback : feedback // ignore: cast_nullable_to_non_nullable
as AnswerFeedback?,nextQuestion: freezed == nextQuestion ? _self.nextQuestion : nextQuestion // ignore: cast_nullable_to_non_nullable
as String?,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as PracticeSummary?,
  ));
}
/// Create a copy of CoachReply
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AnswerFeedbackCopyWith<$Res>? get feedback {
    if (_self.feedback == null) {
    return null;
  }

  return $AnswerFeedbackCopyWith<$Res>(_self.feedback!, (value) {
    return _then(_self.copyWith(feedback: value));
  });
}/// Create a copy of CoachReply
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PracticeSummaryCopyWith<$Res>? get summary {
    if (_self.summary == null) {
    return null;
  }

  return $PracticeSummaryCopyWith<$Res>(_self.summary!, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// Adds pattern-matching-related methods to [CoachReply].
extension CoachReplyPatterns on CoachReply {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CoachReply value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CoachReply() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CoachReply value)  $default,){
final _that = this;
switch (_that) {
case _CoachReply():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CoachReply value)?  $default,){
final _that = this;
switch (_that) {
case _CoachReply() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AnswerFeedback? feedback,  String? nextQuestion,  PracticeSummary? summary)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CoachReply() when $default != null:
return $default(_that.feedback,_that.nextQuestion,_that.summary);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AnswerFeedback? feedback,  String? nextQuestion,  PracticeSummary? summary)  $default,) {final _that = this;
switch (_that) {
case _CoachReply():
return $default(_that.feedback,_that.nextQuestion,_that.summary);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AnswerFeedback? feedback,  String? nextQuestion,  PracticeSummary? summary)?  $default,) {final _that = this;
switch (_that) {
case _CoachReply() when $default != null:
return $default(_that.feedback,_that.nextQuestion,_that.summary);case _:
  return null;

}
}

}

/// @nodoc


class _CoachReply implements CoachReply {
  const _CoachReply({this.feedback, this.nextQuestion, this.summary});
  

@override final  AnswerFeedback? feedback;
@override final  String? nextQuestion;
@override final  PracticeSummary? summary;

/// Create a copy of CoachReply
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CoachReplyCopyWith<_CoachReply> get copyWith => __$CoachReplyCopyWithImpl<_CoachReply>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CoachReply&&(identical(other.feedback, feedback) || other.feedback == feedback)&&(identical(other.nextQuestion, nextQuestion) || other.nextQuestion == nextQuestion)&&(identical(other.summary, summary) || other.summary == summary));
}


@override
int get hashCode {
    return Object.hash(runtimeType,feedback,nextQuestion,summary);
}

@override
String toString() {
    return 'CoachReply(feedback: $feedback, nextQuestion: $nextQuestion, summary: $summary)';
}


}

/// @nodoc
abstract mixin class _$CoachReplyCopyWith<$Res> implements $CoachReplyCopyWith<$Res> {
  factory _$CoachReplyCopyWith(_CoachReply value, $Res Function(_CoachReply) _then) = __$CoachReplyCopyWithImpl;
@override @useResult
$Res call({
 AnswerFeedback? feedback, String? nextQuestion, PracticeSummary? summary
});


@override $AnswerFeedbackCopyWith<$Res>? get feedback;@override $PracticeSummaryCopyWith<$Res>? get summary;

}
/// @nodoc
class __$CoachReplyCopyWithImpl<$Res>
    implements _$CoachReplyCopyWith<$Res> {
  __$CoachReplyCopyWithImpl(this._self, this._then);

  final _CoachReply _self;
  final $Res Function(_CoachReply) _then;

/// Create a copy of CoachReply
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? feedback = freezed,Object? nextQuestion = freezed,Object? summary = freezed,}) {
  return _then(_CoachReply(
feedback: freezed == feedback ? _self.feedback : feedback // ignore: cast_nullable_to_non_nullable
as AnswerFeedback?,nextQuestion: freezed == nextQuestion ? _self.nextQuestion : nextQuestion // ignore: cast_nullable_to_non_nullable
as String?,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as PracticeSummary?,
  ));
}

/// Create a copy of CoachReply
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AnswerFeedbackCopyWith<$Res>? get feedback {
    if (_self.feedback == null) {
    return null;
  }

  return $AnswerFeedbackCopyWith<$Res>(_self.feedback!, (value) {
    return _then(_self.copyWith(feedback: value));
  });
}/// Create a copy of CoachReply
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PracticeSummaryCopyWith<$Res>? get summary {
    if (_self.summary == null) {
    return null;
  }

  return $PracticeSummaryCopyWith<$Res>(_self.summary!, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}

// dart format on
