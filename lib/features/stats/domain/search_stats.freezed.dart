// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Funnel {

 int get saved; int get applied; int get responded; int get interviews; int get offers;
/// Create a copy of Funnel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FunnelCopyWith<Funnel> get copyWith => _$FunnelCopyWithImpl<Funnel>(this as Funnel, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Funnel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Funnel&&(identical(other.saved, _this.saved) || other.saved == _this.saved)&&(identical(other.applied, _this.applied) || other.applied == _this.applied)&&(identical(other.responded, _this.responded) || other.responded == _this.responded)&&(identical(other.interviews, _this.interviews) || other.interviews == _this.interviews)&&(identical(other.offers, _this.offers) || other.offers == _this.offers));
}


@override
int get hashCode {
  final _this = this as Funnel;
  return Object.hash(runtimeType,_this.saved,_this.applied,_this.responded,_this.interviews,_this.offers);
}

@override
String toString() {
  final _this = this as Funnel;
  return 'Funnel(saved: ${_this.saved}, applied: ${_this.applied}, responded: ${_this.responded}, interviews: ${_this.interviews}, offers: ${_this.offers})';
}


}

/// @nodoc
abstract mixin class $FunnelCopyWith<$Res>  {
  factory $FunnelCopyWith(Funnel value, $Res Function(Funnel) _then) = _$FunnelCopyWithImpl;
@useResult
$Res call({
 int saved, int applied, int responded, int interviews, int offers
});




}
/// @nodoc
class _$FunnelCopyWithImpl<$Res>
    implements $FunnelCopyWith<$Res> {
  _$FunnelCopyWithImpl(this._self, this._then);

  final Funnel _self;
  final $Res Function(Funnel) _then;

/// Create a copy of Funnel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? saved = null,Object? applied = null,Object? responded = null,Object? interviews = null,Object? offers = null,}) {
  return _then(Funnel(
saved: null == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as int,applied: null == applied ? _self.applied : applied // ignore: cast_nullable_to_non_nullable
as int,responded: null == responded ? _self.responded : responded // ignore: cast_nullable_to_non_nullable
as int,interviews: null == interviews ? _self.interviews : interviews // ignore: cast_nullable_to_non_nullable
as int,offers: null == offers ? _self.offers : offers // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Funnel].
extension FunnelPatterns on Funnel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Funnel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Funnel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Funnel value)  $default,){
final _that = this;
switch (_that) {
case _Funnel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Funnel value)?  $default,){
final _that = this;
switch (_that) {
case _Funnel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int saved,  int applied,  int responded,  int interviews,  int offers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Funnel() when $default != null:
return $default(_that.saved,_that.applied,_that.responded,_that.interviews,_that.offers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int saved,  int applied,  int responded,  int interviews,  int offers)  $default,) {final _that = this;
switch (_that) {
case _Funnel():
return $default(_that.saved,_that.applied,_that.responded,_that.interviews,_that.offers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int saved,  int applied,  int responded,  int interviews,  int offers)?  $default,) {final _that = this;
switch (_that) {
case _Funnel() when $default != null:
return $default(_that.saved,_that.applied,_that.responded,_that.interviews,_that.offers);case _:
  return null;

}
}

}

/// @nodoc


class _Funnel extends Funnel {
  const _Funnel({required this.saved, required this.applied, required this.responded, required this.interviews, required this.offers}): super._();
  

@override final  int saved;
@override final  int applied;
@override final  int responded;
@override final  int interviews;
@override final  int offers;

/// Create a copy of Funnel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FunnelCopyWith<_Funnel> get copyWith => __$FunnelCopyWithImpl<_Funnel>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Funnel&&(identical(other.saved, saved) || other.saved == saved)&&(identical(other.applied, applied) || other.applied == applied)&&(identical(other.responded, responded) || other.responded == responded)&&(identical(other.interviews, interviews) || other.interviews == interviews)&&(identical(other.offers, offers) || other.offers == offers));
}


@override
int get hashCode {
    return Object.hash(runtimeType,saved,applied,responded,interviews,offers);
}

@override
String toString() {
    return 'Funnel(saved: $saved, applied: $applied, responded: $responded, interviews: $interviews, offers: $offers)';
}


}

/// @nodoc
abstract mixin class _$FunnelCopyWith<$Res> implements $FunnelCopyWith<$Res> {
  factory _$FunnelCopyWith(_Funnel value, $Res Function(_Funnel) _then) = __$FunnelCopyWithImpl;
@override @useResult
$Res call({
 int saved, int applied, int responded, int interviews, int offers
});




}
/// @nodoc
class __$FunnelCopyWithImpl<$Res>
    implements _$FunnelCopyWith<$Res> {
  __$FunnelCopyWithImpl(this._self, this._then);

  final _Funnel _self;
  final $Res Function(_Funnel) _then;

/// Create a copy of Funnel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? saved = null,Object? applied = null,Object? responded = null,Object? interviews = null,Object? offers = null,}) {
  return _then(_Funnel(
saved: null == saved ? _self.saved : saved // ignore: cast_nullable_to_non_nullable
as int,applied: null == applied ? _self.applied : applied // ignore: cast_nullable_to_non_nullable
as int,responded: null == responded ? _self.responded : responded // ignore: cast_nullable_to_non_nullable
as int,interviews: null == interviews ? _self.interviews : interviews // ignore: cast_nullable_to_non_nullable
as int,offers: null == offers ? _self.offers : offers // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$SourceStats {

/// Id de la fuente; `manual` agrupa las ofertas añadidas a mano.
 String get source; int get applied; int get responded;
/// Create a copy of SourceStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SourceStatsCopyWith<SourceStats> get copyWith => _$SourceStatsCopyWithImpl<SourceStats>(this as SourceStats, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SourceStats;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SourceStats&&(identical(other.source, _this.source) || other.source == _this.source)&&(identical(other.applied, _this.applied) || other.applied == _this.applied)&&(identical(other.responded, _this.responded) || other.responded == _this.responded));
}


@override
int get hashCode {
  final _this = this as SourceStats;
  return Object.hash(runtimeType,_this.source,_this.applied,_this.responded);
}

@override
String toString() {
  final _this = this as SourceStats;
  return 'SourceStats(source: ${_this.source}, applied: ${_this.applied}, responded: ${_this.responded})';
}


}

/// @nodoc
abstract mixin class $SourceStatsCopyWith<$Res>  {
  factory $SourceStatsCopyWith(SourceStats value, $Res Function(SourceStats) _then) = _$SourceStatsCopyWithImpl;
@useResult
$Res call({
 String source, int applied, int responded
});




}
/// @nodoc
class _$SourceStatsCopyWithImpl<$Res>
    implements $SourceStatsCopyWith<$Res> {
  _$SourceStatsCopyWithImpl(this._self, this._then);

  final SourceStats _self;
  final $Res Function(SourceStats) _then;

/// Create a copy of SourceStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? source = null,Object? applied = null,Object? responded = null,}) {
  return _then(SourceStats(
source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,applied: null == applied ? _self.applied : applied // ignore: cast_nullable_to_non_nullable
as int,responded: null == responded ? _self.responded : responded // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SourceStats].
extension SourceStatsPatterns on SourceStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SourceStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SourceStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SourceStats value)  $default,){
final _that = this;
switch (_that) {
case _SourceStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SourceStats value)?  $default,){
final _that = this;
switch (_that) {
case _SourceStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String source,  int applied,  int responded)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SourceStats() when $default != null:
return $default(_that.source,_that.applied,_that.responded);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String source,  int applied,  int responded)  $default,) {final _that = this;
switch (_that) {
case _SourceStats():
return $default(_that.source,_that.applied,_that.responded);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String source,  int applied,  int responded)?  $default,) {final _that = this;
switch (_that) {
case _SourceStats() when $default != null:
return $default(_that.source,_that.applied,_that.responded);case _:
  return null;

}
}

}

/// @nodoc


class _SourceStats implements SourceStats {
  const _SourceStats({required this.source, required this.applied, required this.responded});
  

/// Id de la fuente; `manual` agrupa las ofertas añadidas a mano.
@override final  String source;
@override final  int applied;
@override final  int responded;

/// Create a copy of SourceStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SourceStatsCopyWith<_SourceStats> get copyWith => __$SourceStatsCopyWithImpl<_SourceStats>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SourceStats&&(identical(other.source, source) || other.source == source)&&(identical(other.applied, applied) || other.applied == applied)&&(identical(other.responded, responded) || other.responded == responded));
}


@override
int get hashCode {
    return Object.hash(runtimeType,source,applied,responded);
}

@override
String toString() {
    return 'SourceStats(source: $source, applied: $applied, responded: $responded)';
}


}

/// @nodoc
abstract mixin class _$SourceStatsCopyWith<$Res> implements $SourceStatsCopyWith<$Res> {
  factory _$SourceStatsCopyWith(_SourceStats value, $Res Function(_SourceStats) _then) = __$SourceStatsCopyWithImpl;
@override @useResult
$Res call({
 String source, int applied, int responded
});




}
/// @nodoc
class __$SourceStatsCopyWithImpl<$Res>
    implements _$SourceStatsCopyWith<$Res> {
  __$SourceStatsCopyWithImpl(this._self, this._then);

  final _SourceStats _self;
  final $Res Function(_SourceStats) _then;

/// Create a copy of SourceStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? source = null,Object? applied = null,Object? responded = null,}) {
  return _then(_SourceStats(
source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,applied: null == applied ? _self.applied : applied // ignore: cast_nullable_to_non_nullable
as int,responded: null == responded ? _self.responded : responded // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$SkillGap {

 String get label; int get count;
/// Create a copy of SkillGap
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SkillGapCopyWith<SkillGap> get copyWith => _$SkillGapCopyWithImpl<SkillGap>(this as SkillGap, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SkillGap;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SkillGap&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.count, _this.count) || other.count == _this.count));
}


@override
int get hashCode {
  final _this = this as SkillGap;
  return Object.hash(runtimeType,_this.label,_this.count);
}

@override
String toString() {
  final _this = this as SkillGap;
  return 'SkillGap(label: ${_this.label}, count: ${_this.count})';
}


}

/// @nodoc
abstract mixin class $SkillGapCopyWith<$Res>  {
  factory $SkillGapCopyWith(SkillGap value, $Res Function(SkillGap) _then) = _$SkillGapCopyWithImpl;
@useResult
$Res call({
 String label, int count
});




}
/// @nodoc
class _$SkillGapCopyWithImpl<$Res>
    implements $SkillGapCopyWith<$Res> {
  _$SkillGapCopyWithImpl(this._self, this._then);

  final SkillGap _self;
  final $Res Function(SkillGap) _then;

/// Create a copy of SkillGap
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? count = null,}) {
  return _then(SkillGap(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SkillGap].
extension SkillGapPatterns on SkillGap {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SkillGap value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SkillGap() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SkillGap value)  $default,){
final _that = this;
switch (_that) {
case _SkillGap():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SkillGap value)?  $default,){
final _that = this;
switch (_that) {
case _SkillGap() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SkillGap() when $default != null:
return $default(_that.label,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  int count)  $default,) {final _that = this;
switch (_that) {
case _SkillGap():
return $default(_that.label,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  int count)?  $default,) {final _that = this;
switch (_that) {
case _SkillGap() when $default != null:
return $default(_that.label,_that.count);case _:
  return null;

}
}

}

/// @nodoc


class _SkillGap implements SkillGap {
  const _SkillGap({required this.label, required this.count});
  

@override final  String label;
@override final  int count;

/// Create a copy of SkillGap
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SkillGapCopyWith<_SkillGap> get copyWith => __$SkillGapCopyWithImpl<_SkillGap>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SkillGap&&(identical(other.label, label) || other.label == label)&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode {
    return Object.hash(runtimeType,label,count);
}

@override
String toString() {
    return 'SkillGap(label: $label, count: $count)';
}


}

/// @nodoc
abstract mixin class _$SkillGapCopyWith<$Res> implements $SkillGapCopyWith<$Res> {
  factory _$SkillGapCopyWith(_SkillGap value, $Res Function(_SkillGap) _then) = __$SkillGapCopyWithImpl;
@override @useResult
$Res call({
 String label, int count
});




}
/// @nodoc
class __$SkillGapCopyWithImpl<$Res>
    implements _$SkillGapCopyWith<$Res> {
  __$SkillGapCopyWithImpl(this._self, this._then);

  final _SkillGap _self;
  final $Res Function(_SkillGap) _then;

/// Create a copy of SkillGap
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? count = null,}) {
  return _then(_SkillGap(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$SearchStats {

 Funnel get funnel;/// Días medios entre postular y la primera respuesta; nulo sin datos.
 double? get averageResponseDays; List<SourceStats> get bySource; List<SkillGap> get gaps;/// Ofertas con compatibilidad calculada (base de las brechas).
 int get analyzedJobs;
/// Create a copy of SearchStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchStatsCopyWith<SearchStats> get copyWith => _$SearchStatsCopyWithImpl<SearchStats>(this as SearchStats, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SearchStats;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchStats&&(identical(other.funnel, _this.funnel) || other.funnel == _this.funnel)&&(identical(other.averageResponseDays, _this.averageResponseDays) || other.averageResponseDays == _this.averageResponseDays)&&const DeepCollectionEquality().equals(other.bySource, _this.bySource)&&const DeepCollectionEquality().equals(other.gaps, _this.gaps)&&(identical(other.analyzedJobs, _this.analyzedJobs) || other.analyzedJobs == _this.analyzedJobs));
}


@override
int get hashCode {
  final _this = this as SearchStats;
  return Object.hash(runtimeType,_this.funnel,_this.averageResponseDays,const DeepCollectionEquality().hash(_this.bySource),const DeepCollectionEquality().hash(_this.gaps),_this.analyzedJobs);
}

@override
String toString() {
  final _this = this as SearchStats;
  return 'SearchStats(funnel: ${_this.funnel}, averageResponseDays: ${_this.averageResponseDays}, bySource: ${_this.bySource}, gaps: ${_this.gaps}, analyzedJobs: ${_this.analyzedJobs})';
}


}

/// @nodoc
abstract mixin class $SearchStatsCopyWith<$Res>  {
  factory $SearchStatsCopyWith(SearchStats value, $Res Function(SearchStats) _then) = _$SearchStatsCopyWithImpl;
@useResult
$Res call({
 Funnel funnel, double? averageResponseDays, List<SourceStats> bySource, List<SkillGap> gaps, int analyzedJobs
});


$FunnelCopyWith<$Res> get funnel;

}
/// @nodoc
class _$SearchStatsCopyWithImpl<$Res>
    implements $SearchStatsCopyWith<$Res> {
  _$SearchStatsCopyWithImpl(this._self, this._then);

  final SearchStats _self;
  final $Res Function(SearchStats) _then;

/// Create a copy of SearchStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? funnel = null,Object? averageResponseDays = freezed,Object? bySource = null,Object? gaps = null,Object? analyzedJobs = null,}) {
  return _then(SearchStats(
funnel: null == funnel ? _self.funnel : funnel // ignore: cast_nullable_to_non_nullable
as Funnel,averageResponseDays: freezed == averageResponseDays ? _self.averageResponseDays : averageResponseDays // ignore: cast_nullable_to_non_nullable
as double?,bySource: null == bySource ? _self.bySource : bySource // ignore: cast_nullable_to_non_nullable
as List<SourceStats>,gaps: null == gaps ? _self.gaps : gaps // ignore: cast_nullable_to_non_nullable
as List<SkillGap>,analyzedJobs: null == analyzedJobs ? _self.analyzedJobs : analyzedJobs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of SearchStats
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FunnelCopyWith<$Res> get funnel {
  
  return $FunnelCopyWith<$Res>(_self.funnel, (value) {
    return _then(_self.copyWith(funnel: value));
  });
}
}


/// Adds pattern-matching-related methods to [SearchStats].
extension SearchStatsPatterns on SearchStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchStats value)  $default,){
final _that = this;
switch (_that) {
case _SearchStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchStats value)?  $default,){
final _that = this;
switch (_that) {
case _SearchStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Funnel funnel,  double? averageResponseDays,  List<SourceStats> bySource,  List<SkillGap> gaps,  int analyzedJobs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchStats() when $default != null:
return $default(_that.funnel,_that.averageResponseDays,_that.bySource,_that.gaps,_that.analyzedJobs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Funnel funnel,  double? averageResponseDays,  List<SourceStats> bySource,  List<SkillGap> gaps,  int analyzedJobs)  $default,) {final _that = this;
switch (_that) {
case _SearchStats():
return $default(_that.funnel,_that.averageResponseDays,_that.bySource,_that.gaps,_that.analyzedJobs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Funnel funnel,  double? averageResponseDays,  List<SourceStats> bySource,  List<SkillGap> gaps,  int analyzedJobs)?  $default,) {final _that = this;
switch (_that) {
case _SearchStats() when $default != null:
return $default(_that.funnel,_that.averageResponseDays,_that.bySource,_that.gaps,_that.analyzedJobs);case _:
  return null;

}
}

}

/// @nodoc


class _SearchStats implements SearchStats {
  const _SearchStats({required this.funnel, required this.averageResponseDays, required  List<SourceStats> bySource, required  List<SkillGap> gaps, required this.analyzedJobs}): _bySource = bySource,_gaps = gaps;
  

@override final  Funnel funnel;
/// Días medios entre postular y la primera respuesta; nulo sin datos.
@override final  double? averageResponseDays;
 final  List<SourceStats> _bySource;
@override List<SourceStats> get bySource {
  if (_bySource is EqualUnmodifiableListView) return _bySource;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bySource);
}

 final  List<SkillGap> _gaps;
@override List<SkillGap> get gaps {
  if (_gaps is EqualUnmodifiableListView) return _gaps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_gaps);
}

/// Ofertas con compatibilidad calculada (base de las brechas).
@override final  int analyzedJobs;

/// Create a copy of SearchStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchStatsCopyWith<_SearchStats> get copyWith => __$SearchStatsCopyWithImpl<_SearchStats>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchStats&&(identical(other.funnel, funnel) || other.funnel == funnel)&&(identical(other.averageResponseDays, averageResponseDays) || other.averageResponseDays == averageResponseDays)&&const DeepCollectionEquality().equals(other.bySource, _bySource)&&const DeepCollectionEquality().equals(other.gaps, _gaps)&&(identical(other.analyzedJobs, analyzedJobs) || other.analyzedJobs == analyzedJobs));
}


@override
int get hashCode {
    return Object.hash(runtimeType,funnel,averageResponseDays,const DeepCollectionEquality().hash(_bySource),const DeepCollectionEquality().hash(_gaps),analyzedJobs);
}

@override
String toString() {
    return 'SearchStats(funnel: $funnel, averageResponseDays: $averageResponseDays, bySource: $bySource, gaps: $gaps, analyzedJobs: $analyzedJobs)';
}


}

/// @nodoc
abstract mixin class _$SearchStatsCopyWith<$Res> implements $SearchStatsCopyWith<$Res> {
  factory _$SearchStatsCopyWith(_SearchStats value, $Res Function(_SearchStats) _then) = __$SearchStatsCopyWithImpl;
@override @useResult
$Res call({
 Funnel funnel, double? averageResponseDays, List<SourceStats> bySource, List<SkillGap> gaps, int analyzedJobs
});


@override $FunnelCopyWith<$Res> get funnel;

}
/// @nodoc
class __$SearchStatsCopyWithImpl<$Res>
    implements _$SearchStatsCopyWith<$Res> {
  __$SearchStatsCopyWithImpl(this._self, this._then);

  final _SearchStats _self;
  final $Res Function(_SearchStats) _then;

/// Create a copy of SearchStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? funnel = null,Object? averageResponseDays = freezed,Object? bySource = null,Object? gaps = null,Object? analyzedJobs = null,}) {
  return _then(_SearchStats(
funnel: null == funnel ? _self.funnel : funnel // ignore: cast_nullable_to_non_nullable
as Funnel,averageResponseDays: freezed == averageResponseDays ? _self.averageResponseDays : averageResponseDays // ignore: cast_nullable_to_non_nullable
as double?,bySource: null == bySource ? _self._bySource : bySource // ignore: cast_nullable_to_non_nullable
as List<SourceStats>,gaps: null == gaps ? _self._gaps : gaps // ignore: cast_nullable_to_non_nullable
as List<SkillGap>,analyzedJobs: null == analyzedJobs ? _self.analyzedJobs : analyzedJobs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of SearchStats
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FunnelCopyWith<$Res> get funnel {
  
  return $FunnelCopyWith<$Res>(_self.funnel, (value) {
    return _then(_self.copyWith(funnel: value));
  });
}
}

// dart format on
