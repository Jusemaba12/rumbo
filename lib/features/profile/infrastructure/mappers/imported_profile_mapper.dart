import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/infrastructure/mappers/profile_row_mapper.dart';

/// Convierte la respuesta de `import-resume` en datos del perfil.
ProfileData importedProfileFromJson(Map<String, dynamic> json) {
  List<Map<String, dynamic>> list(String key) => <Map<String, dynamic>>[
    for (final dynamic item in json[key] as List<dynamic>? ?? const <dynamic>[])
      item as Map<String, dynamic>,
  ];
  final Map<String, dynamic> profileJson =
      json['profile'] as Map<String, dynamic>;
  final Map<String, String> links =
      (profileJson['links'] as Map<dynamic, dynamic>? ??
              const <dynamic, dynamic>{})
          .cast<String, String>()
        ..removeWhere((String key, String url) => url.trim().isEmpty);
  return ProfileData(
    profile: Profile.fromJson(<String, dynamic>{
      ...profileJson,
      'links': links,
    }),
    experiences: sortExperiences(list('experiences').map(experienceFromRow)),
    projects: list('projects').map(Project.fromJson).toList(),
    skills: list('skills').map(Skill.fromJson).toList(),
    education: sortEducation(list('education').map(Education.fromJson)),
  );
}
