// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_draft.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TailoredExperience _$TailoredExperienceFromJson(Map<String, dynamic> json) =>
    _TailoredExperience(
      experienceId: json['experience_id'] as String,
      company: json['company'] as String,
      role: json['role'] as String,
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
      bullets:
          (json['bullets'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$TailoredExperienceToJson(_TailoredExperience instance) =>
    <String, dynamic>{
      'experience_id': instance.experienceId,
      'company': instance.company,
      'role': instance.role,
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate?.toIso8601String(),
      'bullets': instance.bullets,
    };

_TailoredResume _$TailoredResumeFromJson(
  Map<String, dynamic> json,
) => _TailoredResume(
  headline: json['headline'] as String? ?? '',
  summary: json['summary'] as String? ?? '',
  experiences:
      (json['experiences'] as List<dynamic>?)
          ?.map((e) => TailoredExperience.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  skills:
      (json['skills'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$TailoredResumeToJson(_TailoredResume instance) =>
    <String, dynamic>{
      'headline': instance.headline,
      'summary': instance.summary,
      'experiences': instance.experiences.map((e) => e.toJson()).toList(),
      'skills': instance.skills,
    };

_ResumeChange _$ResumeChangeFromJson(Map<String, dynamic> json) =>
    _ResumeChange(
      section: json['section'] as String,
      before: json['before'] as String? ?? '',
      after: json['after'] as String? ?? '',
      reason: json['reason'] as String? ?? '',
    );

Map<String, dynamic> _$ResumeChangeToJson(_ResumeChange instance) =>
    <String, dynamic>{
      'section': instance.section,
      'before': instance.before,
      'after': instance.after,
      'reason': instance.reason,
    };
