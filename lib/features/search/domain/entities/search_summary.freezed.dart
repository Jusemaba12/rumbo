// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SearchSummary {

 int get found; int get scored; int get suggested; List<String> get failedSources;
/// Create a copy of SearchSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchSummaryCopyWith<SearchSummary> get copyWith => _$SearchSummaryCopyWithImpl<SearchSummary>(this as SearchSummary, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SearchSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchSummary&&(identical(other.found, _this.found) || other.found == _this.found)&&(identical(other.scored, _this.scored) || other.scored == _this.scored)&&(identical(other.suggested, _this.suggested) || other.suggested == _this.suggested)&&const DeepCollectionEquality().equals(other.failedSources, _this.failedSources));
}


@override
int get hashCode {
  final _this = this as SearchSummary;
  return Object.hash(runtimeType,_this.found,_this.scored,_this.suggested,const DeepCollectionEquality().hash(_this.failedSources));
}

@override
String toString() {
  final _this = this as SearchSummary;
  return 'SearchSummary(found: ${_this.found}, scored: ${_this.scored}, suggested: ${_this.suggested}, failedSources: ${_this.failedSources})';
}


}

/// @nodoc
abstract mixin class $SearchSummaryCopyWith<$Res>  {
  factory $SearchSummaryCopyWith(SearchSummary value, $Res Function(SearchSummary) _then) = _$SearchSummaryCopyWithImpl;
@useResult
$Res call({
 int found, int scored, int suggested, List<String> failedSources
});




}
/// @nodoc
class _$SearchSummaryCopyWithImpl<$Res>
    implements $SearchSummaryCopyWith<$Res> {
  _$SearchSummaryCopyWithImpl(this._self, this._then);

  final SearchSummary _self;
  final $Res Function(SearchSummary) _then;

/// Create a copy of SearchSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? found = null,Object? scored = null,Object? suggested = null,Object? failedSources = null,}) {
  return _then(SearchSummary(
found: null == found ? _self.found : found // ignore: cast_nullable_to_non_nullable
as int,scored: null == scored ? _self.scored : scored // ignore: cast_nullable_to_non_nullable
as int,suggested: null == suggested ? _self.suggested : suggested // ignore: cast_nullable_to_non_nullable
as int,failedSources: null == failedSources ? _self.failedSources : failedSources // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchSummary].
extension SearchSummaryPatterns on SearchSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchSummary value)  $default,){
final _that = this;
switch (_that) {
case _SearchSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchSummary value)?  $default,){
final _that = this;
switch (_that) {
case _SearchSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int found,  int scored,  int suggested,  List<String> failedSources)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchSummary() when $default != null:
return $default(_that.found,_that.scored,_that.suggested,_that.failedSources);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int found,  int scored,  int suggested,  List<String> failedSources)  $default,) {final _that = this;
switch (_that) {
case _SearchSummary():
return $default(_that.found,_that.scored,_that.suggested,_that.failedSources);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int found,  int scored,  int suggested,  List<String> failedSources)?  $default,) {final _that = this;
switch (_that) {
case _SearchSummary() when $default != null:
return $default(_that.found,_that.scored,_that.suggested,_that.failedSources);case _:
  return null;

}
}

}

/// @nodoc


class _SearchSummary implements SearchSummary {
  const _SearchSummary({required this.found, required this.scored, required this.suggested,  List<String> failedSources = const <String>[]}): _failedSources = failedSources;
  

@override final  int found;
@override final  int scored;
@override final  int suggested;
 final  List<String> _failedSources;
@override@JsonKey() List<String> get failedSources {
  if (_failedSources is EqualUnmodifiableListView) return _failedSources;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_failedSources);
}


/// Create a copy of SearchSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchSummaryCopyWith<_SearchSummary> get copyWith => __$SearchSummaryCopyWithImpl<_SearchSummary>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchSummary&&(identical(other.found, found) || other.found == found)&&(identical(other.scored, scored) || other.scored == scored)&&(identical(other.suggested, suggested) || other.suggested == suggested)&&const DeepCollectionEquality().equals(other.failedSources, _failedSources));
}


@override
int get hashCode {
    return Object.hash(runtimeType,found,scored,suggested,const DeepCollectionEquality().hash(_failedSources));
}

@override
String toString() {
    return 'SearchSummary(found: $found, scored: $scored, suggested: $suggested, failedSources: $failedSources)';
}


}

/// @nodoc
abstract mixin class _$SearchSummaryCopyWith<$Res> implements $SearchSummaryCopyWith<$Res> {
  factory _$SearchSummaryCopyWith(_SearchSummary value, $Res Function(_SearchSummary) _then) = __$SearchSummaryCopyWithImpl;
@override @useResult
$Res call({
 int found, int scored, int suggested, List<String> failedSources
});




}
/// @nodoc
class __$SearchSummaryCopyWithImpl<$Res>
    implements _$SearchSummaryCopyWith<$Res> {
  __$SearchSummaryCopyWithImpl(this._self, this._then);

  final _SearchSummary _self;
  final $Res Function(_SearchSummary) _then;

/// Create a copy of SearchSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? found = null,Object? scored = null,Object? suggested = null,Object? failedSources = null,}) {
  return _then(_SearchSummary(
found: null == found ? _self.found : found // ignore: cast_nullable_to_non_nullable
as int,scored: null == scored ? _self.scored : scored // ignore: cast_nullable_to_non_nullable
as int,suggested: null == suggested ? _self.suggested : suggested // ignore: cast_nullable_to_non_nullable
as int,failedSources: null == failedSources ? _self._failedSources : failedSources // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
