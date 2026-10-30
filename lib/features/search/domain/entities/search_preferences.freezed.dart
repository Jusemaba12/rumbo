// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_preferences.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WatchedBoard {

 BoardProvider get provider; String get token;
/// Create a copy of WatchedBoard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WatchedBoardCopyWith<WatchedBoard> get copyWith => _$WatchedBoardCopyWithImpl<WatchedBoard>(this as WatchedBoard, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as WatchedBoard;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WatchedBoard&&(identical(other.provider, _this.provider) || other.provider == _this.provider)&&(identical(other.token, _this.token) || other.token == _this.token));
}


@override
int get hashCode {
  final _this = this as WatchedBoard;
  return Object.hash(runtimeType,_this.provider,_this.token);
}

@override
String toString() {
  final _this = this as WatchedBoard;
  return 'WatchedBoard(provider: ${_this.provider}, token: ${_this.token})';
}


}

/// @nodoc
abstract mixin class $WatchedBoardCopyWith<$Res>  {
  factory $WatchedBoardCopyWith(WatchedBoard value, $Res Function(WatchedBoard) _then) = _$WatchedBoardCopyWithImpl;
@useResult
$Res call({
 BoardProvider provider, String token
});




}
/// @nodoc
class _$WatchedBoardCopyWithImpl<$Res>
    implements $WatchedBoardCopyWith<$Res> {
  _$WatchedBoardCopyWithImpl(this._self, this._then);

  final WatchedBoard _self;
  final $Res Function(WatchedBoard) _then;

/// Create a copy of WatchedBoard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? provider = null,Object? token = null,}) {
  return _then(WatchedBoard(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as BoardProvider,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WatchedBoard].
extension WatchedBoardPatterns on WatchedBoard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WatchedBoard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WatchedBoard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WatchedBoard value)  $default,){
final _that = this;
switch (_that) {
case _WatchedBoard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WatchedBoard value)?  $default,){
final _that = this;
switch (_that) {
case _WatchedBoard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BoardProvider provider,  String token)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WatchedBoard() when $default != null:
return $default(_that.provider,_that.token);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BoardProvider provider,  String token)  $default,) {final _that = this;
switch (_that) {
case _WatchedBoard():
return $default(_that.provider,_that.token);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BoardProvider provider,  String token)?  $default,) {final _that = this;
switch (_that) {
case _WatchedBoard() when $default != null:
return $default(_that.provider,_that.token);case _:
  return null;

}
}

}

/// @nodoc


class _WatchedBoard implements WatchedBoard {
  const _WatchedBoard({required this.provider, required this.token});
  

@override final  BoardProvider provider;
@override final  String token;

/// Create a copy of WatchedBoard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WatchedBoardCopyWith<_WatchedBoard> get copyWith => __$WatchedBoardCopyWithImpl<_WatchedBoard>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WatchedBoard&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.token, token) || other.token == token));
}


@override
int get hashCode {
    return Object.hash(runtimeType,provider,token);
}

@override
String toString() {
    return 'WatchedBoard(provider: $provider, token: $token)';
}


}

/// @nodoc
abstract mixin class _$WatchedBoardCopyWith<$Res> implements $WatchedBoardCopyWith<$Res> {
  factory _$WatchedBoardCopyWith(_WatchedBoard value, $Res Function(_WatchedBoard) _then) = __$WatchedBoardCopyWithImpl;
@override @useResult
$Res call({
 BoardProvider provider, String token
});




}
/// @nodoc
class __$WatchedBoardCopyWithImpl<$Res>
    implements _$WatchedBoardCopyWith<$Res> {
  __$WatchedBoardCopyWithImpl(this._self, this._then);

  final _WatchedBoard _self;
  final $Res Function(_WatchedBoard) _then;

/// Create a copy of WatchedBoard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? provider = null,Object? token = null,}) {
  return _then(_WatchedBoard(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as BoardProvider,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$SearchPreferences {

 List<String> get roles; List<String> get technologies; List<WorkMode> get workModes; List<String> get countries; List<String> get sources; int get minScore; List<WatchedBoard> get watchedBoards; DateTime? get lastRunAt;
/// Create a copy of SearchPreferences
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchPreferencesCopyWith<SearchPreferences> get copyWith => _$SearchPreferencesCopyWithImpl<SearchPreferences>(this as SearchPreferences, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SearchPreferences;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchPreferences&&const DeepCollectionEquality().equals(other.roles, _this.roles)&&const DeepCollectionEquality().equals(other.technologies, _this.technologies)&&const DeepCollectionEquality().equals(other.workModes, _this.workModes)&&const DeepCollectionEquality().equals(other.countries, _this.countries)&&const DeepCollectionEquality().equals(other.sources, _this.sources)&&(identical(other.minScore, _this.minScore) || other.minScore == _this.minScore)&&const DeepCollectionEquality().equals(other.watchedBoards, _this.watchedBoards)&&(identical(other.lastRunAt, _this.lastRunAt) || other.lastRunAt == _this.lastRunAt));
}


@override
int get hashCode {
  final _this = this as SearchPreferences;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.roles),const DeepCollectionEquality().hash(_this.technologies),const DeepCollectionEquality().hash(_this.workModes),const DeepCollectionEquality().hash(_this.countries),const DeepCollectionEquality().hash(_this.sources),_this.minScore,const DeepCollectionEquality().hash(_this.watchedBoards),_this.lastRunAt);
}

@override
String toString() {
  final _this = this as SearchPreferences;
  return 'SearchPreferences(roles: ${_this.roles}, technologies: ${_this.technologies}, workModes: ${_this.workModes}, countries: ${_this.countries}, sources: ${_this.sources}, minScore: ${_this.minScore}, watchedBoards: ${_this.watchedBoards}, lastRunAt: ${_this.lastRunAt})';
}


}

/// @nodoc
abstract mixin class $SearchPreferencesCopyWith<$Res>  {
  factory $SearchPreferencesCopyWith(SearchPreferences value, $Res Function(SearchPreferences) _then) = _$SearchPreferencesCopyWithImpl;
@useResult
$Res call({
 List<String> roles, List<String> technologies, List<WorkMode> workModes, List<String> countries, List<String> sources, int minScore, List<WatchedBoard> watchedBoards, DateTime? lastRunAt
});




}
/// @nodoc
class _$SearchPreferencesCopyWithImpl<$Res>
    implements $SearchPreferencesCopyWith<$Res> {
  _$SearchPreferencesCopyWithImpl(this._self, this._then);

  final SearchPreferences _self;
  final $Res Function(SearchPreferences) _then;

/// Create a copy of SearchPreferences
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? roles = null,Object? technologies = null,Object? workModes = null,Object? countries = null,Object? sources = null,Object? minScore = null,Object? watchedBoards = null,Object? lastRunAt = freezed,}) {
  return _then(SearchPreferences(
roles: null == roles ? _self.roles : roles // ignore: cast_nullable_to_non_nullable
as List<String>,technologies: null == technologies ? _self.technologies : technologies // ignore: cast_nullable_to_non_nullable
as List<String>,workModes: null == workModes ? _self.workModes : workModes // ignore: cast_nullable_to_non_nullable
as List<WorkMode>,countries: null == countries ? _self.countries : countries // ignore: cast_nullable_to_non_nullable
as List<String>,sources: null == sources ? _self.sources : sources // ignore: cast_nullable_to_non_nullable
as List<String>,minScore: null == minScore ? _self.minScore : minScore // ignore: cast_nullable_to_non_nullable
as int,watchedBoards: null == watchedBoards ? _self.watchedBoards : watchedBoards // ignore: cast_nullable_to_non_nullable
as List<WatchedBoard>,lastRunAt: freezed == lastRunAt ? _self.lastRunAt : lastRunAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchPreferences].
extension SearchPreferencesPatterns on SearchPreferences {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchPreferences value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchPreferences() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchPreferences value)  $default,){
final _that = this;
switch (_that) {
case _SearchPreferences():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchPreferences value)?  $default,){
final _that = this;
switch (_that) {
case _SearchPreferences() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> roles,  List<String> technologies,  List<WorkMode> workModes,  List<String> countries,  List<String> sources,  int minScore,  List<WatchedBoard> watchedBoards,  DateTime? lastRunAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchPreferences() when $default != null:
return $default(_that.roles,_that.technologies,_that.workModes,_that.countries,_that.sources,_that.minScore,_that.watchedBoards,_that.lastRunAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> roles,  List<String> technologies,  List<WorkMode> workModes,  List<String> countries,  List<String> sources,  int minScore,  List<WatchedBoard> watchedBoards,  DateTime? lastRunAt)  $default,) {final _that = this;
switch (_that) {
case _SearchPreferences():
return $default(_that.roles,_that.technologies,_that.workModes,_that.countries,_that.sources,_that.minScore,_that.watchedBoards,_that.lastRunAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> roles,  List<String> technologies,  List<WorkMode> workModes,  List<String> countries,  List<String> sources,  int minScore,  List<WatchedBoard> watchedBoards,  DateTime? lastRunAt)?  $default,) {final _that = this;
switch (_that) {
case _SearchPreferences() when $default != null:
return $default(_that.roles,_that.technologies,_that.workModes,_that.countries,_that.sources,_that.minScore,_that.watchedBoards,_that.lastRunAt);case _:
  return null;

}
}

}

/// @nodoc


class _SearchPreferences extends SearchPreferences {
  const _SearchPreferences({ List<String> roles = const <String>[],  List<String> technologies = const <String>[],  List<WorkMode> workModes = const <WorkMode>[WorkMode.remote],  List<String> countries = const <String>[],  List<String> sources = searchSources, this.minScore = 60,  List<WatchedBoard> watchedBoards = const <WatchedBoard>[], this.lastRunAt}): _roles = roles,_technologies = technologies,_workModes = workModes,_countries = countries,_sources = sources,_watchedBoards = watchedBoards,super._();
  

 final  List<String> _roles;
@override@JsonKey() List<String> get roles {
  if (_roles is EqualUnmodifiableListView) return _roles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_roles);
}

 final  List<String> _technologies;
@override@JsonKey() List<String> get technologies {
  if (_technologies is EqualUnmodifiableListView) return _technologies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_technologies);
}

 final  List<WorkMode> _workModes;
@override@JsonKey() List<WorkMode> get workModes {
  if (_workModes is EqualUnmodifiableListView) return _workModes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_workModes);
}

 final  List<String> _countries;
@override@JsonKey() List<String> get countries {
  if (_countries is EqualUnmodifiableListView) return _countries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_countries);
}

 final  List<String> _sources;
@override@JsonKey() List<String> get sources {
  if (_sources is EqualUnmodifiableListView) return _sources;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sources);
}

@override@JsonKey() final  int minScore;
 final  List<WatchedBoard> _watchedBoards;
@override@JsonKey() List<WatchedBoard> get watchedBoards {
  if (_watchedBoards is EqualUnmodifiableListView) return _watchedBoards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_watchedBoards);
}

@override final  DateTime? lastRunAt;

/// Create a copy of SearchPreferences
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchPreferencesCopyWith<_SearchPreferences> get copyWith => __$SearchPreferencesCopyWithImpl<_SearchPreferences>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchPreferences&&const DeepCollectionEquality().equals(other.roles, _roles)&&const DeepCollectionEquality().equals(other.technologies, _technologies)&&const DeepCollectionEquality().equals(other.workModes, _workModes)&&const DeepCollectionEquality().equals(other.countries, _countries)&&const DeepCollectionEquality().equals(other.sources, _sources)&&(identical(other.minScore, minScore) || other.minScore == minScore)&&const DeepCollectionEquality().equals(other.watchedBoards, _watchedBoards)&&(identical(other.lastRunAt, lastRunAt) || other.lastRunAt == lastRunAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_roles),const DeepCollectionEquality().hash(_technologies),const DeepCollectionEquality().hash(_workModes),const DeepCollectionEquality().hash(_countries),const DeepCollectionEquality().hash(_sources),minScore,const DeepCollectionEquality().hash(_watchedBoards),lastRunAt);
}

@override
String toString() {
    return 'SearchPreferences(roles: $roles, technologies: $technologies, workModes: $workModes, countries: $countries, sources: $sources, minScore: $minScore, watchedBoards: $watchedBoards, lastRunAt: $lastRunAt)';
}


}

/// @nodoc
abstract mixin class _$SearchPreferencesCopyWith<$Res> implements $SearchPreferencesCopyWith<$Res> {
  factory _$SearchPreferencesCopyWith(_SearchPreferences value, $Res Function(_SearchPreferences) _then) = __$SearchPreferencesCopyWithImpl;
@override @useResult
$Res call({
 List<String> roles, List<String> technologies, List<WorkMode> workModes, List<String> countries, List<String> sources, int minScore, List<WatchedBoard> watchedBoards, DateTime? lastRunAt
});




}
/// @nodoc
class __$SearchPreferencesCopyWithImpl<$Res>
    implements _$SearchPreferencesCopyWith<$Res> {
  __$SearchPreferencesCopyWithImpl(this._self, this._then);

  final _SearchPreferences _self;
  final $Res Function(_SearchPreferences) _then;

/// Create a copy of SearchPreferences
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? roles = null,Object? technologies = null,Object? workModes = null,Object? countries = null,Object? sources = null,Object? minScore = null,Object? watchedBoards = null,Object? lastRunAt = freezed,}) {
  return _then(_SearchPreferences(
roles: null == roles ? _self._roles : roles // ignore: cast_nullable_to_non_nullable
as List<String>,technologies: null == technologies ? _self._technologies : technologies // ignore: cast_nullable_to_non_nullable
as List<String>,workModes: null == workModes ? _self._workModes : workModes // ignore: cast_nullable_to_non_nullable
as List<WorkMode>,countries: null == countries ? _self._countries : countries // ignore: cast_nullable_to_non_nullable
as List<String>,sources: null == sources ? _self._sources : sources // ignore: cast_nullable_to_non_nullable
as List<String>,minScore: null == minScore ? _self.minScore : minScore // ignore: cast_nullable_to_non_nullable
as int,watchedBoards: null == watchedBoards ? _self._watchedBoards : watchedBoards // ignore: cast_nullable_to_non_nullable
as List<WatchedBoard>,lastRunAt: freezed == lastRunAt ? _self.lastRunAt : lastRunAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
