// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Job {

 String get id; String get source; String? get url; String get title; String get company; String get location;@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) WorkMode? get workMode; String get description; List<String> get requirements; double? get salaryMin; double? get salaryMax; String? get salaryCurrency; DateTime? get createdAt;/// Encontrada por la búsqueda automática y aún no guardada.
 bool get discovered;/// Sugerencia descartada; se conserva para no volver a sugerirla.
 bool get dismissed;/// Contacto que da la publicación (lo extrae la IA o lo escribe el
/// usuario). [recruiterLinkedin] es el perfil o la publicación.
 String? get recruiterName; String? get recruiterEmail; String? get recruiterLinkedin;@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) ApplyMethod? get applyMethod;/// Asunto exacto que pide la publicación para el correo.
 String? get applySubject;/// La publicación pide indicar la expectativa salarial.
 bool get asksSalary;
/// Create a copy of Job
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobCopyWith<Job> get copyWith => _$JobCopyWithImpl<Job>(this as Job, _$identity);

  /// Serializes this Job to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Job;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Job&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.source, _this.source) || other.source == _this.source)&&(identical(other.url, _this.url) || other.url == _this.url)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.company, _this.company) || other.company == _this.company)&&(identical(other.location, _this.location) || other.location == _this.location)&&(identical(other.workMode, _this.workMode) || other.workMode == _this.workMode)&&(identical(other.description, _this.description) || other.description == _this.description)&&const DeepCollectionEquality().equals(other.requirements, _this.requirements)&&(identical(other.salaryMin, _this.salaryMin) || other.salaryMin == _this.salaryMin)&&(identical(other.salaryMax, _this.salaryMax) || other.salaryMax == _this.salaryMax)&&(identical(other.salaryCurrency, _this.salaryCurrency) || other.salaryCurrency == _this.salaryCurrency)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.discovered, _this.discovered) || other.discovered == _this.discovered)&&(identical(other.dismissed, _this.dismissed) || other.dismissed == _this.dismissed)&&(identical(other.recruiterName, _this.recruiterName) || other.recruiterName == _this.recruiterName)&&(identical(other.recruiterEmail, _this.recruiterEmail) || other.recruiterEmail == _this.recruiterEmail)&&(identical(other.recruiterLinkedin, _this.recruiterLinkedin) || other.recruiterLinkedin == _this.recruiterLinkedin)&&(identical(other.applyMethod, _this.applyMethod) || other.applyMethod == _this.applyMethod)&&(identical(other.applySubject, _this.applySubject) || other.applySubject == _this.applySubject)&&(identical(other.asksSalary, _this.asksSalary) || other.asksSalary == _this.asksSalary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Job;
  return Object.hashAll([runtimeType,_this.id,_this.source,_this.url,_this.title,_this.company,_this.location,_this.workMode,_this.description,const DeepCollectionEquality().hash(_this.requirements),_this.salaryMin,_this.salaryMax,_this.salaryCurrency,_this.createdAt,_this.discovered,_this.dismissed,_this.recruiterName,_this.recruiterEmail,_this.recruiterLinkedin,_this.applyMethod,_this.applySubject,_this.asksSalary]);
}

@override
String toString() {
  final _this = this as Job;
  return 'Job(id: ${_this.id}, source: ${_this.source}, url: ${_this.url}, title: ${_this.title}, company: ${_this.company}, location: ${_this.location}, workMode: ${_this.workMode}, description: ${_this.description}, requirements: ${_this.requirements}, salaryMin: ${_this.salaryMin}, salaryMax: ${_this.salaryMax}, salaryCurrency: ${_this.salaryCurrency}, createdAt: ${_this.createdAt}, discovered: ${_this.discovered}, dismissed: ${_this.dismissed}, recruiterName: ${_this.recruiterName}, recruiterEmail: ${_this.recruiterEmail}, recruiterLinkedin: ${_this.recruiterLinkedin}, applyMethod: ${_this.applyMethod}, applySubject: ${_this.applySubject}, asksSalary: ${_this.asksSalary})';
}


}

/// @nodoc
abstract mixin class $JobCopyWith<$Res>  {
  factory $JobCopyWith(Job value, $Res Function(Job) _then) = _$JobCopyWithImpl;
@useResult
$Res call({
 String id, String source, String? url, String title, String company, String location,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) WorkMode? workMode, String description, List<String> requirements, double? salaryMin, double? salaryMax, String? salaryCurrency, DateTime? createdAt, bool discovered, bool dismissed, String? recruiterName, String? recruiterEmail, String? recruiterLinkedin,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) ApplyMethod? applyMethod, String? applySubject, bool asksSalary
});




}
/// @nodoc
class _$JobCopyWithImpl<$Res>
    implements $JobCopyWith<$Res> {
  _$JobCopyWithImpl(this._self, this._then);

  final Job _self;
  final $Res Function(Job) _then;

/// Create a copy of Job
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? source = null,Object? url = freezed,Object? title = null,Object? company = null,Object? location = null,Object? workMode = freezed,Object? description = null,Object? requirements = null,Object? salaryMin = freezed,Object? salaryMax = freezed,Object? salaryCurrency = freezed,Object? createdAt = freezed,Object? discovered = null,Object? dismissed = null,Object? recruiterName = freezed,Object? recruiterEmail = freezed,Object? recruiterLinkedin = freezed,Object? applyMethod = freezed,Object? applySubject = freezed,Object? asksSalary = null,}) {
  return _then(Job(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,workMode: freezed == workMode ? _self.workMode : workMode // ignore: cast_nullable_to_non_nullable
as WorkMode?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,requirements: null == requirements ? _self.requirements : requirements // ignore: cast_nullable_to_non_nullable
as List<String>,salaryMin: freezed == salaryMin ? _self.salaryMin : salaryMin // ignore: cast_nullable_to_non_nullable
as double?,salaryMax: freezed == salaryMax ? _self.salaryMax : salaryMax // ignore: cast_nullable_to_non_nullable
as double?,salaryCurrency: freezed == salaryCurrency ? _self.salaryCurrency : salaryCurrency // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,discovered: null == discovered ? _self.discovered : discovered // ignore: cast_nullable_to_non_nullable
as bool,dismissed: null == dismissed ? _self.dismissed : dismissed // ignore: cast_nullable_to_non_nullable
as bool,recruiterName: freezed == recruiterName ? _self.recruiterName : recruiterName // ignore: cast_nullable_to_non_nullable
as String?,recruiterEmail: freezed == recruiterEmail ? _self.recruiterEmail : recruiterEmail // ignore: cast_nullable_to_non_nullable
as String?,recruiterLinkedin: freezed == recruiterLinkedin ? _self.recruiterLinkedin : recruiterLinkedin // ignore: cast_nullable_to_non_nullable
as String?,applyMethod: freezed == applyMethod ? _self.applyMethod : applyMethod // ignore: cast_nullable_to_non_nullable
as ApplyMethod?,applySubject: freezed == applySubject ? _self.applySubject : applySubject // ignore: cast_nullable_to_non_nullable
as String?,asksSalary: null == asksSalary ? _self.asksSalary : asksSalary // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Job].
extension JobPatterns on Job {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Job value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Job() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Job value)  $default,){
final _that = this;
switch (_that) {
case _Job():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Job value)?  $default,){
final _that = this;
switch (_that) {
case _Job() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String source,  String? url,  String title,  String company,  String location, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  WorkMode? workMode,  String description,  List<String> requirements,  double? salaryMin,  double? salaryMax,  String? salaryCurrency,  DateTime? createdAt,  bool discovered,  bool dismissed,  String? recruiterName,  String? recruiterEmail,  String? recruiterLinkedin, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  ApplyMethod? applyMethod,  String? applySubject,  bool asksSalary)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Job() when $default != null:
return $default(_that.id,_that.source,_that.url,_that.title,_that.company,_that.location,_that.workMode,_that.description,_that.requirements,_that.salaryMin,_that.salaryMax,_that.salaryCurrency,_that.createdAt,_that.discovered,_that.dismissed,_that.recruiterName,_that.recruiterEmail,_that.recruiterLinkedin,_that.applyMethod,_that.applySubject,_that.asksSalary);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String source,  String? url,  String title,  String company,  String location, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  WorkMode? workMode,  String description,  List<String> requirements,  double? salaryMin,  double? salaryMax,  String? salaryCurrency,  DateTime? createdAt,  bool discovered,  bool dismissed,  String? recruiterName,  String? recruiterEmail,  String? recruiterLinkedin, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  ApplyMethod? applyMethod,  String? applySubject,  bool asksSalary)  $default,) {final _that = this;
switch (_that) {
case _Job():
return $default(_that.id,_that.source,_that.url,_that.title,_that.company,_that.location,_that.workMode,_that.description,_that.requirements,_that.salaryMin,_that.salaryMax,_that.salaryCurrency,_that.createdAt,_that.discovered,_that.dismissed,_that.recruiterName,_that.recruiterEmail,_that.recruiterLinkedin,_that.applyMethod,_that.applySubject,_that.asksSalary);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String source,  String? url,  String title,  String company,  String location, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  WorkMode? workMode,  String description,  List<String> requirements,  double? salaryMin,  double? salaryMax,  String? salaryCurrency,  DateTime? createdAt,  bool discovered,  bool dismissed,  String? recruiterName,  String? recruiterEmail,  String? recruiterLinkedin, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  ApplyMethod? applyMethod,  String? applySubject,  bool asksSalary)?  $default,) {final _that = this;
switch (_that) {
case _Job() when $default != null:
return $default(_that.id,_that.source,_that.url,_that.title,_that.company,_that.location,_that.workMode,_that.description,_that.requirements,_that.salaryMin,_that.salaryMax,_that.salaryCurrency,_that.createdAt,_that.discovered,_that.dismissed,_that.recruiterName,_that.recruiterEmail,_that.recruiterLinkedin,_that.applyMethod,_that.applySubject,_that.asksSalary);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Job extends Job {
  const _Job({this.id = '', this.source = 'link', this.url, required this.title, required this.company, this.location = '', @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) this.workMode, this.description = '',  List<String> requirements = const <String>[], this.salaryMin, this.salaryMax, this.salaryCurrency, this.createdAt, this.discovered = false, this.dismissed = false, this.recruiterName, this.recruiterEmail, this.recruiterLinkedin, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) this.applyMethod, this.applySubject, this.asksSalary = false}): _requirements = requirements,super._();
  factory _Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);

@override@JsonKey() final  String id;
@override@JsonKey() final  String source;
@override final  String? url;
@override final  String title;
@override final  String company;
@override@JsonKey() final  String location;
@override@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) final  WorkMode? workMode;
@override@JsonKey() final  String description;
 final  List<String> _requirements;
@override@JsonKey() List<String> get requirements {
  if (_requirements is EqualUnmodifiableListView) return _requirements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_requirements);
}

@override final  double? salaryMin;
@override final  double? salaryMax;
@override final  String? salaryCurrency;
@override final  DateTime? createdAt;
/// Encontrada por la búsqueda automática y aún no guardada.
@override@JsonKey() final  bool discovered;
/// Sugerencia descartada; se conserva para no volver a sugerirla.
@override@JsonKey() final  bool dismissed;
/// Contacto que da la publicación (lo extrae la IA o lo escribe el
/// usuario). [recruiterLinkedin] es el perfil o la publicación.
@override final  String? recruiterName;
@override final  String? recruiterEmail;
@override final  String? recruiterLinkedin;
@override@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) final  ApplyMethod? applyMethod;
/// Asunto exacto que pide la publicación para el correo.
@override final  String? applySubject;
/// La publicación pide indicar la expectativa salarial.
@override@JsonKey() final  bool asksSalary;

/// Create a copy of Job
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobCopyWith<_Job> get copyWith => __$JobCopyWithImpl<_Job>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Job&&(identical(other.id, id) || other.id == id)&&(identical(other.source, source) || other.source == source)&&(identical(other.url, url) || other.url == url)&&(identical(other.title, title) || other.title == title)&&(identical(other.company, company) || other.company == company)&&(identical(other.location, location) || other.location == location)&&(identical(other.workMode, workMode) || other.workMode == workMode)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.requirements, _requirements)&&(identical(other.salaryMin, salaryMin) || other.salaryMin == salaryMin)&&(identical(other.salaryMax, salaryMax) || other.salaryMax == salaryMax)&&(identical(other.salaryCurrency, salaryCurrency) || other.salaryCurrency == salaryCurrency)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.discovered, discovered) || other.discovered == discovered)&&(identical(other.dismissed, dismissed) || other.dismissed == dismissed)&&(identical(other.recruiterName, recruiterName) || other.recruiterName == recruiterName)&&(identical(other.recruiterEmail, recruiterEmail) || other.recruiterEmail == recruiterEmail)&&(identical(other.recruiterLinkedin, recruiterLinkedin) || other.recruiterLinkedin == recruiterLinkedin)&&(identical(other.applyMethod, applyMethod) || other.applyMethod == applyMethod)&&(identical(other.applySubject, applySubject) || other.applySubject == applySubject)&&(identical(other.asksSalary, asksSalary) || other.asksSalary == asksSalary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,id,source,url,title,company,location,workMode,description,const DeepCollectionEquality().hash(_requirements),salaryMin,salaryMax,salaryCurrency,createdAt,discovered,dismissed,recruiterName,recruiterEmail,recruiterLinkedin,applyMethod,applySubject,asksSalary]);
}

@override
String toString() {
    return 'Job(id: $id, source: $source, url: $url, title: $title, company: $company, location: $location, workMode: $workMode, description: $description, requirements: $requirements, salaryMin: $salaryMin, salaryMax: $salaryMax, salaryCurrency: $salaryCurrency, createdAt: $createdAt, discovered: $discovered, dismissed: $dismissed, recruiterName: $recruiterName, recruiterEmail: $recruiterEmail, recruiterLinkedin: $recruiterLinkedin, applyMethod: $applyMethod, applySubject: $applySubject, asksSalary: $asksSalary)';
}


}

/// @nodoc
abstract mixin class _$JobCopyWith<$Res> implements $JobCopyWith<$Res> {
  factory _$JobCopyWith(_Job value, $Res Function(_Job) _then) = __$JobCopyWithImpl;
@override @useResult
$Res call({
 String id, String source, String? url, String title, String company, String location,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) WorkMode? workMode, String description, List<String> requirements, double? salaryMin, double? salaryMax, String? salaryCurrency, DateTime? createdAt, bool discovered, bool dismissed, String? recruiterName, String? recruiterEmail, String? recruiterLinkedin,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) ApplyMethod? applyMethod, String? applySubject, bool asksSalary
});




}
/// @nodoc
class __$JobCopyWithImpl<$Res>
    implements _$JobCopyWith<$Res> {
  __$JobCopyWithImpl(this._self, this._then);

  final _Job _self;
  final $Res Function(_Job) _then;

/// Create a copy of Job
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? source = null,Object? url = freezed,Object? title = null,Object? company = null,Object? location = null,Object? workMode = freezed,Object? description = null,Object? requirements = null,Object? salaryMin = freezed,Object? salaryMax = freezed,Object? salaryCurrency = freezed,Object? createdAt = freezed,Object? discovered = null,Object? dismissed = null,Object? recruiterName = freezed,Object? recruiterEmail = freezed,Object? recruiterLinkedin = freezed,Object? applyMethod = freezed,Object? applySubject = freezed,Object? asksSalary = null,}) {
  return _then(_Job(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,workMode: freezed == workMode ? _self.workMode : workMode // ignore: cast_nullable_to_non_nullable
as WorkMode?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,requirements: null == requirements ? _self._requirements : requirements // ignore: cast_nullable_to_non_nullable
as List<String>,salaryMin: freezed == salaryMin ? _self.salaryMin : salaryMin // ignore: cast_nullable_to_non_nullable
as double?,salaryMax: freezed == salaryMax ? _self.salaryMax : salaryMax // ignore: cast_nullable_to_non_nullable
as double?,salaryCurrency: freezed == salaryCurrency ? _self.salaryCurrency : salaryCurrency // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,discovered: null == discovered ? _self.discovered : discovered // ignore: cast_nullable_to_non_nullable
as bool,dismissed: null == dismissed ? _self.dismissed : dismissed // ignore: cast_nullable_to_non_nullable
as bool,recruiterName: freezed == recruiterName ? _self.recruiterName : recruiterName // ignore: cast_nullable_to_non_nullable
as String?,recruiterEmail: freezed == recruiterEmail ? _self.recruiterEmail : recruiterEmail // ignore: cast_nullable_to_non_nullable
as String?,recruiterLinkedin: freezed == recruiterLinkedin ? _self.recruiterLinkedin : recruiterLinkedin // ignore: cast_nullable_to_non_nullable
as String?,applyMethod: freezed == applyMethod ? _self.applyMethod : applyMethod // ignore: cast_nullable_to_non_nullable
as ApplyMethod?,applySubject: freezed == applySubject ? _self.applySubject : applySubject // ignore: cast_nullable_to_non_nullable
as String?,asksSalary: null == asksSalary ? _self.asksSalary : asksSalary // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$JobMatch {

 int get score; List<String> get met; List<String> get missing; String get explanation; String get model; String get promptVersion;
/// Create a copy of JobMatch
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobMatchCopyWith<JobMatch> get copyWith => _$JobMatchCopyWithImpl<JobMatch>(this as JobMatch, _$identity);

  /// Serializes this JobMatch to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as JobMatch;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobMatch&&(identical(other.score, _this.score) || other.score == _this.score)&&const DeepCollectionEquality().equals(other.met, _this.met)&&const DeepCollectionEquality().equals(other.missing, _this.missing)&&(identical(other.explanation, _this.explanation) || other.explanation == _this.explanation)&&(identical(other.model, _this.model) || other.model == _this.model)&&(identical(other.promptVersion, _this.promptVersion) || other.promptVersion == _this.promptVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as JobMatch;
  return Object.hash(runtimeType,_this.score,const DeepCollectionEquality().hash(_this.met),const DeepCollectionEquality().hash(_this.missing),_this.explanation,_this.model,_this.promptVersion);
}

@override
String toString() {
  final _this = this as JobMatch;
  return 'JobMatch(score: ${_this.score}, met: ${_this.met}, missing: ${_this.missing}, explanation: ${_this.explanation}, model: ${_this.model}, promptVersion: ${_this.promptVersion})';
}


}

/// @nodoc
abstract mixin class $JobMatchCopyWith<$Res>  {
  factory $JobMatchCopyWith(JobMatch value, $Res Function(JobMatch) _then) = _$JobMatchCopyWithImpl;
@useResult
$Res call({
 int score, List<String> met, List<String> missing, String explanation, String model, String promptVersion
});




}
/// @nodoc
class _$JobMatchCopyWithImpl<$Res>
    implements $JobMatchCopyWith<$Res> {
  _$JobMatchCopyWithImpl(this._self, this._then);

  final JobMatch _self;
  final $Res Function(JobMatch) _then;

/// Create a copy of JobMatch
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? score = null,Object? met = null,Object? missing = null,Object? explanation = null,Object? model = null,Object? promptVersion = null,}) {
  return _then(JobMatch(
score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,met: null == met ? _self.met : met // ignore: cast_nullable_to_non_nullable
as List<String>,missing: null == missing ? _self.missing : missing // ignore: cast_nullable_to_non_nullable
as List<String>,explanation: null == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,promptVersion: null == promptVersion ? _self.promptVersion : promptVersion // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [JobMatch].
extension JobMatchPatterns on JobMatch {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobMatch value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobMatch() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobMatch value)  $default,){
final _that = this;
switch (_that) {
case _JobMatch():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobMatch value)?  $default,){
final _that = this;
switch (_that) {
case _JobMatch() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int score,  List<String> met,  List<String> missing,  String explanation,  String model,  String promptVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobMatch() when $default != null:
return $default(_that.score,_that.met,_that.missing,_that.explanation,_that.model,_that.promptVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int score,  List<String> met,  List<String> missing,  String explanation,  String model,  String promptVersion)  $default,) {final _that = this;
switch (_that) {
case _JobMatch():
return $default(_that.score,_that.met,_that.missing,_that.explanation,_that.model,_that.promptVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int score,  List<String> met,  List<String> missing,  String explanation,  String model,  String promptVersion)?  $default,) {final _that = this;
switch (_that) {
case _JobMatch() when $default != null:
return $default(_that.score,_that.met,_that.missing,_that.explanation,_that.model,_that.promptVersion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobMatch implements JobMatch {
  const _JobMatch({required this.score,  List<String> met = const <String>[],  List<String> missing = const <String>[], this.explanation = '', this.model = '', this.promptVersion = ''}): _met = met,_missing = missing;
  factory _JobMatch.fromJson(Map<String, dynamic> json) => _$JobMatchFromJson(json);

@override final  int score;
 final  List<String> _met;
@override@JsonKey() List<String> get met {
  if (_met is EqualUnmodifiableListView) return _met;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_met);
}

 final  List<String> _missing;
@override@JsonKey() List<String> get missing {
  if (_missing is EqualUnmodifiableListView) return _missing;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_missing);
}

@override@JsonKey() final  String explanation;
@override@JsonKey() final  String model;
@override@JsonKey() final  String promptVersion;

/// Create a copy of JobMatch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobMatchCopyWith<_JobMatch> get copyWith => __$JobMatchCopyWithImpl<_JobMatch>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobMatchToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobMatch&&(identical(other.score, score) || other.score == score)&&const DeepCollectionEquality().equals(other.met, _met)&&const DeepCollectionEquality().equals(other.missing, _missing)&&(identical(other.explanation, explanation) || other.explanation == explanation)&&(identical(other.model, model) || other.model == model)&&(identical(other.promptVersion, promptVersion) || other.promptVersion == promptVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,score,const DeepCollectionEquality().hash(_met),const DeepCollectionEquality().hash(_missing),explanation,model,promptVersion);
}

@override
String toString() {
    return 'JobMatch(score: $score, met: $met, missing: $missing, explanation: $explanation, model: $model, promptVersion: $promptVersion)';
}


}

/// @nodoc
abstract mixin class _$JobMatchCopyWith<$Res> implements $JobMatchCopyWith<$Res> {
  factory _$JobMatchCopyWith(_JobMatch value, $Res Function(_JobMatch) _then) = __$JobMatchCopyWithImpl;
@override @useResult
$Res call({
 int score, List<String> met, List<String> missing, String explanation, String model, String promptVersion
});




}
/// @nodoc
class __$JobMatchCopyWithImpl<$Res>
    implements _$JobMatchCopyWith<$Res> {
  __$JobMatchCopyWithImpl(this._self, this._then);

  final _JobMatch _self;
  final $Res Function(_JobMatch) _then;

/// Create a copy of JobMatch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? score = null,Object? met = null,Object? missing = null,Object? explanation = null,Object? model = null,Object? promptVersion = null,}) {
  return _then(_JobMatch(
score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,met: null == met ? _self._met : met // ignore: cast_nullable_to_non_nullable
as List<String>,missing: null == missing ? _self._missing : missing // ignore: cast_nullable_to_non_nullable
as List<String>,explanation: null == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,promptVersion: null == promptVersion ? _self.promptVersion : promptVersion // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$SavedJob {

 Job get job; JobMatch? get match;
/// Create a copy of SavedJob
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavedJobCopyWith<SavedJob> get copyWith => _$SavedJobCopyWithImpl<SavedJob>(this as SavedJob, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SavedJob;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavedJob&&(identical(other.job, _this.job) || other.job == _this.job)&&(identical(other.match, _this.match) || other.match == _this.match));
}


@override
int get hashCode {
  final _this = this as SavedJob;
  return Object.hash(runtimeType,_this.job,_this.match);
}

@override
String toString() {
  final _this = this as SavedJob;
  return 'SavedJob(job: ${_this.job}, match: ${_this.match})';
}


}

/// @nodoc
abstract mixin class $SavedJobCopyWith<$Res>  {
  factory $SavedJobCopyWith(SavedJob value, $Res Function(SavedJob) _then) = _$SavedJobCopyWithImpl;
@useResult
$Res call({
 Job job, JobMatch? match
});


$JobCopyWith<$Res> get job;$JobMatchCopyWith<$Res>? get match;

}
/// @nodoc
class _$SavedJobCopyWithImpl<$Res>
    implements $SavedJobCopyWith<$Res> {
  _$SavedJobCopyWithImpl(this._self, this._then);

  final SavedJob _self;
  final $Res Function(SavedJob) _then;

/// Create a copy of SavedJob
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? job = null,Object? match = freezed,}) {
  return _then(SavedJob(
job: null == job ? _self.job : job // ignore: cast_nullable_to_non_nullable
as Job,match: freezed == match ? _self.match : match // ignore: cast_nullable_to_non_nullable
as JobMatch?,
  ));
}
/// Create a copy of SavedJob
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JobCopyWith<$Res> get job {
  
  return $JobCopyWith<$Res>(_self.job, (value) {
    return _then(_self.copyWith(job: value));
  });
}/// Create a copy of SavedJob
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JobMatchCopyWith<$Res>? get match {
    if (_self.match == null) {
    return null;
  }

  return $JobMatchCopyWith<$Res>(_self.match!, (value) {
    return _then(_self.copyWith(match: value));
  });
}
}


/// Adds pattern-matching-related methods to [SavedJob].
extension SavedJobPatterns on SavedJob {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavedJob value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavedJob() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavedJob value)  $default,){
final _that = this;
switch (_that) {
case _SavedJob():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavedJob value)?  $default,){
final _that = this;
switch (_that) {
case _SavedJob() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Job job,  JobMatch? match)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavedJob() when $default != null:
return $default(_that.job,_that.match);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Job job,  JobMatch? match)  $default,) {final _that = this;
switch (_that) {
case _SavedJob():
return $default(_that.job,_that.match);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Job job,  JobMatch? match)?  $default,) {final _that = this;
switch (_that) {
case _SavedJob() when $default != null:
return $default(_that.job,_that.match);case _:
  return null;

}
}

}

/// @nodoc


class _SavedJob implements SavedJob {
  const _SavedJob({required this.job, this.match});
  

@override final  Job job;
@override final  JobMatch? match;

/// Create a copy of SavedJob
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavedJobCopyWith<_SavedJob> get copyWith => __$SavedJobCopyWithImpl<_SavedJob>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavedJob&&(identical(other.job, job) || other.job == job)&&(identical(other.match, match) || other.match == match));
}


@override
int get hashCode {
    return Object.hash(runtimeType,job,match);
}

@override
String toString() {
    return 'SavedJob(job: $job, match: $match)';
}


}

/// @nodoc
abstract mixin class _$SavedJobCopyWith<$Res> implements $SavedJobCopyWith<$Res> {
  factory _$SavedJobCopyWith(_SavedJob value, $Res Function(_SavedJob) _then) = __$SavedJobCopyWithImpl;
@override @useResult
$Res call({
 Job job, JobMatch? match
});


@override $JobCopyWith<$Res> get job;@override $JobMatchCopyWith<$Res>? get match;

}
/// @nodoc
class __$SavedJobCopyWithImpl<$Res>
    implements _$SavedJobCopyWith<$Res> {
  __$SavedJobCopyWithImpl(this._self, this._then);

  final _SavedJob _self;
  final $Res Function(_SavedJob) _then;

/// Create a copy of SavedJob
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? job = null,Object? match = freezed,}) {
  return _then(_SavedJob(
job: null == job ? _self.job : job // ignore: cast_nullable_to_non_nullable
as Job,match: freezed == match ? _self.match : match // ignore: cast_nullable_to_non_nullable
as JobMatch?,
  ));
}

/// Create a copy of SavedJob
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JobCopyWith<$Res> get job {
  
  return $JobCopyWith<$Res>(_self.job, (value) {
    return _then(_self.copyWith(job: value));
  });
}/// Create a copy of SavedJob
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JobMatchCopyWith<$Res>? get match {
    if (_self.match == null) {
    return null;
  }

  return $JobMatchCopyWith<$Res>(_self.match!, (value) {
    return _then(_self.copyWith(match: value));
  });
}
}

// dart format on
