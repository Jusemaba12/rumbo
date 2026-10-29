// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Job _$JobFromJson(Map<String, dynamic> json) => _Job(
  id: json['id'] as String? ?? '',
  source: json['source'] as String? ?? 'link',
  url: json['url'] as String?,
  title: json['title'] as String,
  company: json['company'] as String,
  location: json['location'] as String? ?? '',
  workMode: $enumDecodeNullable(
    _$WorkModeEnumMap,
    json['work_mode'],
    unknownValue: JsonKey.nullForUndefinedEnumValue,
  ),
  description: json['description'] as String? ?? '',
  requirements:
      (json['requirements'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  salaryMin: (json['salary_min'] as num?)?.toDouble(),
  salaryMax: (json['salary_max'] as num?)?.toDouble(),
  salaryCurrency: json['salary_currency'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  discovered: json['discovered'] as bool? ?? false,
  dismissed: json['dismissed'] as bool? ?? false,
  recruiterName: json['recruiter_name'] as String?,
  recruiterEmail: json['recruiter_email'] as String?,
  recruiterLinkedin: json['recruiter_linkedin'] as String?,
  applyMethod: $enumDecodeNullable(
    _$ApplyMethodEnumMap,
    json['apply_method'],
    unknownValue: JsonKey.nullForUndefinedEnumValue,
  ),
  applySubject: json['apply_subject'] as String?,
  asksSalary: json['asks_salary'] as bool? ?? false,
);

Map<String, dynamic> _$JobToJson(_Job instance) => <String, dynamic>{
  'id': instance.id,
  'source': instance.source,
  'url': instance.url,
  'title': instance.title,
  'company': instance.company,
  'location': instance.location,
  'work_mode': _$WorkModeEnumMap[instance.workMode],
  'description': instance.description,
  'requirements': instance.requirements,
  'salary_min': instance.salaryMin,
  'salary_max': instance.salaryMax,
  'salary_currency': instance.salaryCurrency,
  'created_at': instance.createdAt?.toIso8601String(),
  'discovered': instance.discovered,
  'dismissed': instance.dismissed,
  'recruiter_name': instance.recruiterName,
  'recruiter_email': instance.recruiterEmail,
  'recruiter_linkedin': instance.recruiterLinkedin,
  'apply_method': _$ApplyMethodEnumMap[instance.applyMethod],
  'apply_subject': instance.applySubject,
  'asks_salary': instance.asksSalary,
};

const _$WorkModeEnumMap = {
  WorkMode.remote: 'remote',
  WorkMode.hybrid: 'hybrid',
  WorkMode.onsite: 'onsite',
};

const _$ApplyMethodEnumMap = {
  ApplyMethod.email: 'email',
  ApplyMethod.directMessage: 'direct_message',
  ApplyMethod.portal: 'portal',
};

_JobMatch _$JobMatchFromJson(Map<String, dynamic> json) => _JobMatch(
  score: (json['score'] as num).toInt(),
  met:
      (json['met'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  missing:
      (json['missing'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  explanation: json['explanation'] as String? ?? '',
  model: json['model'] as String? ?? '',
  promptVersion: json['prompt_version'] as String? ?? '',
);

Map<String, dynamic> _$JobMatchToJson(_JobMatch instance) => <String, dynamic>{
  'score': instance.score,
  'met': instance.met,
  'missing': instance.missing,
  'explanation': instance.explanation,
  'model': instance.model,
  'prompt_version': instance.promptVersion,
};
