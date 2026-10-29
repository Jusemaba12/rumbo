// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resume_review.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReviewIssue {

 ReviewIssueKind get kind;/// Experiencia afectada, para llevar al usuario a corregirla.
 Experience? get experience;/// Dato numérico del mensaje (logros sin cifras, longitud, meses…).
 int get count;/// Texto del mensaje (tecnologías que faltan, palabras vacías…).
 String? get detail;
/// Create a copy of ReviewIssue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewIssueCopyWith<ReviewIssue> get copyWith => _$ReviewIssueCopyWithImpl<ReviewIssue>(this as ReviewIssue, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ReviewIssue;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewIssue&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.experience, _this.experience) || other.experience == _this.experience)&&(identical(other.count, _this.count) || other.count == _this.count)&&(identical(other.detail, _this.detail) || other.detail == _this.detail));
}


@override
int get hashCode {
  final _this = this as ReviewIssue;
  return Object.hash(runtimeType,_this.kind,_this.experience,_this.count,_this.detail);
}

@override
String toString() {
  final _this = this as ReviewIssue;
  return 'ReviewIssue(kind: ${_this.kind}, experience: ${_this.experience}, count: ${_this.count}, detail: ${_this.detail})';
}


}

/// @nodoc
abstract mixin class $ReviewIssueCopyWith<$Res>  {
  factory $ReviewIssueCopyWith(ReviewIssue value, $Res Function(ReviewIssue) _then) = _$ReviewIssueCopyWithImpl;
@useResult
$Res call({
 ReviewIssueKind kind, Experience? experience, int count, String? detail
});


$ExperienceCopyWith<$Res>? get experience;

}
/// @nodoc
class _$ReviewIssueCopyWithImpl<$Res>
    implements $ReviewIssueCopyWith<$Res> {
  _$ReviewIssueCopyWithImpl(this._self, this._then);

  final ReviewIssue _self;
  final $Res Function(ReviewIssue) _then;

/// Create a copy of ReviewIssue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? experience = freezed,Object? count = null,Object? detail = freezed,}) {
  return _then(ReviewIssue(
null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ReviewIssueKind,experience: freezed == experience ? _self.experience : experience // ignore: cast_nullable_to_non_nullable
as Experience?,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ReviewIssue
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExperienceCopyWith<$Res>? get experience {
    if (_self.experience == null) {
    return null;
  }

  return $ExperienceCopyWith<$Res>(_self.experience!, (value) {
    return _then(_self.copyWith(experience: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReviewIssue].
extension ReviewIssuePatterns on ReviewIssue {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReviewIssue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReviewIssue() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReviewIssue value)  $default,){
final _that = this;
switch (_that) {
case _ReviewIssue():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReviewIssue value)?  $default,){
final _that = this;
switch (_that) {
case _ReviewIssue() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ReviewIssueKind kind,  Experience? experience,  int count,  String? detail)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReviewIssue() when $default != null:
return $default(_that.kind,_that.experience,_that.count,_that.detail);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ReviewIssueKind kind,  Experience? experience,  int count,  String? detail)  $default,) {final _that = this;
switch (_that) {
case _ReviewIssue():
return $default(_that.kind,_that.experience,_that.count,_that.detail);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ReviewIssueKind kind,  Experience? experience,  int count,  String? detail)?  $default,) {final _that = this;
switch (_that) {
case _ReviewIssue() when $default != null:
return $default(_that.kind,_that.experience,_that.count,_that.detail);case _:
  return null;

}
}

}

/// @nodoc


class _ReviewIssue extends ReviewIssue {
  const _ReviewIssue(this.kind, {this.experience, this.count = 0, this.detail}): super._();
  

@override final  ReviewIssueKind kind;
/// Experiencia afectada, para llevar al usuario a corregirla.
@override final  Experience? experience;
/// Dato numérico del mensaje (logros sin cifras, longitud, meses…).
@override@JsonKey() final  int count;
/// Texto del mensaje (tecnologías que faltan, palabras vacías…).
@override final  String? detail;

/// Create a copy of ReviewIssue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReviewIssueCopyWith<_ReviewIssue> get copyWith => __$ReviewIssueCopyWithImpl<_ReviewIssue>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReviewIssue&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.experience, experience) || other.experience == experience)&&(identical(other.count, count) || other.count == count)&&(identical(other.detail, detail) || other.detail == detail));
}


@override
int get hashCode {
    return Object.hash(runtimeType,kind,experience,count,detail);
}

@override
String toString() {
    return 'ReviewIssue(kind: $kind, experience: $experience, count: $count, detail: $detail)';
}


}

/// @nodoc
abstract mixin class _$ReviewIssueCopyWith<$Res> implements $ReviewIssueCopyWith<$Res> {
  factory _$ReviewIssueCopyWith(_ReviewIssue value, $Res Function(_ReviewIssue) _then) = __$ReviewIssueCopyWithImpl;
@override @useResult
$Res call({
 ReviewIssueKind kind, Experience? experience, int count, String? detail
});


@override $ExperienceCopyWith<$Res>? get experience;

}
/// @nodoc
class __$ReviewIssueCopyWithImpl<$Res>
    implements _$ReviewIssueCopyWith<$Res> {
  __$ReviewIssueCopyWithImpl(this._self, this._then);

  final _ReviewIssue _self;
  final $Res Function(_ReviewIssue) _then;

/// Create a copy of ReviewIssue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? experience = freezed,Object? count = null,Object? detail = freezed,}) {
  return _then(_ReviewIssue(
null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ReviewIssueKind,experience: freezed == experience ? _self.experience : experience // ignore: cast_nullable_to_non_nullable
as Experience?,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ReviewIssue
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExperienceCopyWith<$Res>? get experience {
    if (_self.experience == null) {
    return null;
  }

  return $ExperienceCopyWith<$Res>(_self.experience!, (value) {
    return _then(_self.copyWith(experience: value));
  });
}
}

/// @nodoc
mixin _$ResumeReview {

/// Puntos obtenidos en cada categoría (de 0 a su máximo).
 Map<ReviewCategory, int> get categories;/// De más a menos grave.
 List<ReviewIssue> get issues;
/// Create a copy of ResumeReview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResumeReviewCopyWith<ResumeReview> get copyWith => _$ResumeReviewCopyWithImpl<ResumeReview>(this as ResumeReview, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ResumeReview;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResumeReview&&const DeepCollectionEquality().equals(other.categories, _this.categories)&&const DeepCollectionEquality().equals(other.issues, _this.issues));
}


@override
int get hashCode {
  final _this = this as ResumeReview;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.categories),const DeepCollectionEquality().hash(_this.issues));
}

@override
String toString() {
  final _this = this as ResumeReview;
  return 'ResumeReview(categories: ${_this.categories}, issues: ${_this.issues})';
}


}

/// @nodoc
abstract mixin class $ResumeReviewCopyWith<$Res>  {
  factory $ResumeReviewCopyWith(ResumeReview value, $Res Function(ResumeReview) _then) = _$ResumeReviewCopyWithImpl;
@useResult
$Res call({
 Map<ReviewCategory, int> categories, List<ReviewIssue> issues
});




}
/// @nodoc
class _$ResumeReviewCopyWithImpl<$Res>
    implements $ResumeReviewCopyWith<$Res> {
  _$ResumeReviewCopyWithImpl(this._self, this._then);

  final ResumeReview _self;
  final $Res Function(ResumeReview) _then;

/// Create a copy of ResumeReview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categories = null,Object? issues = null,}) {
  return _then(ResumeReview(
categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as Map<ReviewCategory, int>,issues: null == issues ? _self.issues : issues // ignore: cast_nullable_to_non_nullable
as List<ReviewIssue>,
  ));
}

}


/// Adds pattern-matching-related methods to [ResumeReview].
extension ResumeReviewPatterns on ResumeReview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResumeReview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResumeReview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResumeReview value)  $default,){
final _that = this;
switch (_that) {
case _ResumeReview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResumeReview value)?  $default,){
final _that = this;
switch (_that) {
case _ResumeReview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<ReviewCategory, int> categories,  List<ReviewIssue> issues)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResumeReview() when $default != null:
return $default(_that.categories,_that.issues);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<ReviewCategory, int> categories,  List<ReviewIssue> issues)  $default,) {final _that = this;
switch (_that) {
case _ResumeReview():
return $default(_that.categories,_that.issues);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<ReviewCategory, int> categories,  List<ReviewIssue> issues)?  $default,) {final _that = this;
switch (_that) {
case _ResumeReview() when $default != null:
return $default(_that.categories,_that.issues);case _:
  return null;

}
}

}

/// @nodoc


class _ResumeReview extends ResumeReview {
  const _ResumeReview({required  Map<ReviewCategory, int> categories, required  List<ReviewIssue> issues}): _categories = categories,_issues = issues,super._();
  

/// Puntos obtenidos en cada categoría (de 0 a su máximo).
 final  Map<ReviewCategory, int> _categories;
/// Puntos obtenidos en cada categoría (de 0 a su máximo).
@override Map<ReviewCategory, int> get categories {
  if (_categories is EqualUnmodifiableMapView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_categories);
}

/// De más a menos grave.
 final  List<ReviewIssue> _issues;
/// De más a menos grave.
@override List<ReviewIssue> get issues {
  if (_issues is EqualUnmodifiableListView) return _issues;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_issues);
}


/// Create a copy of ResumeReview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResumeReviewCopyWith<_ResumeReview> get copyWith => __$ResumeReviewCopyWithImpl<_ResumeReview>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResumeReview&&const DeepCollectionEquality().equals(other.categories, _categories)&&const DeepCollectionEquality().equals(other.issues, _issues));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_issues));
}

@override
String toString() {
    return 'ResumeReview(categories: $categories, issues: $issues)';
}


}

/// @nodoc
abstract mixin class _$ResumeReviewCopyWith<$Res> implements $ResumeReviewCopyWith<$Res> {
  factory _$ResumeReviewCopyWith(_ResumeReview value, $Res Function(_ResumeReview) _then) = __$ResumeReviewCopyWithImpl;
@override @useResult
$Res call({
 Map<ReviewCategory, int> categories, List<ReviewIssue> issues
});




}
/// @nodoc
class __$ResumeReviewCopyWithImpl<$Res>
    implements _$ResumeReviewCopyWith<$Res> {
  __$ResumeReviewCopyWithImpl(this._self, this._then);

  final _ResumeReview _self;
  final $Res Function(_ResumeReview) _then;

/// Create a copy of ResumeReview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categories = null,Object? issues = null,}) {
  return _then(_ResumeReview(
categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as Map<ReviewCategory, int>,issues: null == issues ? _self._issues : issues // ignore: cast_nullable_to_non_nullable
as List<ReviewIssue>,
  ));
}


}

// dart format on
