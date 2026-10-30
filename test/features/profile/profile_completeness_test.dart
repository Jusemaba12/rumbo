import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/domain/services/profile_completeness.dart';

void main() {
  final Experience experience = Experience(
    id: '1',
    company: 'Acme',
    role: 'Flutter Developer',
    startDate: DateTime(2022),
    achievements: const <String>['Reduje el arranque un 40 %'],
  );
  final ProfileData complete = ProfileData(
    profile: const Profile(
      fullName: 'Ana Pérez',
      headline: 'Desarrolladora Flutter',
      summary: 'Cinco años creando apps.',
      links: <String, String>{ProfileLinks.github: 'https://github.com/ana'},
    ),
    experiences: <Experience>[experience],
    skills: <Skill>[
      for (int i = 0; i < minSkillsForCompleteProfile; i++)
        Skill(id: '$i', name: 'Skill $i'),
    ],
  );

  test('un perfil vacío está al 0 % y lo primero que pide es el nombre', () {
    const ProfileData empty = ProfileData();
    expect(profileCompletenessPercent(empty), 0);
    expect(profileGaps(empty).first, ProfileGap.name);
    expect(profileGaps(empty), isNot(contains(ProfileGap.achievements)));
  });

  test('un perfil completo está al 100 % y no tiene huecos', () {
    expect(profileGaps(complete), isEmpty);
    expect(profileCompletenessPercent(complete), 100);
  });

  test('una experiencia sin logros se señala como hueco', () {
    final ProfileData data = complete.copyWith(
      experiences: <Experience>[
        experience,
        experience.copyWith(id: '2', achievements: <String>[]),
      ],
    );
    expect(profileGaps(data), <ProfileGap>[ProfileGap.achievements]);
    expect(profileCompletenessPercent(data), 86);
  });

  test('con menos habilidades de las mínimas falta ese punto', () {
    final ProfileData data = complete.copyWith(
      skills: complete.skills.sublist(1),
    );
    expect(profileGaps(data), <ProfileGap>[ProfileGap.skills]);
  });

  test('enlaces vacíos no cuentan como enlace', () {
    final ProfileData data = complete.copyWith(
      profile: complete.profile.copyWith(
        links: <String, String>{ProfileLinks.github: ' '},
      ),
    );
    expect(profileGaps(data), <ProfileGap>[ProfileGap.link]);
  });
}
