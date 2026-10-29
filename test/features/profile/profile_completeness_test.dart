import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/features/profile/domain/profile.dart';
import 'package:rumbo/features/profile/domain/profile_completeness.dart';

void main() {
  final experience = Experience(
    id: '1',
    company: 'Acme',
    role: 'Flutter Developer',
    startDate: DateTime(2022),
    achievements: const ['Reduje el arranque un 40 %'],
  );
  final complete = ProfileData(
    profile: const Profile(
      fullName: 'Ana Pérez',
      headline: 'Desarrolladora Flutter',
      summary: 'Cinco años creando apps.',
      links: {ProfileLinks.github: 'https://github.com/ana'},
    ),
    experiences: [experience],
    skills: [
      for (var i = 0; i < minSkillsForCompleteProfile; i++)
        Skill(id: '$i', name: 'Skill $i'),
    ],
  );

  test('un perfil vacío está al 0 % y lo primero que pide es el nombre', () {
    const empty = ProfileData();
    expect(profileCompletenessPercent(empty), 0);
    expect(profileGaps(empty).first, ProfileGap.name);
    expect(profileGaps(empty), isNot(contains(ProfileGap.achievements)));
  });

  test('un perfil completo está al 100 % y no tiene huecos', () {
    expect(profileGaps(complete), isEmpty);
    expect(profileCompletenessPercent(complete), 100);
  });

  test('una experiencia sin logros se señala como hueco', () {
    final data = complete.copyWith(
      experiences: [
        experience,
        experience.copyWith(id: '2', achievements: []),
      ],
    );
    expect(profileGaps(data), [ProfileGap.achievements]);
    expect(profileCompletenessPercent(data), 86);
  });

  test('con menos habilidades de las mínimas falta ese punto', () {
    final data = complete.copyWith(skills: complete.skills.sublist(1));
    expect(profileGaps(data), [ProfileGap.skills]);
  });

  test('enlaces vacíos no cuentan como enlace', () {
    final data = complete.copyWith(
      profile: complete.profile.copyWith(links: {ProfileLinks.github: ' '}),
    );
    expect(profileGaps(data), [ProfileGap.link]);
  });
}
