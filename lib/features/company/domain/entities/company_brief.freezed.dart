// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_brief.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompanyBrief {

 String get summary; List<String> get teamAndStack; List<String> get culture; List<String> get questionsToAsk; List<String> get redFlags; String get generalKnowledge; DateTime? get generatedAt;
/// Create a copy of CompanyBrief
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompanyBriefCopyWith<CompanyBrief> get copyWith => _$CompanyBriefCopyWithImpl<CompanyBrief>(this as CompanyBrief, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CompanyBrief;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyBrief&&(identical(other.summary, _this.summary) || other.summary == _this.summary)&&const DeepCollectionEquality().equals(other.teamAndStack, _this.teamAndStack)&&const DeepCollectionEquality().equals(other.culture, _this.culture)&&const DeepCollectionEquality().equals(other.questionsToAsk, _this.questionsToAsk)&&const DeepCollectionEquality().equals(other.redFlags, _this.redFlags)&&(identical(other.generalKnowledge, _this.generalKnowledge) || other.generalKnowledge == _this.generalKnowledge)&&(identical(other.generatedAt, _this.generatedAt) || other.generatedAt == _this.generatedAt));
}


@override
int get hashCode {
  final _this = this as CompanyBrief;
  return Object.hash(runtimeType,_this.summary,const DeepCollectionEquality().hash(_this.teamAndStack),const DeepCollectionEquality().hash(_this.culture),const DeepCollectionEquality().hash(_this.questionsToAsk),const DeepCollectionEquality().hash(_this.redFlags),_this.generalKnowledge,_this.generatedAt);
}

@override
String toString() {
  final _this = this as CompanyBrief;
  return 'CompanyBrief(summary: ${_this.summary}, teamAndStack: ${_this.teamAndStack}, culture: ${_this.culture}, questionsToAsk: ${_this.questionsToAsk}, redFlags: ${_this.redFlags}, generalKnowledge: ${_this.generalKnowledge}, generatedAt: ${_this.generatedAt})';
}


}

/// @nodoc
abstract mixin class $CompanyBriefCopyWith<$Res>  {
  factory $CompanyBriefCopyWith(CompanyBrief value, $Res Function(CompanyBrief) _then) = _$CompanyBriefCopyWithImpl;
@useResult
$Res call({
 String summary, List<String> teamAndStack, List<String> culture, List<String> questionsToAsk, List<String> redFlags, String generalKnowledge, DateTime? generatedAt
});




}
/// @nodoc
class _$CompanyBriefCopyWithImpl<$Res>
    implements $CompanyBriefCopyWith<$Res> {
  _$CompanyBriefCopyWithImpl(this._self, this._then);

  final CompanyBrief _self;
  final $Res Function(CompanyBrief) _then;

/// Create a copy of CompanyBrief
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? summary = null,Object? teamAndStack = null,Object? culture = null,Object? questionsToAsk = null,Object? redFlags = null,Object? generalKnowledge = null,Object? generatedAt = freezed,}) {
  return _then(CompanyBrief(
summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,teamAndStack: null == teamAndStack ? _self.teamAndStack : teamAndStack // ignore: cast_nullable_to_non_nullable
as List<String>,culture: null == culture ? _self.culture : culture // ignore: cast_nullable_to_non_nullable
as List<String>,questionsToAsk: null == questionsToAsk ? _self.questionsToAsk : questionsToAsk // ignore: cast_nullable_to_non_nullable
as List<String>,redFlags: null == redFlags ? _self.redFlags : redFlags // ignore: cast_nullable_to_non_nullable
as List<String>,generalKnowledge: null == generalKnowledge ? _self.generalKnowledge : generalKnowledge // ignore: cast_nullable_to_non_nullable
as String,generatedAt: freezed == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [CompanyBrief].
extension CompanyBriefPatterns on CompanyBrief {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompanyBrief value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompanyBrief() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompanyBrief value)  $default,){
final _that = this;
switch (_that) {
case _CompanyBrief():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompanyBrief value)?  $default,){
final _that = this;
switch (_that) {
case _CompanyBrief() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String summary,  List<String> teamAndStack,  List<String> culture,  List<String> questionsToAsk,  List<String> redFlags,  String generalKnowledge,  DateTime? generatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompanyBrief() when $default != null:
return $default(_that.summary,_that.teamAndStack,_that.culture,_that.questionsToAsk,_that.redFlags,_that.generalKnowledge,_that.generatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String summary,  List<String> teamAndStack,  List<String> culture,  List<String> questionsToAsk,  List<String> redFlags,  String generalKnowledge,  DateTime? generatedAt)  $default,) {final _that = this;
switch (_that) {
case _CompanyBrief():
return $default(_that.summary,_that.teamAndStack,_that.culture,_that.questionsToAsk,_that.redFlags,_that.generalKnowledge,_that.generatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String summary,  List<String> teamAndStack,  List<String> culture,  List<String> questionsToAsk,  List<String> redFlags,  String generalKnowledge,  DateTime? generatedAt)?  $default,) {final _that = this;
switch (_that) {
case _CompanyBrief() when $default != null:
return $default(_that.summary,_that.teamAndStack,_that.culture,_that.questionsToAsk,_that.redFlags,_that.generalKnowledge,_that.generatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _CompanyBrief implements CompanyBrief {
  const _CompanyBrief({required this.summary,  List<String> teamAndStack = const <String>[],  List<String> culture = const <String>[],  List<String> questionsToAsk = const <String>[],  List<String> redFlags = const <String>[], this.generalKnowledge = '', this.generatedAt}): _teamAndStack = teamAndStack,_culture = culture,_questionsToAsk = questionsToAsk,_redFlags = redFlags;
  

@override final  String summary;
 final  List<String> _teamAndStack;
@override@JsonKey() List<String> get teamAndStack {
  if (_teamAndStack is EqualUnmodifiableListView) return _teamAndStack;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_teamAndStack);
}

 final  List<String> _culture;
@override@JsonKey() List<String> get culture {
  if (_culture is EqualUnmodifiableListView) return _culture;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_culture);
}

 final  List<String> _questionsToAsk;
@override@JsonKey() List<String> get questionsToAsk {
  if (_questionsToAsk is EqualUnmodifiableListView) return _questionsToAsk;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questionsToAsk);
}

 final  List<String> _redFlags;
@override@JsonKey() List<String> get redFlags {
  if (_redFlags is EqualUnmodifiableListView) return _redFlags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_redFlags);
}

@override@JsonKey() final  String generalKnowledge;
@override final  DateTime? generatedAt;

/// Create a copy of CompanyBrief
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompanyBriefCopyWith<_CompanyBrief> get copyWith => __$CompanyBriefCopyWithImpl<_CompanyBrief>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompanyBrief&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other.teamAndStack, _teamAndStack)&&const DeepCollectionEquality().equals(other.culture, _culture)&&const DeepCollectionEquality().equals(other.questionsToAsk, _questionsToAsk)&&const DeepCollectionEquality().equals(other.redFlags, _redFlags)&&(identical(other.generalKnowledge, generalKnowledge) || other.generalKnowledge == generalKnowledge)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,summary,const DeepCollectionEquality().hash(_teamAndStack),const DeepCollectionEquality().hash(_culture),const DeepCollectionEquality().hash(_questionsToAsk),const DeepCollectionEquality().hash(_redFlags),generalKnowledge,generatedAt);
}

@override
String toString() {
    return 'CompanyBrief(summary: $summary, teamAndStack: $teamAndStack, culture: $culture, questionsToAsk: $questionsToAsk, redFlags: $redFlags, generalKnowledge: $generalKnowledge, generatedAt: $generatedAt)';
}


}

/// @nodoc
abstract mixin class _$CompanyBriefCopyWith<$Res> implements $CompanyBriefCopyWith<$Res> {
  factory _$CompanyBriefCopyWith(_CompanyBrief value, $Res Function(_CompanyBrief) _then) = __$CompanyBriefCopyWithImpl;
@override @useResult
$Res call({
 String summary, List<String> teamAndStack, List<String> culture, List<String> questionsToAsk, List<String> redFlags, String generalKnowledge, DateTime? generatedAt
});




}
/// @nodoc
class __$CompanyBriefCopyWithImpl<$Res>
    implements _$CompanyBriefCopyWith<$Res> {
  __$CompanyBriefCopyWithImpl(this._self, this._then);

  final _CompanyBrief _self;
  final $Res Function(_CompanyBrief) _then;

/// Create a copy of CompanyBrief
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? summary = null,Object? teamAndStack = null,Object? culture = null,Object? questionsToAsk = null,Object? redFlags = null,Object? generalKnowledge = null,Object? generatedAt = freezed,}) {
  return _then(_CompanyBrief(
summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,teamAndStack: null == teamAndStack ? _self._teamAndStack : teamAndStack // ignore: cast_nullable_to_non_nullable
as List<String>,culture: null == culture ? _self._culture : culture // ignore: cast_nullable_to_non_nullable
as List<String>,questionsToAsk: null == questionsToAsk ? _self._questionsToAsk : questionsToAsk // ignore: cast_nullable_to_non_nullable
as List<String>,redFlags: null == redFlags ? _self._redFlags : redFlags // ignore: cast_nullable_to_non_nullable
as List<String>,generalKnowledge: null == generalKnowledge ? _self.generalKnowledge : generalKnowledge // ignore: cast_nullable_to_non_nullable
as String,generatedAt: freezed == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
