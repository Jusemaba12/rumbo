// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_import.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileImport {

/// Perfil resultante tras rellenar los campos vacíos.
 Profile get profile; Set<ProfileField> get filledFields; List<Experience> get experiences; List<Project> get projects; List<Skill> get skills; List<Education> get education;
/// Create a copy of ProfileImport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileImportCopyWith<ProfileImport> get copyWith => _$ProfileImportCopyWithImpl<ProfileImport>(this as ProfileImport, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ProfileImport;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileImport&&(identical(other.profile, _this.profile) || other.profile == _this.profile)&&const DeepCollectionEquality().equals(other.filledFields, _this.filledFields)&&const DeepCollectionEquality().equals(other.experiences, _this.experiences)&&const DeepCollectionEquality().equals(other.projects, _this.projects)&&const DeepCollectionEquality().equals(other.skills, _this.skills)&&const DeepCollectionEquality().equals(other.education, _this.education));
}


@override
int get hashCode {
  final _this = this as ProfileImport;
  return Object.hash(runtimeType,_this.profile,const DeepCollectionEquality().hash(_this.filledFields),const DeepCollectionEquality().hash(_this.experiences),const DeepCollectionEquality().hash(_this.projects),const DeepCollectionEquality().hash(_this.skills),const DeepCollectionEquality().hash(_this.education));
}

@override
String toString() {
  final _this = this as ProfileImport;
  return 'ProfileImport(profile: ${_this.profile}, filledFields: ${_this.filledFields}, experiences: ${_this.experiences}, projects: ${_this.projects}, skills: ${_this.skills}, education: ${_this.education})';
}


}

/// @nodoc
abstract mixin class $ProfileImportCopyWith<$Res>  {
  factory $ProfileImportCopyWith(ProfileImport value, $Res Function(ProfileImport) _then) = _$ProfileImportCopyWithImpl;
@useResult
$Res call({
 Profile profile, Set<ProfileField> filledFields, List<Experience> experiences, List<Project> projects, List<Skill> skills, List<Education> education
});


$ProfileCopyWith<$Res> get profile;

}
/// @nodoc
class _$ProfileImportCopyWithImpl<$Res>
    implements $ProfileImportCopyWith<$Res> {
  _$ProfileImportCopyWithImpl(this._self, this._then);

  final ProfileImport _self;
  final $Res Function(ProfileImport) _then;

/// Create a copy of ProfileImport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profile = null,Object? filledFields = null,Object? experiences = null,Object? projects = null,Object? skills = null,Object? education = null,}) {
  return _then(ProfileImport(
profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as Profile,filledFields: null == filledFields ? _self.filledFields : filledFields // ignore: cast_nullable_to_non_nullable
as Set<ProfileField>,experiences: null == experiences ? _self.experiences : experiences // ignore: cast_nullable_to_non_nullable
as List<Experience>,projects: null == projects ? _self.projects : projects // ignore: cast_nullable_to_non_nullable
as List<Project>,skills: null == skills ? _self.skills : skills // ignore: cast_nullable_to_non_nullable
as List<Skill>,education: null == education ? _self.education : education // ignore: cast_nullable_to_non_nullable
as List<Education>,
  ));
}
/// Create a copy of ProfileImport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileCopyWith<$Res> get profile {
  
  return $ProfileCopyWith<$Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProfileImport].
extension ProfileImportPatterns on ProfileImport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileImport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileImport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileImport value)  $default,){
final _that = this;
switch (_that) {
case _ProfileImport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileImport value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileImport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Profile profile,  Set<ProfileField> filledFields,  List<Experience> experiences,  List<Project> projects,  List<Skill> skills,  List<Education> education)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileImport() when $default != null:
return $default(_that.profile,_that.filledFields,_that.experiences,_that.projects,_that.skills,_that.education);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Profile profile,  Set<ProfileField> filledFields,  List<Experience> experiences,  List<Project> projects,  List<Skill> skills,  List<Education> education)  $default,) {final _that = this;
switch (_that) {
case _ProfileImport():
return $default(_that.profile,_that.filledFields,_that.experiences,_that.projects,_that.skills,_that.education);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Profile profile,  Set<ProfileField> filledFields,  List<Experience> experiences,  List<Project> projects,  List<Skill> skills,  List<Education> education)?  $default,) {final _that = this;
switch (_that) {
case _ProfileImport() when $default != null:
return $default(_that.profile,_that.filledFields,_that.experiences,_that.projects,_that.skills,_that.education);case _:
  return null;

}
}

}

/// @nodoc


class _ProfileImport extends ProfileImport {
  const _ProfileImport({required this.profile, required  Set<ProfileField> filledFields, required  List<Experience> experiences, required  List<Project> projects, required  List<Skill> skills, required  List<Education> education}): _filledFields = filledFields,_experiences = experiences,_projects = projects,_skills = skills,_education = education,super._();
  

/// Perfil resultante tras rellenar los campos vacíos.
@override final  Profile profile;
 final  Set<ProfileField> _filledFields;
@override Set<ProfileField> get filledFields {
  if (_filledFields is EqualUnmodifiableSetView) return _filledFields;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_filledFields);
}

 final  List<Experience> _experiences;
@override List<Experience> get experiences {
  if (_experiences is EqualUnmodifiableListView) return _experiences;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_experiences);
}

 final  List<Project> _projects;
@override List<Project> get projects {
  if (_projects is EqualUnmodifiableListView) return _projects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_projects);
}

 final  List<Skill> _skills;
@override List<Skill> get skills {
  if (_skills is EqualUnmodifiableListView) return _skills;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_skills);
}

 final  List<Education> _education;
@override List<Education> get education {
  if (_education is EqualUnmodifiableListView) return _education;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_education);
}


/// Create a copy of ProfileImport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileImportCopyWith<_ProfileImport> get copyWith => __$ProfileImportCopyWithImpl<_ProfileImport>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileImport&&(identical(other.profile, profile) || other.profile == profile)&&const DeepCollectionEquality().equals(other.filledFields, _filledFields)&&const DeepCollectionEquality().equals(other.experiences, _experiences)&&const DeepCollectionEquality().equals(other.projects, _projects)&&const DeepCollectionEquality().equals(other.skills, _skills)&&const DeepCollectionEquality().equals(other.education, _education));
}


@override
int get hashCode {
    return Object.hash(runtimeType,profile,const DeepCollectionEquality().hash(_filledFields),const DeepCollectionEquality().hash(_experiences),const DeepCollectionEquality().hash(_projects),const DeepCollectionEquality().hash(_skills),const DeepCollectionEquality().hash(_education));
}

@override
String toString() {
    return 'ProfileImport(profile: $profile, filledFields: $filledFields, experiences: $experiences, projects: $projects, skills: $skills, education: $education)';
}


}

/// @nodoc
abstract mixin class _$ProfileImportCopyWith<$Res> implements $ProfileImportCopyWith<$Res> {
  factory _$ProfileImportCopyWith(_ProfileImport value, $Res Function(_ProfileImport) _then) = __$ProfileImportCopyWithImpl;
@override @useResult
$Res call({
 Profile profile, Set<ProfileField> filledFields, List<Experience> experiences, List<Project> projects, List<Skill> skills, List<Education> education
});


@override $ProfileCopyWith<$Res> get profile;

}
/// @nodoc
class __$ProfileImportCopyWithImpl<$Res>
    implements _$ProfileImportCopyWith<$Res> {
  __$ProfileImportCopyWithImpl(this._self, this._then);

  final _ProfileImport _self;
  final $Res Function(_ProfileImport) _then;

/// Create a copy of ProfileImport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profile = null,Object? filledFields = null,Object? experiences = null,Object? projects = null,Object? skills = null,Object? education = null,}) {
  return _then(_ProfileImport(
profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as Profile,filledFields: null == filledFields ? _self._filledFields : filledFields // ignore: cast_nullable_to_non_nullable
as Set<ProfileField>,experiences: null == experiences ? _self._experiences : experiences // ignore: cast_nullable_to_non_nullable
as List<Experience>,projects: null == projects ? _self._projects : projects // ignore: cast_nullable_to_non_nullable
as List<Project>,skills: null == skills ? _self._skills : skills // ignore: cast_nullable_to_non_nullable
as List<Skill>,education: null == education ? _self._education : education // ignore: cast_nullable_to_non_nullable
as List<Education>,
  ));
}

/// Create a copy of ProfileImport
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
