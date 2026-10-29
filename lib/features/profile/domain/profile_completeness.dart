import 'profile.dart';

/// Lo que le falta al perfil para generar una buena HV, por prioridad.
enum ProfileGap {
  name,
  headline,
  experience,
  achievements,
  skills,
  summary,
  link,
}

const minSkillsForCompleteProfile = 5;

List<ProfileGap> profileGaps(ProfileData data) {
  final profile = data.profile;
  return [
    if (profile.fullName.trim().isEmpty) ProfileGap.name,
    if (profile.headline.trim().isEmpty) ProfileGap.headline,
    if (data.experiences.isEmpty) ProfileGap.experience,
    // Sin logros la IA no tiene con qué adaptar la HV.
    if (data.experiences.isNotEmpty &&
        data.experiences.any((e) => e.achievements.isEmpty))
      ProfileGap.achievements,
    if (data.skills.length < minSkillsForCompleteProfile) ProfileGap.skills,
    if (profile.summary.trim().isEmpty) ProfileGap.summary,
    if (profile.links.values.every((url) => url.trim().isEmpty))
      ProfileGap.link,
  ];
}

int profileCompletenessPercent(ProfileData data) {
  final total = ProfileGap.values.length;
  // Sin experiencia tampoco hay logros, aunque solo se liste un hueco.
  final missing = profileGaps(data).length + (data.experiences.isEmpty ? 1 : 0);
  return ((total - missing) * 100 / total).round();
}
