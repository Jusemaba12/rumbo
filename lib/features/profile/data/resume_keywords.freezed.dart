// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resume_keywords.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ResumeKeyword implements DiagnosticableTreeMixin {

 String get keyword; bool get important; String get reason;/// Otras formas en que aparece (RESTful, APIs REST…), según la IA.
 List<String> get aliases;
/// Create a copy of ResumeKeyword
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResumeKeywordCopyWith<ResumeKeyword> get copyWith => _$ResumeKeywordCopyWithImpl<ResumeKeyword>(this as ResumeKeyword, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  final _this = this as ResumeKeyword;
  properties
    ..add(DiagnosticsProperty('type', 'ResumeKeyword'))
    ..add(DiagnosticsProperty('keyword', _this.keyword))..add(DiagnosticsProperty('important', _this.important))..add(DiagnosticsProperty('reason', _this.reason))..add(DiagnosticsProperty('aliases', _this.aliases));
}

@override
bool operator ==(Object other) {
  final _this = this as ResumeKeyword;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResumeKeyword&&(identical(other.keyword, _this.keyword) || other.keyword == _this.keyword)&&(identical(other.important, _this.important) || other.important == _this.important)&&(identical(other.reason, _this.reason) || other.reason == _this.reason)&&const DeepCollectionEquality().equals(other.aliases, _this.aliases));
}


@override
int get hashCode {
  final _this = this as ResumeKeyword;
  return Object.hash(runtimeType,_this.keyword,_this.important,_this.reason,const DeepCollectionEquality().hash(_this.aliases));
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  final _this = this as ResumeKeyword;
  return 'ResumeKeyword(keyword: ${_this.keyword}, important: ${_this.important}, reason: ${_this.reason}, aliases: ${_this.aliases})';
}


}

/// @nodoc
abstract mixin class $ResumeKeywordCopyWith<$Res>  {
  factory $ResumeKeywordCopyWith(ResumeKeyword value, $Res Function(ResumeKeyword) _then) = _$ResumeKeywordCopyWithImpl;
@useResult
$Res call({
 String keyword, bool important, String reason, List<String> aliases
});




}
/// @nodoc
class _$ResumeKeywordCopyWithImpl<$Res>
    implements $ResumeKeywordCopyWith<$Res> {
  _$ResumeKeywordCopyWithImpl(this._self, this._then);

  final ResumeKeyword _self;
  final $Res Function(ResumeKeyword) _then;

/// Create a copy of ResumeKeyword
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? keyword = null,Object? important = null,Object? reason = null,Object? aliases = null,}) {
  return _then(ResumeKeyword(
keyword: null == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String,important: null == important ? _self.important : important // ignore: cast_nullable_to_non_nullable
as bool,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,aliases: null == aliases ? _self.aliases : aliases // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [ResumeKeyword].
extension ResumeKeywordPatterns on ResumeKeyword {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResumeKeyword value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResumeKeyword() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResumeKeyword value)  $default,){
final _that = this;
switch (_that) {
case _ResumeKeyword():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResumeKeyword value)?  $default,){
final _that = this;
switch (_that) {
case _ResumeKeyword() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String keyword,  bool important,  String reason,  List<String> aliases)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResumeKeyword() when $default != null:
return $default(_that.keyword,_that.important,_that.reason,_that.aliases);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String keyword,  bool important,  String reason,  List<String> aliases)  $default,) {final _that = this;
switch (_that) {
case _ResumeKeyword():
return $default(_that.keyword,_that.important,_that.reason,_that.aliases);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String keyword,  bool important,  String reason,  List<String> aliases)?  $default,) {final _that = this;
switch (_that) {
case _ResumeKeyword() when $default != null:
return $default(_that.keyword,_that.important,_that.reason,_that.aliases);case _:
  return null;

}
}

}

/// @nodoc


class _ResumeKeyword with DiagnosticableTreeMixin implements ResumeKeyword {
  const _ResumeKeyword({required this.keyword, required this.important, this.reason = '',  List<String> aliases = const []}): _aliases = aliases;
  

@override final  String keyword;
@override final  bool important;
@override@JsonKey() final  String reason;
/// Otras formas en que aparece (RESTful, APIs REST…), según la IA.
 final  List<String> _aliases;
/// Otras formas en que aparece (RESTful, APIs REST…), según la IA.
@override@JsonKey() List<String> get aliases {
  if (_aliases is EqualUnmodifiableListView) return _aliases;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_aliases);
}


/// Create a copy of ResumeKeyword
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResumeKeywordCopyWith<_ResumeKeyword> get copyWith => __$ResumeKeywordCopyWithImpl<_ResumeKeyword>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
    ..add(DiagnosticsProperty('type', 'ResumeKeyword'))
    ..add(DiagnosticsProperty('keyword', keyword))..add(DiagnosticsProperty('important', important))..add(DiagnosticsProperty('reason', reason))..add(DiagnosticsProperty('aliases', aliases));
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResumeKeyword&&(identical(other.keyword, keyword) || other.keyword == keyword)&&(identical(other.important, important) || other.important == important)&&(identical(other.reason, reason) || other.reason == reason)&&const DeepCollectionEquality().equals(other.aliases, _aliases));
}


@override
int get hashCode {
    return Object.hash(runtimeType,keyword,important,reason,const DeepCollectionEquality().hash(_aliases));
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
    return 'ResumeKeyword(keyword: $keyword, important: $important, reason: $reason, aliases: $aliases)';
}


}

/// @nodoc
abstract mixin class _$ResumeKeywordCopyWith<$Res> implements $ResumeKeywordCopyWith<$Res> {
  factory _$ResumeKeywordCopyWith(_ResumeKeyword value, $Res Function(_ResumeKeyword) _then) = __$ResumeKeywordCopyWithImpl;
@override @useResult
$Res call({
 String keyword, bool important, String reason, List<String> aliases
});




}
/// @nodoc
class __$ResumeKeywordCopyWithImpl<$Res>
    implements _$ResumeKeywordCopyWith<$Res> {
  __$ResumeKeywordCopyWithImpl(this._self, this._then);

  final _ResumeKeyword _self;
  final $Res Function(_ResumeKeyword) _then;

/// Create a copy of ResumeKeyword
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? keyword = null,Object? important = null,Object? reason = null,Object? aliases = null,}) {
  return _then(_ResumeKeyword(
keyword: null == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String,important: null == important ? _self.important : important // ignore: cast_nullable_to_non_nullable
as bool,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,aliases: null == aliases ? _self._aliases : aliases // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc
mixin _$KeywordsResult implements DiagnosticableTreeMixin {

 List<ResumeKeyword> get keywords; DateTime? get updatedAt;
/// Create a copy of KeywordsResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KeywordsResultCopyWith<KeywordsResult> get copyWith => _$KeywordsResultCopyWithImpl<KeywordsResult>(this as KeywordsResult, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  final _this = this as KeywordsResult;
  properties
    ..add(DiagnosticsProperty('type', 'KeywordsResult'))
    ..add(DiagnosticsProperty('keywords', _this.keywords))..add(DiagnosticsProperty('updatedAt', _this.updatedAt));
}

@override
bool operator ==(Object other) {
  final _this = this as KeywordsResult;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KeywordsResult&&const DeepCollectionEquality().equals(other.keywords, _this.keywords)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}


@override
int get hashCode {
  final _this = this as KeywordsResult;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.keywords),_this.updatedAt);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  final _this = this as KeywordsResult;
  return 'KeywordsResult(keywords: ${_this.keywords}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $KeywordsResultCopyWith<$Res>  {
  factory $KeywordsResultCopyWith(KeywordsResult value, $Res Function(KeywordsResult) _then) = _$KeywordsResultCopyWithImpl;
@useResult
$Res call({
 List<ResumeKeyword> keywords, DateTime? updatedAt
});




}
/// @nodoc
class _$KeywordsResultCopyWithImpl<$Res>
    implements $KeywordsResultCopyWith<$Res> {
  _$KeywordsResultCopyWithImpl(this._self, this._then);

  final KeywordsResult _self;
  final $Res Function(KeywordsResult) _then;

/// Create a copy of KeywordsResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? keywords = null,Object? updatedAt = freezed,}) {
  return _then(KeywordsResult(
keywords: null == keywords ? _self.keywords : keywords // ignore: cast_nullable_to_non_nullable
as List<ResumeKeyword>,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [KeywordsResult].
extension KeywordsResultPatterns on KeywordsResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KeywordsResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KeywordsResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KeywordsResult value)  $default,){
final _that = this;
switch (_that) {
case _KeywordsResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KeywordsResult value)?  $default,){
final _that = this;
switch (_that) {
case _KeywordsResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ResumeKeyword> keywords,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KeywordsResult() when $default != null:
return $default(_that.keywords,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ResumeKeyword> keywords,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _KeywordsResult():
return $default(_that.keywords,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ResumeKeyword> keywords,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _KeywordsResult() when $default != null:
return $default(_that.keywords,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _KeywordsResult with DiagnosticableTreeMixin implements KeywordsResult {
  const _KeywordsResult({required  List<ResumeKeyword> keywords, this.updatedAt}): _keywords = keywords;
  

 final  List<ResumeKeyword> _keywords;
@override List<ResumeKeyword> get keywords {
  if (_keywords is EqualUnmodifiableListView) return _keywords;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_keywords);
}

@override final  DateTime? updatedAt;

/// Create a copy of KeywordsResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KeywordsResultCopyWith<_KeywordsResult> get copyWith => __$KeywordsResultCopyWithImpl<_KeywordsResult>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
    ..add(DiagnosticsProperty('type', 'KeywordsResult'))
    ..add(DiagnosticsProperty('keywords', keywords))..add(DiagnosticsProperty('updatedAt', updatedAt));
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _KeywordsResult&&const DeepCollectionEquality().equals(other.keywords, _keywords)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_keywords),updatedAt);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
    return 'KeywordsResult(keywords: $keywords, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$KeywordsResultCopyWith<$Res> implements $KeywordsResultCopyWith<$Res> {
  factory _$KeywordsResultCopyWith(_KeywordsResult value, $Res Function(_KeywordsResult) _then) = __$KeywordsResultCopyWithImpl;
@override @useResult
$Res call({
 List<ResumeKeyword> keywords, DateTime? updatedAt
});




}
/// @nodoc
class __$KeywordsResultCopyWithImpl<$Res>
    implements _$KeywordsResultCopyWith<$Res> {
  __$KeywordsResultCopyWithImpl(this._self, this._then);

  final _KeywordsResult _self;
  final $Res Function(_KeywordsResult) _then;

/// Create a copy of KeywordsResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? keywords = null,Object? updatedAt = freezed,}) {
  return _then(_KeywordsResult(
keywords: null == keywords ? _self._keywords : keywords // ignore: cast_nullable_to_non_nullable
as List<ResumeKeyword>,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
