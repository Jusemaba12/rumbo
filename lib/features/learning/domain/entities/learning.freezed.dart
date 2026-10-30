// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'learning.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LearningPlan {

 String get why; List<({String detail, String title,})> get steps; List<({String kind, String title, String url,})> get resources; String get project; int get hours;
/// Create a copy of LearningPlan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LearningPlanCopyWith<LearningPlan> get copyWith => _$LearningPlanCopyWithImpl<LearningPlan>(this as LearningPlan, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LearningPlan;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LearningPlan&&(identical(other.why, _this.why) || other.why == _this.why)&&const DeepCollectionEquality().equals(other.steps, _this.steps)&&const DeepCollectionEquality().equals(other.resources, _this.resources)&&(identical(other.project, _this.project) || other.project == _this.project)&&(identical(other.hours, _this.hours) || other.hours == _this.hours));
}


@override
int get hashCode {
  final _this = this as LearningPlan;
  return Object.hash(runtimeType,_this.why,const DeepCollectionEquality().hash(_this.steps),const DeepCollectionEquality().hash(_this.resources),_this.project,_this.hours);
}

@override
String toString() {
  final _this = this as LearningPlan;
  return 'LearningPlan(why: ${_this.why}, steps: ${_this.steps}, resources: ${_this.resources}, project: ${_this.project}, hours: ${_this.hours})';
}


}

/// @nodoc
abstract mixin class $LearningPlanCopyWith<$Res>  {
  factory $LearningPlanCopyWith(LearningPlan value, $Res Function(LearningPlan) _then) = _$LearningPlanCopyWithImpl;
@useResult
$Res call({
 String why, List<({String detail, String title,})> steps, List<({String kind, String title, String url,})> resources, String project, int hours
});




}
/// @nodoc
class _$LearningPlanCopyWithImpl<$Res>
    implements $LearningPlanCopyWith<$Res> {
  _$LearningPlanCopyWithImpl(this._self, this._then);

  final LearningPlan _self;
  final $Res Function(LearningPlan) _then;

/// Create a copy of LearningPlan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? why = null,Object? steps = null,Object? resources = null,Object? project = null,Object? hours = null,}) {
  return _then(LearningPlan(
why: null == why ? _self.why : why // ignore: cast_nullable_to_non_nullable
as String,steps: null == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as List<({String detail, String title,})>,resources: null == resources ? _self.resources : resources // ignore: cast_nullable_to_non_nullable
as List<({String kind, String title, String url,})>,project: null == project ? _self.project : project // ignore: cast_nullable_to_non_nullable
as String,hours: null == hours ? _self.hours : hours // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LearningPlan].
extension LearningPlanPatterns on LearningPlan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LearningPlan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LearningPlan() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LearningPlan value)  $default,){
final _that = this;
switch (_that) {
case _LearningPlan():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LearningPlan value)?  $default,){
final _that = this;
switch (_that) {
case _LearningPlan() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String why,  List<({String detail, String title,})> steps,  List<({String kind, String title, String url,})> resources,  String project,  int hours)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LearningPlan() when $default != null:
return $default(_that.why,_that.steps,_that.resources,_that.project,_that.hours);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String why,  List<({String detail, String title,})> steps,  List<({String kind, String title, String url,})> resources,  String project,  int hours)  $default,) {final _that = this;
switch (_that) {
case _LearningPlan():
return $default(_that.why,_that.steps,_that.resources,_that.project,_that.hours);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String why,  List<({String detail, String title,})> steps,  List<({String kind, String title, String url,})> resources,  String project,  int hours)?  $default,) {final _that = this;
switch (_that) {
case _LearningPlan() when $default != null:
return $default(_that.why,_that.steps,_that.resources,_that.project,_that.hours);case _:
  return null;

}
}

}

/// @nodoc


class _LearningPlan implements LearningPlan {
  const _LearningPlan({required this.why, required  List<({String detail, String title,})> steps, required  List<({String kind, String title, String url,})> resources, required this.project, required this.hours}): _steps = steps,_resources = resources;
  

@override final  String why;
 final  List<({String detail, String title,})> _steps;
@override List<({String detail, String title,})> get steps {
  if (_steps is EqualUnmodifiableListView) return _steps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_steps);
}

 final  List<({String kind, String title, String url,})> _resources;
@override List<({String kind, String title, String url,})> get resources {
  if (_resources is EqualUnmodifiableListView) return _resources;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_resources);
}

@override final  String project;
@override final  int hours;

/// Create a copy of LearningPlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LearningPlanCopyWith<_LearningPlan> get copyWith => __$LearningPlanCopyWithImpl<_LearningPlan>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LearningPlan&&(identical(other.why, why) || other.why == why)&&const DeepCollectionEquality().equals(other.steps, _steps)&&const DeepCollectionEquality().equals(other.resources, _resources)&&(identical(other.project, project) || other.project == project)&&(identical(other.hours, hours) || other.hours == hours));
}


@override
int get hashCode {
    return Object.hash(runtimeType,why,const DeepCollectionEquality().hash(_steps),const DeepCollectionEquality().hash(_resources),project,hours);
}

@override
String toString() {
    return 'LearningPlan(why: $why, steps: $steps, resources: $resources, project: $project, hours: $hours)';
}


}

/// @nodoc
abstract mixin class _$LearningPlanCopyWith<$Res> implements $LearningPlanCopyWith<$Res> {
  factory _$LearningPlanCopyWith(_LearningPlan value, $Res Function(_LearningPlan) _then) = __$LearningPlanCopyWithImpl;
@override @useResult
$Res call({
 String why, List<({String detail, String title,})> steps, List<({String kind, String title, String url,})> resources, String project, int hours
});




}
/// @nodoc
class __$LearningPlanCopyWithImpl<$Res>
    implements _$LearningPlanCopyWith<$Res> {
  __$LearningPlanCopyWithImpl(this._self, this._then);

  final _LearningPlan _self;
  final $Res Function(_LearningPlan) _then;

/// Create a copy of LearningPlan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? why = null,Object? steps = null,Object? resources = null,Object? project = null,Object? hours = null,}) {
  return _then(_LearningPlan(
why: null == why ? _self.why : why // ignore: cast_nullable_to_non_nullable
as String,steps: null == steps ? _self._steps : steps // ignore: cast_nullable_to_non_nullable
as List<({String detail, String title,})>,resources: null == resources ? _self._resources : resources // ignore: cast_nullable_to_non_nullable
as List<({String kind, String title, String url,})>,project: null == project ? _self.project : project // ignore: cast_nullable_to_non_nullable
as String,hours: null == hours ? _self.hours : hours // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$LearningTopic {

 String get id; String get topic; LearningStatus get status;/// En cuántas ofertas aparecía al añadirlo.
 int get demand; LearningPlan? get plan;
/// Create a copy of LearningTopic
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LearningTopicCopyWith<LearningTopic> get copyWith => _$LearningTopicCopyWithImpl<LearningTopic>(this as LearningTopic, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LearningTopic;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LearningTopic&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.topic, _this.topic) || other.topic == _this.topic)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.demand, _this.demand) || other.demand == _this.demand)&&(identical(other.plan, _this.plan) || other.plan == _this.plan));
}


@override
int get hashCode {
  final _this = this as LearningTopic;
  return Object.hash(runtimeType,_this.id,_this.topic,_this.status,_this.demand,_this.plan);
}

@override
String toString() {
  final _this = this as LearningTopic;
  return 'LearningTopic(id: ${_this.id}, topic: ${_this.topic}, status: ${_this.status}, demand: ${_this.demand}, plan: ${_this.plan})';
}


}

/// @nodoc
abstract mixin class $LearningTopicCopyWith<$Res>  {
  factory $LearningTopicCopyWith(LearningTopic value, $Res Function(LearningTopic) _then) = _$LearningTopicCopyWithImpl;
@useResult
$Res call({
 String id, String topic, LearningStatus status, int demand, LearningPlan? plan
});


$LearningPlanCopyWith<$Res>? get plan;

}
/// @nodoc
class _$LearningTopicCopyWithImpl<$Res>
    implements $LearningTopicCopyWith<$Res> {
  _$LearningTopicCopyWithImpl(this._self, this._then);

  final LearningTopic _self;
  final $Res Function(LearningTopic) _then;

/// Create a copy of LearningTopic
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? topic = null,Object? status = null,Object? demand = null,Object? plan = freezed,}) {
  return _then(LearningTopic(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LearningStatus,demand: null == demand ? _self.demand : demand // ignore: cast_nullable_to_non_nullable
as int,plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as LearningPlan?,
  ));
}
/// Create a copy of LearningTopic
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LearningPlanCopyWith<$Res>? get plan {
    if (_self.plan == null) {
    return null;
  }

  return $LearningPlanCopyWith<$Res>(_self.plan!, (value) {
    return _then(_self.copyWith(plan: value));
  });
}
}


/// Adds pattern-matching-related methods to [LearningTopic].
extension LearningTopicPatterns on LearningTopic {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LearningTopic value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LearningTopic() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LearningTopic value)  $default,){
final _that = this;
switch (_that) {
case _LearningTopic():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LearningTopic value)?  $default,){
final _that = this;
switch (_that) {
case _LearningTopic() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String topic,  LearningStatus status,  int demand,  LearningPlan? plan)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LearningTopic() when $default != null:
return $default(_that.id,_that.topic,_that.status,_that.demand,_that.plan);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String topic,  LearningStatus status,  int demand,  LearningPlan? plan)  $default,) {final _that = this;
switch (_that) {
case _LearningTopic():
return $default(_that.id,_that.topic,_that.status,_that.demand,_that.plan);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String topic,  LearningStatus status,  int demand,  LearningPlan? plan)?  $default,) {final _that = this;
switch (_that) {
case _LearningTopic() when $default != null:
return $default(_that.id,_that.topic,_that.status,_that.demand,_that.plan);case _:
  return null;

}
}

}

/// @nodoc


class _LearningTopic implements LearningTopic {
  const _LearningTopic({required this.id, required this.topic, this.status = LearningStatus.pending, this.demand = 0, this.plan});
  

@override final  String id;
@override final  String topic;
@override@JsonKey() final  LearningStatus status;
/// En cuántas ofertas aparecía al añadirlo.
@override@JsonKey() final  int demand;
@override final  LearningPlan? plan;

/// Create a copy of LearningTopic
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LearningTopicCopyWith<_LearningTopic> get copyWith => __$LearningTopicCopyWithImpl<_LearningTopic>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LearningTopic&&(identical(other.id, id) || other.id == id)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.status, status) || other.status == status)&&(identical(other.demand, demand) || other.demand == demand)&&(identical(other.plan, plan) || other.plan == plan));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,topic,status,demand,plan);
}

@override
String toString() {
    return 'LearningTopic(id: $id, topic: $topic, status: $status, demand: $demand, plan: $plan)';
}


}

/// @nodoc
abstract mixin class _$LearningTopicCopyWith<$Res> implements $LearningTopicCopyWith<$Res> {
  factory _$LearningTopicCopyWith(_LearningTopic value, $Res Function(_LearningTopic) _then) = __$LearningTopicCopyWithImpl;
@override @useResult
$Res call({
 String id, String topic, LearningStatus status, int demand, LearningPlan? plan
});


@override $LearningPlanCopyWith<$Res>? get plan;

}
/// @nodoc
class __$LearningTopicCopyWithImpl<$Res>
    implements _$LearningTopicCopyWith<$Res> {
  __$LearningTopicCopyWithImpl(this._self, this._then);

  final _LearningTopic _self;
  final $Res Function(_LearningTopic) _then;

/// Create a copy of LearningTopic
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? topic = null,Object? status = null,Object? demand = null,Object? plan = freezed,}) {
  return _then(_LearningTopic(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LearningStatus,demand: null == demand ? _self.demand : demand // ignore: cast_nullable_to_non_nullable
as int,plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as LearningPlan?,
  ));
}

/// Create a copy of LearningTopic
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LearningPlanCopyWith<$Res>? get plan {
    if (_self.plan == null) {
    return null;
  }

  return $LearningPlanCopyWith<$Res>(_self.plan!, (value) {
    return _then(_self.copyWith(plan: value));
  });
}
}

/// @nodoc
mixin _$LearningCandidate {

 String get topic;/// En cuántas de las ofertas del usuario aparece.
 int get demand;/// La IA lo marcó como imprescindible para sus cargos.
 bool get important;
/// Create a copy of LearningCandidate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LearningCandidateCopyWith<LearningCandidate> get copyWith => _$LearningCandidateCopyWithImpl<LearningCandidate>(this as LearningCandidate, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LearningCandidate;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LearningCandidate&&(identical(other.topic, _this.topic) || other.topic == _this.topic)&&(identical(other.demand, _this.demand) || other.demand == _this.demand)&&(identical(other.important, _this.important) || other.important == _this.important));
}


@override
int get hashCode {
  final _this = this as LearningCandidate;
  return Object.hash(runtimeType,_this.topic,_this.demand,_this.important);
}

@override
String toString() {
  final _this = this as LearningCandidate;
  return 'LearningCandidate(topic: ${_this.topic}, demand: ${_this.demand}, important: ${_this.important})';
}


}

/// @nodoc
abstract mixin class $LearningCandidateCopyWith<$Res>  {
  factory $LearningCandidateCopyWith(LearningCandidate value, $Res Function(LearningCandidate) _then) = _$LearningCandidateCopyWithImpl;
@useResult
$Res call({
 String topic, int demand, bool important
});




}
/// @nodoc
class _$LearningCandidateCopyWithImpl<$Res>
    implements $LearningCandidateCopyWith<$Res> {
  _$LearningCandidateCopyWithImpl(this._self, this._then);

  final LearningCandidate _self;
  final $Res Function(LearningCandidate) _then;

/// Create a copy of LearningCandidate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? topic = null,Object? demand = null,Object? important = null,}) {
  return _then(LearningCandidate(
topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,demand: null == demand ? _self.demand : demand // ignore: cast_nullable_to_non_nullable
as int,important: null == important ? _self.important : important // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [LearningCandidate].
extension LearningCandidatePatterns on LearningCandidate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LearningCandidate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LearningCandidate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LearningCandidate value)  $default,){
final _that = this;
switch (_that) {
case _LearningCandidate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LearningCandidate value)?  $default,){
final _that = this;
switch (_that) {
case _LearningCandidate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String topic,  int demand,  bool important)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LearningCandidate() when $default != null:
return $default(_that.topic,_that.demand,_that.important);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String topic,  int demand,  bool important)  $default,) {final _that = this;
switch (_that) {
case _LearningCandidate():
return $default(_that.topic,_that.demand,_that.important);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String topic,  int demand,  bool important)?  $default,) {final _that = this;
switch (_that) {
case _LearningCandidate() when $default != null:
return $default(_that.topic,_that.demand,_that.important);case _:
  return null;

}
}

}

/// @nodoc


class _LearningCandidate implements LearningCandidate {
  const _LearningCandidate({required this.topic, required this.demand, this.important = false});
  

@override final  String topic;
/// En cuántas de las ofertas del usuario aparece.
@override final  int demand;
/// La IA lo marcó como imprescindible para sus cargos.
@override@JsonKey() final  bool important;

/// Create a copy of LearningCandidate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LearningCandidateCopyWith<_LearningCandidate> get copyWith => __$LearningCandidateCopyWithImpl<_LearningCandidate>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LearningCandidate&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.demand, demand) || other.demand == demand)&&(identical(other.important, important) || other.important == important));
}


@override
int get hashCode {
    return Object.hash(runtimeType,topic,demand,important);
}

@override
String toString() {
    return 'LearningCandidate(topic: $topic, demand: $demand, important: $important)';
}


}

/// @nodoc
abstract mixin class _$LearningCandidateCopyWith<$Res> implements $LearningCandidateCopyWith<$Res> {
  factory _$LearningCandidateCopyWith(_LearningCandidate value, $Res Function(_LearningCandidate) _then) = __$LearningCandidateCopyWithImpl;
@override @useResult
$Res call({
 String topic, int demand, bool important
});




}
/// @nodoc
class __$LearningCandidateCopyWithImpl<$Res>
    implements _$LearningCandidateCopyWith<$Res> {
  __$LearningCandidateCopyWithImpl(this._self, this._then);

  final _LearningCandidate _self;
  final $Res Function(_LearningCandidate) _then;

/// Create a copy of LearningCandidate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? topic = null,Object? demand = null,Object? important = null,}) {
  return _then(_LearningCandidate(
topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,demand: null == demand ? _self.demand : demand // ignore: cast_nullable_to_non_nullable
as int,important: null == important ? _self.important : important // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
