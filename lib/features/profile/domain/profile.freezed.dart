// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SpokenLanguage {

 String get language;@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) LanguageLevel? get level;
/// Create a copy of SpokenLanguage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpokenLanguageCopyWith<SpokenLanguage> get copyWith => _$SpokenLanguageCopyWithImpl<SpokenLanguage>(this as SpokenLanguage, _$identity);

  /// Serializes this SpokenLanguage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SpokenLanguage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpokenLanguage&&(identical(other.language, _this.language) || other.language == _this.language)&&(identical(other.level, _this.level) || other.level == _this.level));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SpokenLanguage;
  return Object.hash(runtimeType,_this.language,_this.level);
}

@override
String toString() {
  final _this = this as SpokenLanguage;
  return 'SpokenLanguage(language: ${_this.language}, level: ${_this.level})';
}


}

/// @nodoc
abstract mixin class $SpokenLanguageCopyWith<$Res>  {
  factory $SpokenLanguageCopyWith(SpokenLanguage value, $Res Function(SpokenLanguage) _then) = _$SpokenLanguageCopyWithImpl;
@useResult
$Res call({
 String language,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) LanguageLevel? level
});




}
/// @nodoc
class _$SpokenLanguageCopyWithImpl<$Res>
    implements $SpokenLanguageCopyWith<$Res> {
  _$SpokenLanguageCopyWithImpl(this._self, this._then);

  final SpokenLanguage _self;
  final $Res Function(SpokenLanguage) _then;

/// Create a copy of SpokenLanguage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? language = null,Object? level = freezed,}) {
  return _then(SpokenLanguage(
language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,level: freezed == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as LanguageLevel?,
  ));
}

}


/// Adds pattern-matching-related methods to [SpokenLanguage].
extension SpokenLanguagePatterns on SpokenLanguage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpokenLanguage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpokenLanguage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpokenLanguage value)  $default,){
final _that = this;
switch (_that) {
case _SpokenLanguage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpokenLanguage value)?  $default,){
final _that = this;
switch (_that) {
case _SpokenLanguage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String language, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  LanguageLevel? level)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpokenLanguage() when $default != null:
return $default(_that.language,_that.level);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String language, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  LanguageLevel? level)  $default,) {final _that = this;
switch (_that) {
case _SpokenLanguage():
return $default(_that.language,_that.level);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String language, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  LanguageLevel? level)?  $default,) {final _that = this;
switch (_that) {
case _SpokenLanguage() when $default != null:
return $default(_that.language,_that.level);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SpokenLanguage implements SpokenLanguage {
  const _SpokenLanguage({required this.language, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) this.level});
  factory _SpokenLanguage.fromJson(Map<String, dynamic> json) => _$SpokenLanguageFromJson(json);

@override final  String language;
@override@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) final  LanguageLevel? level;

/// Create a copy of SpokenLanguage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpokenLanguageCopyWith<_SpokenLanguage> get copyWith => __$SpokenLanguageCopyWithImpl<_SpokenLanguage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SpokenLanguageToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpokenLanguage&&(identical(other.language, language) || other.language == language)&&(identical(other.level, level) || other.level == level));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,language,level);
}

@override
String toString() {
    return 'SpokenLanguage(language: $language, level: $level)';
}


}

/// @nodoc
abstract mixin class _$SpokenLanguageCopyWith<$Res> implements $SpokenLanguageCopyWith<$Res> {
  factory _$SpokenLanguageCopyWith(_SpokenLanguage value, $Res Function(_SpokenLanguage) _then) = __$SpokenLanguageCopyWithImpl;
@override @useResult
$Res call({
 String language,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) LanguageLevel? level
});




}
/// @nodoc
class __$SpokenLanguageCopyWithImpl<$Res>
    implements _$SpokenLanguageCopyWith<$Res> {
  __$SpokenLanguageCopyWithImpl(this._self, this._then);

  final _SpokenLanguage _self;
  final $Res Function(_SpokenLanguage) _then;

/// Create a copy of SpokenLanguage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? language = null,Object? level = freezed,}) {
  return _then(_SpokenLanguage(
language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,level: freezed == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as LanguageLevel?,
  ));
}


}


/// @nodoc
mixin _$Profile {

 String get fullName; String get headline; String get summary; String get location; String get email; String get phone; Map<String, String> get links; List<SpokenLanguage> get languages;/// Expectativa salarial bruta mensual.
 int? get salaryCopMin; int? get salaryCopMax; int? get salaryUsdMin; int? get salaryUsdMax;
/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileCopyWith<Profile> get copyWith => _$ProfileCopyWithImpl<Profile>(this as Profile, _$identity);

  /// Serializes this Profile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Profile;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Profile&&(identical(other.fullName, _this.fullName) || other.fullName == _this.fullName)&&(identical(other.headline, _this.headline) || other.headline == _this.headline)&&(identical(other.summary, _this.summary) || other.summary == _this.summary)&&(identical(other.location, _this.location) || other.location == _this.location)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&const DeepCollectionEquality().equals(other.links, _this.links)&&const DeepCollectionEquality().equals(other.languages, _this.languages)&&(identical(other.salaryCopMin, _this.salaryCopMin) || other.salaryCopMin == _this.salaryCopMin)&&(identical(other.salaryCopMax, _this.salaryCopMax) || other.salaryCopMax == _this.salaryCopMax)&&(identical(other.salaryUsdMin, _this.salaryUsdMin) || other.salaryUsdMin == _this.salaryUsdMin)&&(identical(other.salaryUsdMax, _this.salaryUsdMax) || other.salaryUsdMax == _this.salaryUsdMax));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Profile;
  return Object.hash(runtimeType,_this.fullName,_this.headline,_this.summary,_this.location,_this.email,_this.phone,const DeepCollectionEquality().hash(_this.links),const DeepCollectionEquality().hash(_this.languages),_this.salaryCopMin,_this.salaryCopMax,_this.salaryUsdMin,_this.salaryUsdMax);
}

@override
String toString() {
  final _this = this as Profile;
  return 'Profile(fullName: ${_this.fullName}, headline: ${_this.headline}, summary: ${_this.summary}, location: ${_this.location}, email: ${_this.email}, phone: ${_this.phone}, links: ${_this.links}, languages: ${_this.languages}, salaryCopMin: ${_this.salaryCopMin}, salaryCopMax: ${_this.salaryCopMax}, salaryUsdMin: ${_this.salaryUsdMin}, salaryUsdMax: ${_this.salaryUsdMax})';
}


}

/// @nodoc
abstract mixin class $ProfileCopyWith<$Res>  {
  factory $ProfileCopyWith(Profile value, $Res Function(Profile) _then) = _$ProfileCopyWithImpl;
@useResult
$Res call({
 String fullName, String headline, String summary, String location, String email, String phone, Map<String, String> links, List<SpokenLanguage> languages, int? salaryCopMin, int? salaryCopMax, int? salaryUsdMin, int? salaryUsdMax
});




}
/// @nodoc
class _$ProfileCopyWithImpl<$Res>
    implements $ProfileCopyWith<$Res> {
  _$ProfileCopyWithImpl(this._self, this._then);

  final Profile _self;
  final $Res Function(Profile) _then;

/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullName = null,Object? headline = null,Object? summary = null,Object? location = null,Object? email = null,Object? phone = null,Object? links = null,Object? languages = null,Object? salaryCopMin = freezed,Object? salaryCopMax = freezed,Object? salaryUsdMin = freezed,Object? salaryUsdMax = freezed,}) {
  return _then(Profile(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,headline: null == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,links: null == links ? _self.links : links // ignore: cast_nullable_to_non_nullable
as Map<String, String>,languages: null == languages ? _self.languages : languages // ignore: cast_nullable_to_non_nullable
as List<SpokenLanguage>,salaryCopMin: freezed == salaryCopMin ? _self.salaryCopMin : salaryCopMin // ignore: cast_nullable_to_non_nullable
as int?,salaryCopMax: freezed == salaryCopMax ? _self.salaryCopMax : salaryCopMax // ignore: cast_nullable_to_non_nullable
as int?,salaryUsdMin: freezed == salaryUsdMin ? _self.salaryUsdMin : salaryUsdMin // ignore: cast_nullable_to_non_nullable
as int?,salaryUsdMax: freezed == salaryUsdMax ? _self.salaryUsdMax : salaryUsdMax // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [Profile].
extension ProfilePatterns on Profile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Profile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Profile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Profile value)  $default,){
final _that = this;
switch (_that) {
case _Profile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Profile value)?  $default,){
final _that = this;
switch (_that) {
case _Profile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fullName,  String headline,  String summary,  String location,  String email,  String phone,  Map<String, String> links,  List<SpokenLanguage> languages,  int? salaryCopMin,  int? salaryCopMax,  int? salaryUsdMin,  int? salaryUsdMax)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Profile() when $default != null:
return $default(_that.fullName,_that.headline,_that.summary,_that.location,_that.email,_that.phone,_that.links,_that.languages,_that.salaryCopMin,_that.salaryCopMax,_that.salaryUsdMin,_that.salaryUsdMax);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fullName,  String headline,  String summary,  String location,  String email,  String phone,  Map<String, String> links,  List<SpokenLanguage> languages,  int? salaryCopMin,  int? salaryCopMax,  int? salaryUsdMin,  int? salaryUsdMax)  $default,) {final _that = this;
switch (_that) {
case _Profile():
return $default(_that.fullName,_that.headline,_that.summary,_that.location,_that.email,_that.phone,_that.links,_that.languages,_that.salaryCopMin,_that.salaryCopMax,_that.salaryUsdMin,_that.salaryUsdMax);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fullName,  String headline,  String summary,  String location,  String email,  String phone,  Map<String, String> links,  List<SpokenLanguage> languages,  int? salaryCopMin,  int? salaryCopMax,  int? salaryUsdMin,  int? salaryUsdMax)?  $default,) {final _that = this;
switch (_that) {
case _Profile() when $default != null:
return $default(_that.fullName,_that.headline,_that.summary,_that.location,_that.email,_that.phone,_that.links,_that.languages,_that.salaryCopMin,_that.salaryCopMax,_that.salaryUsdMin,_that.salaryUsdMax);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Profile extends Profile {
  const _Profile({this.fullName = '', this.headline = '', this.summary = '', this.location = '', this.email = '', this.phone = '',  Map<String, String> links = const {},  List<SpokenLanguage> languages = const [], this.salaryCopMin, this.salaryCopMax, this.salaryUsdMin, this.salaryUsdMax}): _links = links,_languages = languages,super._();
  factory _Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

@override@JsonKey() final  String fullName;
@override@JsonKey() final  String headline;
@override@JsonKey() final  String summary;
@override@JsonKey() final  String location;
@override@JsonKey() final  String email;
@override@JsonKey() final  String phone;
 final  Map<String, String> _links;
@override@JsonKey() Map<String, String> get links {
  if (_links is EqualUnmodifiableMapView) return _links;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_links);
}

 final  List<SpokenLanguage> _languages;
@override@JsonKey() List<SpokenLanguage> get languages {
  if (_languages is EqualUnmodifiableListView) return _languages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_languages);
}

/// Expectativa salarial bruta mensual.
@override final  int? salaryCopMin;
@override final  int? salaryCopMax;
@override final  int? salaryUsdMin;
@override final  int? salaryUsdMax;

/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileCopyWith<_Profile> get copyWith => __$ProfileCopyWithImpl<_Profile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Profile&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.headline, headline) || other.headline == headline)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.location, location) || other.location == location)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&const DeepCollectionEquality().equals(other.links, _links)&&const DeepCollectionEquality().equals(other.languages, _languages)&&(identical(other.salaryCopMin, salaryCopMin) || other.salaryCopMin == salaryCopMin)&&(identical(other.salaryCopMax, salaryCopMax) || other.salaryCopMax == salaryCopMax)&&(identical(other.salaryUsdMin, salaryUsdMin) || other.salaryUsdMin == salaryUsdMin)&&(identical(other.salaryUsdMax, salaryUsdMax) || other.salaryUsdMax == salaryUsdMax));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,fullName,headline,summary,location,email,phone,const DeepCollectionEquality().hash(_links),const DeepCollectionEquality().hash(_languages),salaryCopMin,salaryCopMax,salaryUsdMin,salaryUsdMax);
}

@override
String toString() {
    return 'Profile(fullName: $fullName, headline: $headline, summary: $summary, location: $location, email: $email, phone: $phone, links: $links, languages: $languages, salaryCopMin: $salaryCopMin, salaryCopMax: $salaryCopMax, salaryUsdMin: $salaryUsdMin, salaryUsdMax: $salaryUsdMax)';
}


}

/// @nodoc
abstract mixin class _$ProfileCopyWith<$Res> implements $ProfileCopyWith<$Res> {
  factory _$ProfileCopyWith(_Profile value, $Res Function(_Profile) _then) = __$ProfileCopyWithImpl;
@override @useResult
$Res call({
 String fullName, String headline, String summary, String location, String email, String phone, Map<String, String> links, List<SpokenLanguage> languages, int? salaryCopMin, int? salaryCopMax, int? salaryUsdMin, int? salaryUsdMax
});




}
/// @nodoc
class __$ProfileCopyWithImpl<$Res>
    implements _$ProfileCopyWith<$Res> {
  __$ProfileCopyWithImpl(this._self, this._then);

  final _Profile _self;
  final $Res Function(_Profile) _then;

/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = null,Object? headline = null,Object? summary = null,Object? location = null,Object? email = null,Object? phone = null,Object? links = null,Object? languages = null,Object? salaryCopMin = freezed,Object? salaryCopMax = freezed,Object? salaryUsdMin = freezed,Object? salaryUsdMax = freezed,}) {
  return _then(_Profile(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,headline: null == headline ? _self.headline : headline // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,links: null == links ? _self._links : links // ignore: cast_nullable_to_non_nullable
as Map<String, String>,languages: null == languages ? _self._languages : languages // ignore: cast_nullable_to_non_nullable
as List<SpokenLanguage>,salaryCopMin: freezed == salaryCopMin ? _self.salaryCopMin : salaryCopMin // ignore: cast_nullable_to_non_nullable
as int?,salaryCopMax: freezed == salaryCopMax ? _self.salaryCopMax : salaryCopMax // ignore: cast_nullable_to_non_nullable
as int?,salaryUsdMin: freezed == salaryUsdMin ? _self.salaryUsdMin : salaryUsdMin // ignore: cast_nullable_to_non_nullable
as int?,salaryUsdMax: freezed == salaryUsdMax ? _self.salaryUsdMax : salaryUsdMax // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$Experience {

 String get id; String get company; String get role; DateTime get startDate; DateTime? get endDate; List<String> get achievements; List<String> get technologies;
/// Create a copy of Experience
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExperienceCopyWith<Experience> get copyWith => _$ExperienceCopyWithImpl<Experience>(this as Experience, _$identity);

  /// Serializes this Experience to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Experience;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Experience&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.company, _this.company) || other.company == _this.company)&&(identical(other.role, _this.role) || other.role == _this.role)&&(identical(other.startDate, _this.startDate) || other.startDate == _this.startDate)&&(identical(other.endDate, _this.endDate) || other.endDate == _this.endDate)&&const DeepCollectionEquality().equals(other.achievements, _this.achievements)&&const DeepCollectionEquality().equals(other.technologies, _this.technologies));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Experience;
  return Object.hash(runtimeType,_this.id,_this.company,_this.role,_this.startDate,_this.endDate,const DeepCollectionEquality().hash(_this.achievements),const DeepCollectionEquality().hash(_this.technologies));
}

@override
String toString() {
  final _this = this as Experience;
  return 'Experience(id: ${_this.id}, company: ${_this.company}, role: ${_this.role}, startDate: ${_this.startDate}, endDate: ${_this.endDate}, achievements: ${_this.achievements}, technologies: ${_this.technologies})';
}


}

/// @nodoc
abstract mixin class $ExperienceCopyWith<$Res>  {
  factory $ExperienceCopyWith(Experience value, $Res Function(Experience) _then) = _$ExperienceCopyWithImpl;
@useResult
$Res call({
 String id, String company, String role, DateTime startDate, DateTime? endDate, List<String> achievements, List<String> technologies
});




}
/// @nodoc
class _$ExperienceCopyWithImpl<$Res>
    implements $ExperienceCopyWith<$Res> {
  _$ExperienceCopyWithImpl(this._self, this._then);

  final Experience _self;
  final $Res Function(Experience) _then;

/// Create a copy of Experience
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? company = null,Object? role = null,Object? startDate = null,Object? endDate = freezed,Object? achievements = null,Object? technologies = null,}) {
  return _then(Experience(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,achievements: null == achievements ? _self.achievements : achievements // ignore: cast_nullable_to_non_nullable
as List<String>,technologies: null == technologies ? _self.technologies : technologies // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [Experience].
extension ExperiencePatterns on Experience {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Experience value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Experience() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Experience value)  $default,){
final _that = this;
switch (_that) {
case _Experience():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Experience value)?  $default,){
final _that = this;
switch (_that) {
case _Experience() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String company,  String role,  DateTime startDate,  DateTime? endDate,  List<String> achievements,  List<String> technologies)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Experience() when $default != null:
return $default(_that.id,_that.company,_that.role,_that.startDate,_that.endDate,_that.achievements,_that.technologies);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String company,  String role,  DateTime startDate,  DateTime? endDate,  List<String> achievements,  List<String> technologies)  $default,) {final _that = this;
switch (_that) {
case _Experience():
return $default(_that.id,_that.company,_that.role,_that.startDate,_that.endDate,_that.achievements,_that.technologies);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String company,  String role,  DateTime startDate,  DateTime? endDate,  List<String> achievements,  List<String> technologies)?  $default,) {final _that = this;
switch (_that) {
case _Experience() when $default != null:
return $default(_that.id,_that.company,_that.role,_that.startDate,_that.endDate,_that.achievements,_that.technologies);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Experience extends Experience {
  const _Experience({this.id = '', required this.company, required this.role, required this.startDate, this.endDate,  List<String> achievements = const [],  List<String> technologies = const []}): _achievements = achievements,_technologies = technologies,super._();
  factory _Experience.fromJson(Map<String, dynamic> json) => _$ExperienceFromJson(json);

@override@JsonKey() final  String id;
@override final  String company;
@override final  String role;
@override final  DateTime startDate;
@override final  DateTime? endDate;
 final  List<String> _achievements;
@override@JsonKey() List<String> get achievements {
  if (_achievements is EqualUnmodifiableListView) return _achievements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_achievements);
}

 final  List<String> _technologies;
@override@JsonKey() List<String> get technologies {
  if (_technologies is EqualUnmodifiableListView) return _technologies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_technologies);
}


/// Create a copy of Experience
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExperienceCopyWith<_Experience> get copyWith => __$ExperienceCopyWithImpl<_Experience>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExperienceToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Experience&&(identical(other.id, id) || other.id == id)&&(identical(other.company, company) || other.company == company)&&(identical(other.role, role) || other.role == role)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&const DeepCollectionEquality().equals(other.achievements, _achievements)&&const DeepCollectionEquality().equals(other.technologies, _technologies));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,company,role,startDate,endDate,const DeepCollectionEquality().hash(_achievements),const DeepCollectionEquality().hash(_technologies));
}

@override
String toString() {
    return 'Experience(id: $id, company: $company, role: $role, startDate: $startDate, endDate: $endDate, achievements: $achievements, technologies: $technologies)';
}


}

/// @nodoc
abstract mixin class _$ExperienceCopyWith<$Res> implements $ExperienceCopyWith<$Res> {
  factory _$ExperienceCopyWith(_Experience value, $Res Function(_Experience) _then) = __$ExperienceCopyWithImpl;
@override @useResult
$Res call({
 String id, String company, String role, DateTime startDate, DateTime? endDate, List<String> achievements, List<String> technologies
});




}
/// @nodoc
class __$ExperienceCopyWithImpl<$Res>
    implements _$ExperienceCopyWith<$Res> {
  __$ExperienceCopyWithImpl(this._self, this._then);

  final _Experience _self;
  final $Res Function(_Experience) _then;

/// Create a copy of Experience
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? company = null,Object? role = null,Object? startDate = null,Object? endDate = freezed,Object? achievements = null,Object? technologies = null,}) {
  return _then(_Experience(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,achievements: null == achievements ? _self._achievements : achievements // ignore: cast_nullable_to_non_nullable
as List<String>,technologies: null == technologies ? _self._technologies : technologies // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$Project {

 String get id; String get name; String get description; String? get url; List<String> get technologies;
/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectCopyWith<Project> get copyWith => _$ProjectCopyWithImpl<Project>(this as Project, _$identity);

  /// Serializes this Project to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Project;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Project&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.url, _this.url) || other.url == _this.url)&&const DeepCollectionEquality().equals(other.technologies, _this.technologies));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Project;
  return Object.hash(runtimeType,_this.id,_this.name,_this.description,_this.url,const DeepCollectionEquality().hash(_this.technologies));
}

@override
String toString() {
  final _this = this as Project;
  return 'Project(id: ${_this.id}, name: ${_this.name}, description: ${_this.description}, url: ${_this.url}, technologies: ${_this.technologies})';
}


}

/// @nodoc
abstract mixin class $ProjectCopyWith<$Res>  {
  factory $ProjectCopyWith(Project value, $Res Function(Project) _then) = _$ProjectCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, String? url, List<String> technologies
});




}
/// @nodoc
class _$ProjectCopyWithImpl<$Res>
    implements $ProjectCopyWith<$Res> {
  _$ProjectCopyWithImpl(this._self, this._then);

  final Project _self;
  final $Res Function(Project) _then;

/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? url = freezed,Object? technologies = null,}) {
  return _then(Project(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,technologies: null == technologies ? _self.technologies : technologies // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [Project].
extension ProjectPatterns on Project {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Project value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Project() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Project value)  $default,){
final _that = this;
switch (_that) {
case _Project():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Project value)?  $default,){
final _that = this;
switch (_that) {
case _Project() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description,  String? url,  List<String> technologies)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Project() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.url,_that.technologies);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description,  String? url,  List<String> technologies)  $default,) {final _that = this;
switch (_that) {
case _Project():
return $default(_that.id,_that.name,_that.description,_that.url,_that.technologies);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description,  String? url,  List<String> technologies)?  $default,) {final _that = this;
switch (_that) {
case _Project() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.url,_that.technologies);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Project implements Project {
  const _Project({this.id = '', required this.name, this.description = '', this.url,  List<String> technologies = const []}): _technologies = technologies;
  factory _Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);

@override@JsonKey() final  String id;
@override final  String name;
@override@JsonKey() final  String description;
@override final  String? url;
 final  List<String> _technologies;
@override@JsonKey() List<String> get technologies {
  if (_technologies is EqualUnmodifiableListView) return _technologies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_technologies);
}


/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectCopyWith<_Project> get copyWith => __$ProjectCopyWithImpl<_Project>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProjectToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Project&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other.technologies, _technologies));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,description,url,const DeepCollectionEquality().hash(_technologies));
}

@override
String toString() {
    return 'Project(id: $id, name: $name, description: $description, url: $url, technologies: $technologies)';
}


}

/// @nodoc
abstract mixin class _$ProjectCopyWith<$Res> implements $ProjectCopyWith<$Res> {
  factory _$ProjectCopyWith(_Project value, $Res Function(_Project) _then) = __$ProjectCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, String? url, List<String> technologies
});




}
/// @nodoc
class __$ProjectCopyWithImpl<$Res>
    implements _$ProjectCopyWith<$Res> {
  __$ProjectCopyWithImpl(this._self, this._then);

  final _Project _self;
  final $Res Function(_Project) _then;

/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? url = freezed,Object? technologies = null,}) {
  return _then(_Project(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,technologies: null == technologies ? _self._technologies : technologies // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$Education {

 String get id; String get institution; String get degree; DateTime? get startDate; DateTime? get endDate;
/// Create a copy of Education
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EducationCopyWith<Education> get copyWith => _$EducationCopyWithImpl<Education>(this as Education, _$identity);

  /// Serializes this Education to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Education;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Education&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.institution, _this.institution) || other.institution == _this.institution)&&(identical(other.degree, _this.degree) || other.degree == _this.degree)&&(identical(other.startDate, _this.startDate) || other.startDate == _this.startDate)&&(identical(other.endDate, _this.endDate) || other.endDate == _this.endDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Education;
  return Object.hash(runtimeType,_this.id,_this.institution,_this.degree,_this.startDate,_this.endDate);
}

@override
String toString() {
  final _this = this as Education;
  return 'Education(id: ${_this.id}, institution: ${_this.institution}, degree: ${_this.degree}, startDate: ${_this.startDate}, endDate: ${_this.endDate})';
}


}

/// @nodoc
abstract mixin class $EducationCopyWith<$Res>  {
  factory $EducationCopyWith(Education value, $Res Function(Education) _then) = _$EducationCopyWithImpl;
@useResult
$Res call({
 String id, String institution, String degree, DateTime? startDate, DateTime? endDate
});




}
/// @nodoc
class _$EducationCopyWithImpl<$Res>
    implements $EducationCopyWith<$Res> {
  _$EducationCopyWithImpl(this._self, this._then);

  final Education _self;
  final $Res Function(Education) _then;

/// Create a copy of Education
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? institution = null,Object? degree = null,Object? startDate = freezed,Object? endDate = freezed,}) {
  return _then(Education(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,institution: null == institution ? _self.institution : institution // ignore: cast_nullable_to_non_nullable
as String,degree: null == degree ? _self.degree : degree // ignore: cast_nullable_to_non_nullable
as String,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Education].
extension EducationPatterns on Education {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Education value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Education() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Education value)  $default,){
final _that = this;
switch (_that) {
case _Education():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Education value)?  $default,){
final _that = this;
switch (_that) {
case _Education() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String institution,  String degree,  DateTime? startDate,  DateTime? endDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Education() when $default != null:
return $default(_that.id,_that.institution,_that.degree,_that.startDate,_that.endDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String institution,  String degree,  DateTime? startDate,  DateTime? endDate)  $default,) {final _that = this;
switch (_that) {
case _Education():
return $default(_that.id,_that.institution,_that.degree,_that.startDate,_that.endDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String institution,  String degree,  DateTime? startDate,  DateTime? endDate)?  $default,) {final _that = this;
switch (_that) {
case _Education() when $default != null:
return $default(_that.id,_that.institution,_that.degree,_that.startDate,_that.endDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Education implements Education {
  const _Education({this.id = '', required this.institution, this.degree = '', this.startDate, this.endDate});
  factory _Education.fromJson(Map<String, dynamic> json) => _$EducationFromJson(json);

@override@JsonKey() final  String id;
@override final  String institution;
@override@JsonKey() final  String degree;
@override final  DateTime? startDate;
@override final  DateTime? endDate;

/// Create a copy of Education
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EducationCopyWith<_Education> get copyWith => __$EducationCopyWithImpl<_Education>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EducationToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Education&&(identical(other.id, id) || other.id == id)&&(identical(other.institution, institution) || other.institution == institution)&&(identical(other.degree, degree) || other.degree == degree)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,institution,degree,startDate,endDate);
}

@override
String toString() {
    return 'Education(id: $id, institution: $institution, degree: $degree, startDate: $startDate, endDate: $endDate)';
}


}

/// @nodoc
abstract mixin class _$EducationCopyWith<$Res> implements $EducationCopyWith<$Res> {
  factory _$EducationCopyWith(_Education value, $Res Function(_Education) _then) = __$EducationCopyWithImpl;
@override @useResult
$Res call({
 String id, String institution, String degree, DateTime? startDate, DateTime? endDate
});




}
/// @nodoc
class __$EducationCopyWithImpl<$Res>
    implements _$EducationCopyWith<$Res> {
  __$EducationCopyWithImpl(this._self, this._then);

  final _Education _self;
  final $Res Function(_Education) _then;

/// Create a copy of Education
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? institution = null,Object? degree = null,Object? startDate = freezed,Object? endDate = freezed,}) {
  return _then(_Education(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,institution: null == institution ? _self.institution : institution // ignore: cast_nullable_to_non_nullable
as String,degree: null == degree ? _self.degree : degree // ignore: cast_nullable_to_non_nullable
as String,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$Skill {

 String get id; String get name;@JsonKey(unknownEnumValue: SkillCategory.other) SkillCategory get category; int? get years;
/// Create a copy of Skill
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SkillCopyWith<Skill> get copyWith => _$SkillCopyWithImpl<Skill>(this as Skill, _$identity);

  /// Serializes this Skill to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Skill;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Skill&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.years, _this.years) || other.years == _this.years));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Skill;
  return Object.hash(runtimeType,_this.id,_this.name,_this.category,_this.years);
}

@override
String toString() {
  final _this = this as Skill;
  return 'Skill(id: ${_this.id}, name: ${_this.name}, category: ${_this.category}, years: ${_this.years})';
}


}

/// @nodoc
abstract mixin class $SkillCopyWith<$Res>  {
  factory $SkillCopyWith(Skill value, $Res Function(Skill) _then) = _$SkillCopyWithImpl;
@useResult
$Res call({
 String id, String name,@JsonKey(unknownEnumValue: SkillCategory.other) SkillCategory category, int? years
});




}
/// @nodoc
class _$SkillCopyWithImpl<$Res>
    implements $SkillCopyWith<$Res> {
  _$SkillCopyWithImpl(this._self, this._then);

  final Skill _self;
  final $Res Function(Skill) _then;

/// Create a copy of Skill
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? category = null,Object? years = freezed,}) {
  return _then(Skill(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as SkillCategory,years: freezed == years ? _self.years : years // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [Skill].
extension SkillPatterns on Skill {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Skill value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Skill() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Skill value)  $default,){
final _that = this;
switch (_that) {
case _Skill():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Skill value)?  $default,){
final _that = this;
switch (_that) {
case _Skill() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name, @JsonKey(unknownEnumValue: SkillCategory.other)  SkillCategory category,  int? years)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Skill() when $default != null:
return $default(_that.id,_that.name,_that.category,_that.years);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name, @JsonKey(unknownEnumValue: SkillCategory.other)  SkillCategory category,  int? years)  $default,) {final _that = this;
switch (_that) {
case _Skill():
return $default(_that.id,_that.name,_that.category,_that.years);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name, @JsonKey(unknownEnumValue: SkillCategory.other)  SkillCategory category,  int? years)?  $default,) {final _that = this;
switch (_that) {
case _Skill() when $default != null:
return $default(_that.id,_that.name,_that.category,_that.years);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Skill implements Skill {
  const _Skill({this.id = '', required this.name, @JsonKey(unknownEnumValue: SkillCategory.other) this.category = SkillCategory.other, this.years});
  factory _Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);

@override@JsonKey() final  String id;
@override final  String name;
@override@JsonKey(unknownEnumValue: SkillCategory.other) final  SkillCategory category;
@override final  int? years;

/// Create a copy of Skill
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SkillCopyWith<_Skill> get copyWith => __$SkillCopyWithImpl<_Skill>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SkillToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Skill&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.years, years) || other.years == years));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,category,years);
}

@override
String toString() {
    return 'Skill(id: $id, name: $name, category: $category, years: $years)';
}


}

/// @nodoc
abstract mixin class _$SkillCopyWith<$Res> implements $SkillCopyWith<$Res> {
  factory _$SkillCopyWith(_Skill value, $Res Function(_Skill) _then) = __$SkillCopyWithImpl;
@override @useResult
$Res call({
 String id, String name,@JsonKey(unknownEnumValue: SkillCategory.other) SkillCategory category, int? years
});




}
/// @nodoc
class __$SkillCopyWithImpl<$Res>
    implements _$SkillCopyWith<$Res> {
  __$SkillCopyWithImpl(this._self, this._then);

  final _Skill _self;
  final $Res Function(_Skill) _then;

/// Create a copy of Skill
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? category = null,Object? years = freezed,}) {
  return _then(_Skill(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as SkillCategory,years: freezed == years ? _self.years : years // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
mixin _$ProfileData {

 Profile get profile; List<Experience> get experiences; List<Project> get projects; List<Skill> get skills; List<Education> get education;
/// Create a copy of ProfileData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileDataCopyWith<ProfileData> get copyWith => _$ProfileDataCopyWithImpl<ProfileData>(this as ProfileData, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ProfileData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileData&&(identical(other.profile, _this.profile) || other.profile == _this.profile)&&const DeepCollectionEquality().equals(other.experiences, _this.experiences)&&const DeepCollectionEquality().equals(other.projects, _this.projects)&&const DeepCollectionEquality().equals(other.skills, _this.skills)&&const DeepCollectionEquality().equals(other.education, _this.education));
}


@override
int get hashCode {
  final _this = this as ProfileData;
  return Object.hash(runtimeType,_this.profile,const DeepCollectionEquality().hash(_this.experiences),const DeepCollectionEquality().hash(_this.projects),const DeepCollectionEquality().hash(_this.skills),const DeepCollectionEquality().hash(_this.education));
}

@override
String toString() {
  final _this = this as ProfileData;
  return 'ProfileData(profile: ${_this.profile}, experiences: ${_this.experiences}, projects: ${_this.projects}, skills: ${_this.skills}, education: ${_this.education})';
}


}

/// @nodoc
abstract mixin class $ProfileDataCopyWith<$Res>  {
  factory $ProfileDataCopyWith(ProfileData value, $Res Function(ProfileData) _then) = _$ProfileDataCopyWithImpl;
@useResult
$Res call({
 Profile profile, List<Experience> experiences, List<Project> projects, List<Skill> skills, List<Education> education
});


$ProfileCopyWith<$Res> get profile;

}
/// @nodoc
class _$ProfileDataCopyWithImpl<$Res>
    implements $ProfileDataCopyWith<$Res> {
  _$ProfileDataCopyWithImpl(this._self, this._then);

  final ProfileData _self;
  final $Res Function(ProfileData) _then;

/// Create a copy of ProfileData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profile = null,Object? experiences = null,Object? projects = null,Object? skills = null,Object? education = null,}) {
  return _then(ProfileData(
profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as Profile,experiences: null == experiences ? _self.experiences : experiences // ignore: cast_nullable_to_non_nullable
as List<Experience>,projects: null == projects ? _self.projects : projects // ignore: cast_nullable_to_non_nullable
as List<Project>,skills: null == skills ? _self.skills : skills // ignore: cast_nullable_to_non_nullable
as List<Skill>,education: null == education ? _self.education : education // ignore: cast_nullable_to_non_nullable
as List<Education>,
  ));
}
/// Create a copy of ProfileData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileCopyWith<$Res> get profile {
  
  return $ProfileCopyWith<$Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProfileData].
extension ProfileDataPatterns on ProfileData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileData value)  $default,){
final _that = this;
switch (_that) {
case _ProfileData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileData value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Profile profile,  List<Experience> experiences,  List<Project> projects,  List<Skill> skills,  List<Education> education)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileData() when $default != null:
return $default(_that.profile,_that.experiences,_that.projects,_that.skills,_that.education);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Profile profile,  List<Experience> experiences,  List<Project> projects,  List<Skill> skills,  List<Education> education)  $default,) {final _that = this;
switch (_that) {
case _ProfileData():
return $default(_that.profile,_that.experiences,_that.projects,_that.skills,_that.education);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Profile profile,  List<Experience> experiences,  List<Project> projects,  List<Skill> skills,  List<Education> education)?  $default,) {final _that = this;
switch (_that) {
case _ProfileData() when $default != null:
return $default(_that.profile,_that.experiences,_that.projects,_that.skills,_that.education);case _:
  return null;

}
}

}

/// @nodoc


class _ProfileData implements ProfileData {
  const _ProfileData({this.profile = const Profile(),  List<Experience> experiences = const [],  List<Project> projects = const [],  List<Skill> skills = const [],  List<Education> education = const []}): _experiences = experiences,_projects = projects,_skills = skills,_education = education;
  

@override@JsonKey() final  Profile profile;
 final  List<Experience> _experiences;
@override@JsonKey() List<Experience> get experiences {
  if (_experiences is EqualUnmodifiableListView) return _experiences;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_experiences);
}

 final  List<Project> _projects;
@override@JsonKey() List<Project> get projects {
  if (_projects is EqualUnmodifiableListView) return _projects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_projects);
}

 final  List<Skill> _skills;
@override@JsonKey() List<Skill> get skills {
  if (_skills is EqualUnmodifiableListView) return _skills;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_skills);
}

 final  List<Education> _education;
@override@JsonKey() List<Education> get education {
  if (_education is EqualUnmodifiableListView) return _education;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_education);
}


/// Create a copy of ProfileData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileDataCopyWith<_ProfileData> get copyWith => __$ProfileDataCopyWithImpl<_ProfileData>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileData&&(identical(other.profile, profile) || other.profile == profile)&&const DeepCollectionEquality().equals(other.experiences, _experiences)&&const DeepCollectionEquality().equals(other.projects, _projects)&&const DeepCollectionEquality().equals(other.skills, _skills)&&const DeepCollectionEquality().equals(other.education, _education));
}


@override
int get hashCode {
    return Object.hash(runtimeType,profile,const DeepCollectionEquality().hash(_experiences),const DeepCollectionEquality().hash(_projects),const DeepCollectionEquality().hash(_skills),const DeepCollectionEquality().hash(_education));
}

@override
String toString() {
    return 'ProfileData(profile: $profile, experiences: $experiences, projects: $projects, skills: $skills, education: $education)';
}


}

/// @nodoc
abstract mixin class _$ProfileDataCopyWith<$Res> implements $ProfileDataCopyWith<$Res> {
  factory _$ProfileDataCopyWith(_ProfileData value, $Res Function(_ProfileData) _then) = __$ProfileDataCopyWithImpl;
@override @useResult
$Res call({
 Profile profile, List<Experience> experiences, List<Project> projects, List<Skill> skills, List<Education> education
});


@override $ProfileCopyWith<$Res> get profile;

}
/// @nodoc
class __$ProfileDataCopyWithImpl<$Res>
    implements _$ProfileDataCopyWith<$Res> {
  __$ProfileDataCopyWithImpl(this._self, this._then);

  final _ProfileData _self;
  final $Res Function(_ProfileData) _then;

/// Create a copy of ProfileData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profile = null,Object? experiences = null,Object? projects = null,Object? skills = null,Object? education = null,}) {
  return _then(_ProfileData(
profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as Profile,experiences: null == experiences ? _self._experiences : experiences // ignore: cast_nullable_to_non_nullable
as List<Experience>,projects: null == projects ? _self._projects : projects // ignore: cast_nullable_to_non_nullable
as List<Project>,skills: null == skills ? _self._skills : skills // ignore: cast_nullable_to_non_nullable
as List<Skill>,education: null == education ? _self._education : education // ignore: cast_nullable_to_non_nullable
as List<Education>,
  ));
}

/// Create a copy of ProfileData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileCopyWith<$Res> get profile {
  
  return $ProfileCopyWith<$Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}

// dart format on
