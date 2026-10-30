// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_offer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$JobOffer {

 String get applicationId; double? get salary; String get currency; SalaryPeriod get period; WorkMode? get workMode; DateTime? get startDate; DateTime? get deadline; String get benefits; String get notes;
/// Create a copy of JobOffer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobOfferCopyWith<JobOffer> get copyWith => _$JobOfferCopyWithImpl<JobOffer>(this as JobOffer, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as JobOffer;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobOffer&&(identical(other.applicationId, _this.applicationId) || other.applicationId == _this.applicationId)&&(identical(other.salary, _this.salary) || other.salary == _this.salary)&&(identical(other.currency, _this.currency) || other.currency == _this.currency)&&(identical(other.period, _this.period) || other.period == _this.period)&&(identical(other.workMode, _this.workMode) || other.workMode == _this.workMode)&&(identical(other.startDate, _this.startDate) || other.startDate == _this.startDate)&&(identical(other.deadline, _this.deadline) || other.deadline == _this.deadline)&&(identical(other.benefits, _this.benefits) || other.benefits == _this.benefits)&&(identical(other.notes, _this.notes) || other.notes == _this.notes));
}


@override
int get hashCode {
  final _this = this as JobOffer;
  return Object.hash(runtimeType,_this.applicationId,_this.salary,_this.currency,_this.period,_this.workMode,_this.startDate,_this.deadline,_this.benefits,_this.notes);
}

@override
String toString() {
  final _this = this as JobOffer;
  return 'JobOffer(applicationId: ${_this.applicationId}, salary: ${_this.salary}, currency: ${_this.currency}, period: ${_this.period}, workMode: ${_this.workMode}, startDate: ${_this.startDate}, deadline: ${_this.deadline}, benefits: ${_this.benefits}, notes: ${_this.notes})';
}


}

/// @nodoc
abstract mixin class $JobOfferCopyWith<$Res>  {
  factory $JobOfferCopyWith(JobOffer value, $Res Function(JobOffer) _then) = _$JobOfferCopyWithImpl;
@useResult
$Res call({
 String applicationId, double? salary, String currency, SalaryPeriod period, WorkMode? workMode, DateTime? startDate, DateTime? deadline, String benefits, String notes
});




}
/// @nodoc
class _$JobOfferCopyWithImpl<$Res>
    implements $JobOfferCopyWith<$Res> {
  _$JobOfferCopyWithImpl(this._self, this._then);

  final JobOffer _self;
  final $Res Function(JobOffer) _then;

/// Create a copy of JobOffer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? applicationId = null,Object? salary = freezed,Object? currency = null,Object? period = null,Object? workMode = freezed,Object? startDate = freezed,Object? deadline = freezed,Object? benefits = null,Object? notes = null,}) {
  return _then(JobOffer(
applicationId: null == applicationId ? _self.applicationId : applicationId // ignore: cast_nullable_to_non_nullable
as String,salary: freezed == salary ? _self.salary : salary // ignore: cast_nullable_to_non_nullable
as double?,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as SalaryPeriod,workMode: freezed == workMode ? _self.workMode : workMode // ignore: cast_nullable_to_non_nullable
as WorkMode?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,deadline: freezed == deadline ? _self.deadline : deadline // ignore: cast_nullable_to_non_nullable
as DateTime?,benefits: null == benefits ? _self.benefits : benefits // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [JobOffer].
extension JobOfferPatterns on JobOffer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobOffer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobOffer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobOffer value)  $default,){
final _that = this;
switch (_that) {
case _JobOffer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobOffer value)?  $default,){
final _that = this;
switch (_that) {
case _JobOffer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String applicationId,  double? salary,  String currency,  SalaryPeriod period,  WorkMode? workMode,  DateTime? startDate,  DateTime? deadline,  String benefits,  String notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobOffer() when $default != null:
return $default(_that.applicationId,_that.salary,_that.currency,_that.period,_that.workMode,_that.startDate,_that.deadline,_that.benefits,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String applicationId,  double? salary,  String currency,  SalaryPeriod period,  WorkMode? workMode,  DateTime? startDate,  DateTime? deadline,  String benefits,  String notes)  $default,) {final _that = this;
switch (_that) {
case _JobOffer():
return $default(_that.applicationId,_that.salary,_that.currency,_that.period,_that.workMode,_that.startDate,_that.deadline,_that.benefits,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String applicationId,  double? salary,  String currency,  SalaryPeriod period,  WorkMode? workMode,  DateTime? startDate,  DateTime? deadline,  String benefits,  String notes)?  $default,) {final _that = this;
switch (_that) {
case _JobOffer() when $default != null:
return $default(_that.applicationId,_that.salary,_that.currency,_that.period,_that.workMode,_that.startDate,_that.deadline,_that.benefits,_that.notes);case _:
  return null;

}
}

}

/// @nodoc


class _JobOffer extends JobOffer {
  const _JobOffer({required this.applicationId, this.salary, this.currency = 'USD', this.period = SalaryPeriod.month, this.workMode, this.startDate, this.deadline, this.benefits = '', this.notes = ''}): super._();
  

@override final  String applicationId;
@override final  double? salary;
@override@JsonKey() final  String currency;
@override@JsonKey() final  SalaryPeriod period;
@override final  WorkMode? workMode;
@override final  DateTime? startDate;
@override final  DateTime? deadline;
@override@JsonKey() final  String benefits;
@override@JsonKey() final  String notes;

/// Create a copy of JobOffer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobOfferCopyWith<_JobOffer> get copyWith => __$JobOfferCopyWithImpl<_JobOffer>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobOffer&&(identical(other.applicationId, applicationId) || other.applicationId == applicationId)&&(identical(other.salary, salary) || other.salary == salary)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.period, period) || other.period == period)&&(identical(other.workMode, workMode) || other.workMode == workMode)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.deadline, deadline) || other.deadline == deadline)&&(identical(other.benefits, benefits) || other.benefits == benefits)&&(identical(other.notes, notes) || other.notes == notes));
}


@override
int get hashCode {
    return Object.hash(runtimeType,applicationId,salary,currency,period,workMode,startDate,deadline,benefits,notes);
}

@override
String toString() {
    return 'JobOffer(applicationId: $applicationId, salary: $salary, currency: $currency, period: $period, workMode: $workMode, startDate: $startDate, deadline: $deadline, benefits: $benefits, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$JobOfferCopyWith<$Res> implements $JobOfferCopyWith<$Res> {
  factory _$JobOfferCopyWith(_JobOffer value, $Res Function(_JobOffer) _then) = __$JobOfferCopyWithImpl;
@override @useResult
$Res call({
 String applicationId, double? salary, String currency, SalaryPeriod period, WorkMode? workMode, DateTime? startDate, DateTime? deadline, String benefits, String notes
});




}
/// @nodoc
class __$JobOfferCopyWithImpl<$Res>
    implements _$JobOfferCopyWith<$Res> {
  __$JobOfferCopyWithImpl(this._self, this._then);

  final _JobOffer _self;
  final $Res Function(_JobOffer) _then;

/// Create a copy of JobOffer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? applicationId = null,Object? salary = freezed,Object? currency = null,Object? period = null,Object? workMode = freezed,Object? startDate = freezed,Object? deadline = freezed,Object? benefits = null,Object? notes = null,}) {
  return _then(_JobOffer(
applicationId: null == applicationId ? _self.applicationId : applicationId // ignore: cast_nullable_to_non_nullable
as String,salary: freezed == salary ? _self.salary : salary // ignore: cast_nullable_to_non_nullable
as double?,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as SalaryPeriod,workMode: freezed == workMode ? _self.workMode : workMode // ignore: cast_nullable_to_non_nullable
as WorkMode?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,deadline: freezed == deadline ? _self.deadline : deadline // ignore: cast_nullable_to_non_nullable
as DateTime?,benefits: null == benefits ? _self.benefits : benefits // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
