import 'package:freezed_annotation/freezed_annotation.dart';

import 'profile.dart';

part 'profile_import.freezed.dart';

/// Lo que se añadirá al perfil al importar una HV.
///
/// Nunca sobrescribe lo que el usuario ya escribió: solo rellena campos
/// vacíos y añade elementos que no existen todavía.
@freezed
abstract class ProfileImport with _$ProfileImport {
  const ProfileImport._();

  const factory ProfileImport({
    /// Perfil resultante tras rellenar los campos vacíos.
    required Profile profile,
    required Set<ProfileField> filledFields,
    required List<Experience> experiences,
    required List<Project> projects,
    required List<Skill> skills,
    required List<Education> education,
  }) = _ProfileImport;

  bool get isEmpty =>
      filledFields.isEmpty &&
      experiences.isEmpty &&
      projects.isEmpty &&
      skills.isEmpty &&
      education.isEmpty;
}

enum ProfileField { fullName, headline, summary, location, email, phone, links }

ProfileImport planProfileImport(ProfileData current, ProfileData imported) {
  final filled = <ProfileField>{};
  String fill(ProfileField field, String existing, String incoming) {
    if (existing.trim().isNotEmpty || incoming.trim().isEmpty) return existing;
    filled.add(field);
    return incoming.trim();
  }

  final now = current.profile;
  final next = imported.profile;
  final links = {...now.links};
  next.links.forEach((key, url) {
    if (url.trim().isNotEmpty && (links[key]?.trim().isEmpty ?? true)) {
      links[key] = url.trim();
      filled.add(ProfileField.links);
    }
  });
  final profile = now.copyWith(
    fullName: fill(ProfileField.fullName, now.fullName, next.fullName),
    headline: fill(ProfileField.headline, now.headline, next.headline),
    summary: fill(ProfileField.summary, now.summary, next.summary),
    location: fill(ProfileField.location, now.location, next.location),
    email: fill(ProfileField.email, now.email, next.email),
    phone: fill(ProfileField.phone, now.phone, next.phone),
    links: links,
  );

  return ProfileImport(
    profile: profile,
    filledFields: filled,
    experiences: _newItems(
      current.experiences,
      imported.experiences,
      (e) => '${_key(e.company)}|${_key(e.role)}',
    ),
    projects: _newItems(
      current.projects,
      imported.projects,
      (p) => _key(p.name),
    ),
    skills: _newItems(current.skills, imported.skills, (s) => _key(s.name)),
    education: _newItems(
      current.education,
      imported.education,
      (e) => '${_key(e.institution)}|${_key(e.degree)}',
    ),
  );
}

String _key(String text) => text.trim().toLowerCase();

/// Elementos de [incoming] cuya clave no está en [existing] ni repetida.
List<T> _newItems<T>(
  List<T> existing,
  List<T> incoming,
  String Function(T item) keyOf,
) {
  final seen = existing.map(keyOf).toSet();
  return [
    for (final item in incoming)
      if (keyOf(item).replaceAll('|', '').isNotEmpty && seen.add(keyOf(item)))
        item,
  ];
}
