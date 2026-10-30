// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SpokenLanguage _$SpokenLanguageFromJson(Map<String, dynamic> json) =>
    _SpokenLanguage(
      language: json['language'] as String,
      level: $enumDecodeNullable(
        _$LanguageLevelEnumMap,
        json['level'],
        unknownValue: JsonKey.nullForUndefinedEnumValue,
      ),
    );

Map<String, dynamic> _$SpokenLanguageToJson(_SpokenLanguage instance) =>
    <String, dynamic>{
      'language': instance.language,
      'level': _$LanguageLevelEnumMap[instance.level],
    };

const _$LanguageLevelEnumMap = {
  LanguageLevel.a1: 'A1',
  LanguageLevel.a2: 'A2',
  LanguageLevel.b1: 'B1',
  LanguageLevel.b2: 'B2',
  LanguageLevel.c1: 'C1',
  LanguageLevel.c2: 'C2',
  LanguageLevel.native: 'native',
};

_Profile _$ProfileFromJson(Map<String, dynamic> json) => _Profile(
  fullName: json['full_name'] as String? ?? '',
  headline: json['headline'] as String? ?? '',
  summary: json['summary'] as String? ?? '',
  location: json['location'] as String? ?? '',
  email: json['email'] as String? ?? '',
  phone: json['phone'] as String? ?? '',
  links:
      (json['links'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const <String, String>{},
  languages:
      (json['languages'] as List<dynamic>?)
          ?.map((e) => SpokenLanguage.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SpokenLanguage>[],
  salaryCopMin: (json['salary_cop_min'] as num?)?.toInt(),
  salaryCopMax: (json['salary_cop_max'] as num?)?.toInt(),
  salaryUsdMin: (json['salary_usd_min'] as num?)?.toInt(),
  salaryUsdMax: (json['salary_usd_max'] as num?)?.toInt(),
);

Map<String, dynamic> _$ProfileToJson(_Profile instance) => <String, dynamic>{
  'full_name': instance.fullName,
  'headline': instance.headline,
  'summary': instance.summary,
  'location': instance.location,
  'email': instance.email,
  'phone': instance.phone,
  'links': instance.links,
  'languages': instance.languages.map((e) => e.toJson()).toList(),
  'salary_cop_min': instance.salaryCopMin,
  'salary_cop_max': instance.salaryCopMax,
  'salary_usd_min': instance.salaryUsdMin,
  'salary_usd_max': instance.salaryUsdMax,
};

_Experience _$ExperienceFromJson(Map<String, dynamic> json) => _Experience(
  id: json['id'] as String? ?? '',
  company: json['company'] as String,
  role: json['role'] as String,
  startDate: DateTime.parse(json['start_date'] as String),
  endDate: json['end_date'] == null
      ? null
      : DateTime.parse(json['end_date'] as String),
  achievements:
      (json['achievements'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  technologies:
      (json['technologies'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
);

Map<String, dynamic> _$ExperienceToJson(_Experience instance) =>
    <String, dynamic>{
      'id': instance.id,
      'company': instance.company,
      'role': instance.role,
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate?.toIso8601String(),
      'achievements': instance.achievements,
      'technologies': instance.technologies,
    };

_Project _$ProjectFromJson(Map<String, dynamic> json) => _Project(
  id: json['id'] as String? ?? '',
  name: json['name'] as String,
  description: json['description'] as String? ?? '',
  url: json['url'] as String?,
  technologies:
      (json['technologies'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
);

Map<String, dynamic> _$ProjectToJson(_Project instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'url': instance.url,
  'technologies': instance.technologies,
};

_Education _$EducationFromJson(Map<String, dynamic> json) => _Education(
  id: json['id'] as String? ?? '',
  institution: json['institution'] as String,
  degree: json['degree'] as String? ?? '',
  startDate: json['start_date'] == null
      ? null
      : DateTime.parse(json['start_date'] as String),
  endDate: json['end_date'] == null
      ? null
      : DateTime.parse(json['end_date'] as String),
);

Map<String, dynamic> _$EducationToJson(_Education instance) =>
    <String, dynamic>{
      'id': instance.id,
      'institution': instance.institution,
      'degree': instance.degree,
      'start_date': instance.startDate?.toIso8601String(),
      'end_date': instance.endDate?.toIso8601String(),
    };

_Skill _$SkillFromJson(Map<String, dynamic> json) => _Skill(
  id: json['id'] as String? ?? '',
  name: json['name'] as String,
  category:
      $enumDecodeNullable(
        _$SkillCategoryEnumMap,
        json['category'],
        unknownValue: SkillCategory.other,
      ) ??
      SkillCategory.other,
  years: (json['years'] as num?)?.toInt(),
);

Map<String, dynamic> _$SkillToJson(_Skill instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'category': _$SkillCategoryEnumMap[instance.category]!,
  'years': instance.years,
};

const _$SkillCategoryEnumMap = {
  SkillCategory.language: 'language',
  SkillCategory.framework: 'framework',
  SkillCategory.tool: 'tool',
  SkillCategory.other: 'other',
};
