import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

/// Claves usadas en [Profile.links].
abstract final class ProfileLinks {
  static const linkedin = 'linkedin';
  static const github = 'github';
  static const portfolio = 'portfolio';
}

/// Nivel de idioma según el Marco Común Europeo (MCER).
enum LanguageLevel {
  @JsonValue('A1')
  a1,
  @JsonValue('A2')
  a2,
  @JsonValue('B1')
  b1,
  @JsonValue('B2')
  b2,
  @JsonValue('C1')
  c1,
  @JsonValue('C2')
  c2,
  @JsonValue('native')
  native,
}

/// Idioma que habla el candidato; [language] es el código ISO (`en`).
@freezed
abstract class SpokenLanguage with _$SpokenLanguage {
  const factory SpokenLanguage({
    required String language,
    @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
    LanguageLevel? level,
  }) = _SpokenLanguage;

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) =>
      _$SpokenLanguageFromJson(json);
}

@freezed
abstract class Profile with _$Profile {
  const Profile._();

  const factory Profile({
    @Default('') String fullName,
    @Default('') String headline,
    @Default('') String summary,
    @Default('') String location,
    @Default('') String email,
    @Default('') String phone,
    @Default({}) Map<String, String> links,
    @Default([]) List<SpokenLanguage> languages,

    /// Expectativa salarial bruta mensual.
    int? salaryCopMin,
    int? salaryCopMax,
    int? salaryUsdMin,
    int? salaryUsdMax,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  LanguageLevel? get englishLevel =>
      languages.where((l) => l.language == 'en').firstOrNull?.level;

  /// Cambia el nivel de inglés; nulo lo quita.
  Profile withEnglish(LanguageLevel? level) => copyWith(
    languages: [
      ...languages.where((l) => l.language != 'en'),
      if (level != null) SpokenLanguage(language: 'en', level: level),
    ],
  );

  bool get hasSalaryExpectation =>
      salaryCopMin != null ||
      salaryCopMax != null ||
      salaryUsdMin != null ||
      salaryUsdMax != null;
}

/// Un [id] vacío significa que todavía no se ha guardado.
@freezed
abstract class Experience with _$Experience {
  const Experience._();

  const factory Experience({
    @Default('') String id,
    required String company,
    required String role,
    required DateTime startDate,
    DateTime? endDate,
    @Default([]) List<String> achievements,
    @Default([]) List<String> technologies,
  }) = _Experience;

  factory Experience.fromJson(Map<String, dynamic> json) =>
      _$ExperienceFromJson(json);

  bool get isCurrent => endDate == null;
}

@freezed
abstract class Project with _$Project {
  const factory Project({
    @Default('') String id,
    required String name,
    @Default('') String description,
    String? url,
    @Default([]) List<String> technologies,
  }) = _Project;

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);
}

@freezed
abstract class Education with _$Education {
  const factory Education({
    @Default('') String id,
    required String institution,
    @Default('') String degree,
    DateTime? startDate,
    DateTime? endDate,
  }) = _Education;

  factory Education.fromJson(Map<String, dynamic> json) =>
      _$EducationFromJson(json);
}

enum SkillCategory { language, framework, tool, other }

@freezed
abstract class Skill with _$Skill {
  const factory Skill({
    @Default('') String id,
    required String name,
    @JsonKey(unknownEnumValue: SkillCategory.other)
    @Default(SkillCategory.other)
    SkillCategory category,
    int? years,
  }) = _Skill;

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);
}

/// Primero los trabajos actuales, luego por fecha de inicio descendente.
List<Experience> sortExperiences(Iterable<Experience> items) =>
    [...items]..sort((a, b) {
      if (a.isCurrent != b.isCurrent) return a.isCurrent ? -1 : 1;
      return b.startDate.compareTo(a.startDate);
    });

/// Lo más reciente primero; sin fecha de fin cuenta como en curso.
List<Education> sortEducation(Iterable<Education> items) =>
    [...items]..sort((a, b) {
      final aEnd = a.endDate ?? DateTime(9999);
      final bEnd = b.endDate ?? DateTime(9999);
      return bEnd.compareTo(aEnd);
    });

/// Todo lo que la app sabe del usuario; es la única fuente para la HV.
@freezed
abstract class ProfileData with _$ProfileData {
  const factory ProfileData({
    @Default(Profile()) Profile profile,
    @Default([]) List<Experience> experiences,
    @Default([]) List<Project> projects,
    @Default([]) List<Skill> skills,
    @Default([]) List<Education> education,
  }) = _ProfileData;
}
