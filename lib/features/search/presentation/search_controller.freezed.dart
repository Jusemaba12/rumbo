// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SearchState {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SearchState()';
}


}

/// @nodoc
class $SearchStateCopyWith<$Res>  {
$SearchStateCopyWith(SearchState _, $Res Function(SearchState) __);
}


/// Adds pattern-matching-related methods to [SearchState].
extension SearchStatePatterns on SearchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SearchIdle value)?  idle,TResult Function( SearchRunning value)?  running,TResult Function( SearchDone value)?  done,TResult Function( SearchFailed value)?  failed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SearchIdle() when idle != null:
return idle(_that);case SearchRunning() when running != null:
return running(_that);case SearchDone() when done != null:
return done(_that);case SearchFailed() when failed != null:
return failed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SearchIdle value)  idle,required TResult Function( SearchRunning value)  running,required TResult Function( SearchDone value)  done,required TResult Function( SearchFailed value)  failed,}){
final _that = this;
switch (_that) {
case SearchIdle():
return idle(_that);case SearchRunning():
return running(_that);case SearchDone():
return done(_that);case SearchFailed():
return failed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SearchIdle value)?  idle,TResult? Function( SearchRunning value)?  running,TResult? Function( SearchDone value)?  done,TResult? Function( SearchFailed value)?  failed,}){
final _that = this;
switch (_that) {
case SearchIdle() when idle != null:
return idle(_that);case SearchRunning() when running != null:
return running(_that);case SearchDone() when done != null:
return done(_that);case SearchFailed() when failed != null:
return failed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function()?  running,TResult Function( SearchSummary summary)?  done,TResult Function( SearchFailure reason)?  failed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SearchIdle() when idle != null:
return idle();case SearchRunning() when running != null:
return running();case SearchDone() when done != null:
return done(_that.summary);case SearchFailed() when failed != null:
return failed(_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function()  running,required TResult Function( SearchSummary summary)  done,required TResult Function( SearchFailure reason)  failed,}) {final _that = this;
switch (_that) {
case SearchIdle():
return idle();case SearchRunning():
return running();case SearchDone():
return done(_that.summary);case SearchFailed():
return failed(_that.reason);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function()?  running,TResult? Function( SearchSummary summary)?  done,TResult? Function( SearchFailure reason)?  failed,}) {final _that = this;
switch (_that) {
case SearchIdle() when idle != null:
return idle();case SearchRunning() when running != null:
return running();case SearchDone() when done != null:
return done(_that.summary);case SearchFailed() when failed != null:
return failed(_that.reason);case _:
  return null;

}
}

}

/// @nodoc


class SearchIdle implements SearchState {
  const SearchIdle();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchIdle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SearchState.idle()';
}


}




/// @nodoc


class SearchRunning implements SearchState {
  const SearchRunning();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchRunning);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SearchState.running()';
}


}




/// @nodoc


class SearchDone implements SearchState {
  const SearchDone(this.summary);
  

 final  SearchSummary summary;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchDoneCopyWith<SearchDone> get copyWith => _$SearchDoneCopyWithImpl<SearchDone>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchDone&&(identical(other.summary, summary) || other.summary == summary));
}


@override
int get hashCode {
    return Object.hash(runtimeType,summary);
}

@override
String toString() {
    return 'SearchState.done(summary: $summary)';
}


}

/// @nodoc
abstract mixin class $SearchDoneCopyWith<$Res> implements $SearchStateCopyWith<$Res> {
  factory $SearchDoneCopyWith(SearchDone value, $Res Function(SearchDone) _then) = _$SearchDoneCopyWithImpl;
@useResult
$Res call({
 SearchSummary summary
});


$SearchSummaryCopyWith<$Res> get summary;

}
/// @nodoc
class _$SearchDoneCopyWithImpl<$Res>
    implements $SearchDoneCopyWith<$Res> {
  _$SearchDoneCopyWithImpl(this._self, this._then);

  final SearchDone _self;
  final $Res Function(SearchDone) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? summary = null,}) {
  return _then(SearchDone(
null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as SearchSummary,
  ));
}

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SearchSummaryCopyWith<$Res> get summary {
  
  return $SearchSummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}

/// @nodoc


class SearchFailed implements SearchState {
  const SearchFailed(this.reason);
  

 final  SearchFailure reason;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchFailedCopyWith<SearchFailed> get copyWith => _$SearchFailedCopyWithImpl<SearchFailed>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchFailed&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode {
    return Object.hash(runtimeType,reason);
}

@override
String toString() {
    return 'SearchState.failed(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $SearchFailedCopyWith<$Res> implements $SearchStateCopyWith<$Res> {
  factory $SearchFailedCopyWith(SearchFailed value, $Res Function(SearchFailed) _then) = _$SearchFailedCopyWithImpl;
@useResult
$Res call({
 SearchFailure reason
});




}
/// @nodoc
class _$SearchFailedCopyWithImpl<$Res>
    implements $SearchFailedCopyWith<$Res> {
  _$SearchFailedCopyWithImpl(this._self, this._then);

  final SearchFailed _self;
  final $Res Function(SearchFailed) _then;

/// Create a copy of SearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = null,}) {
  return _then(SearchFailed(
null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as SearchFailure,
  ));
}


}

// dart format on
