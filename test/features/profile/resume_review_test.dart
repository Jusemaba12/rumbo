import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/features/profile/domain/profile.dart';
import 'package:rumbo/features/profile/domain/resume_review.dart';

final _now = DateTime(2026, 10, 16);

const _bullets = [
  'Reduje el tiempo de arranque de la app de pagos un 40 % con carga diferida',
  'Lancé 3 aplicaciones en Google Play y App Store con más de 20.000 usuarios',
  'Automaticé las pruebas de integración y bajé los errores en producción un 35 %',
  'Diseñé la arquitectura limpia de 4 módulos con Riverpod y GoRouter',
  'Integré 6 servicios REST y WebSockets con reintentos y caché sin conexión',
];

Experience _experience(
  List<String> achievements, {
  String id = 'e1',
  DateTime? start,
  DateTime? end,
  List<String> technologies = const ['Riverpod'],
}) => Experience(
  id: id,
  company: 'GSE',
  role: 'Flutter Developer',
  startDate: start ?? DateTime(2024, 9),
  endDate: end,
  achievements: achievements,
  technologies: technologies,
);

ProfileData _complete({
  List<Experience>? experiences,
  Profile Function(Profile profile)? profile,
}) {
  const base = Profile(
    fullName: 'Juan Manzano',
    headline: 'Flutter Developer',
    summary:
        'Desarrollador móvil con 3 años de experiencia creando aplicaciones '
        'con Flutter y Dart para Android e iOS. Trabajo con arquitectura '
        'limpia, Riverpod y pruebas automatizadas, y he publicado apps de '
        'pagos y logística con miles de usuarios activos en Colombia.',
    location: 'Bogotá, Colombia',
    email: 'juan@correo.com',
    phone: '+57 320 000 0000',
    links: {'linkedin': 'https://linkedin.com/in/juan'},
  );
  return ProfileData(
    profile: profile == null ? base : profile(base),
    experiences: experiences ?? [_experience(_bullets)],
    skills: [
      for (final name in ['Dart', 'Flutter', 'Riverpod', 'Git', 'Firebase'])
        Skill(name: name),
    ],
    education: const [Education(institution: 'UFPS', degree: 'Ingeniería')],
  );
}

ResumeReview _review(ProfileData data, {List<String> roles = const []}) =>
    reviewResume(data, targetRoles: roles, now: _now);

List<ReviewIssueKind> _kinds(ResumeReview review) =>
    review.issues.map((issue) => issue.kind).toList();

void main() {
  test('las categorías suman 100', () {
    expect(ReviewCategory.values.fold(0, (sum, c) => sum + c.points), 100);
  });

  test('una HV completa saca 100 en todas las categorías', () {
    final review = _review(_complete(), roles: ['Flutter Developer']);
    expect(_kinds(review), isEmpty);
    expect(review.score, 100);
    for (final category in ReviewCategory.values) {
      expect(review.categories[category], category.points);
    }
  });

  test('un perfil vacío pierde puntos sin bajar de 0 por categoría', () {
    final review = _review(const ProfileData());
    expect(
      _kinds(review),
      containsAll([
        ReviewIssueKind.noName,
        ReviewIssueKind.noEmail,
        ReviewIssueKind.noPhone,
        ReviewIssueKind.noExperience,
        ReviewIssueKind.noSummary,
        ReviewIssueKind.fewSkills,
        ReviewIssueKind.noLink,
        ReviewIssueKind.noEducation,
      ]),
    );
    expect(review.issues.first.severity, ReviewSeverity.high);
    // Contacto: 20 - (8 + 8 + 5 + 2 + 3) se queda en 0.
    expect(review.categories[ReviewCategory.contact], 0);
    expect(review.score, lessThan(60));
  });

  test('contacto: correo, indicativo, ubicación y enlaces', () {
    final review = _review(
      _complete(
        profile: (p) => p.copyWith(
          email: 'juan@correo',
          phone: '320 000 0000',
          location: '',
          links: {'linkedin': 'linkedin.com/in/juan'},
        ),
      ),
    );
    expect(_kinds(review), [
      ReviewIssueKind.invalidEmail,
      ReviewIssueKind.phoneNoCountryCode,
      ReviewIssueKind.noLocation,
      ReviewIssueKind.invalidLink,
    ]);
    expect(review.categories[ReviewCategory.contact], 20 - 6 - 2 - 2 - 2);
  });

  test('fechas: fin antes de inicio, futuras, huecos y varios actuales', () {
    final review = _review(
      _complete(
        experiences: [
          _experience(
            _bullets,
            id: 'a',
            start: DateTime(2020, 1),
            end: DateTime(2021, 1),
          ),
          // Diez meses después del anterior.
          _experience(
            _bullets.reversed.toList(),
            id: 'b',
            start: DateTime(2021, 11),
          ),
          _experience(
            ['Lideré 2 proyectos con 5 personas'],
            id: 'c',
            start: DateTime(2027, 3),
          ),
          _experience(
            ['Migré 3 apps a Flutter 3'],
            id: 'd',
            start: DateTime(2023, 5),
            end: DateTime(2023, 1),
          ),
        ],
      ),
    );
    final kinds = _kinds(review);
    expect(kinds, contains(ReviewIssueKind.endBeforeStart));
    expect(kinds, contains(ReviewIssueKind.futureDate));
    expect(kinds, contains(ReviewIssueKind.severalCurrent));
    final gap = review.issues.firstWhere(
      (i) => i.kind == ReviewIssueKind.dateGap,
    );
    expect(gap.experience?.id, 'b');
    expect(gap.count, 10);
  });

  test('logros sin cifras, como tareas, en primera persona o largos', () {
    final long = 'Desarrollé la nueva pantalla de pagos con Flutter ' * 6;
    final review = _review(
      _complete(
        experiences: [
          _experience([
            'Responsable de mantener la app',
            'Mi tarea era revisar el código',
            long,
          ]),
        ],
      ),
    );
    final kinds = _kinds(review);
    expect(
      kinds,
      containsAll([
        ReviewIssueKind.fewNumbers,
        ReviewIssueKind.weakStart,
        ReviewIssueKind.firstPerson,
        ReviewIssueKind.longBullets,
      ]),
    );
    final fewNumbers = review.issues.firstWhere(
      (i) => i.kind == ReviewIssueKind.fewNumbers,
    );
    expect(fewNumbers.count, 3);
    expect(fewNumbers.experience?.id, 'e1');
  });

  test('experiencia sin logros', () {
    final review = _review(_complete(experiences: [_experience([])]));
    expect(_kinds(review), contains(ReviewIssueKind.noAchievements));
  });

  test('logros repetidos y frases vacías', () {
    final review = _review(
      _complete(
        experiences: [
          _experience(_bullets, id: 'a'),
          _experience(
            [_bullets.first, 'Soy proactivo y con trabajo en equipo'],
            id: 'b',
            start: DateTime(2022, 1),
            end: DateTime(2024, 8),
          ),
        ],
      ),
    );
    final duplicates = review.issues.firstWhere(
      (i) => i.kind == ReviewIssueKind.duplicates,
    );
    expect(duplicates.count, 1);
    final buzzwords = review.issues.firstWhere(
      (i) => i.kind == ReviewIssueKind.buzzwords,
    );
    expect(buzzwords.detail, 'proactivo, trabajo en equipo');
  });

  test('coherencia: tecnologías, titular y perfil', () {
    final review = _review(
      _complete(
        experiences: [
          _experience(_bullets, technologies: ['Riverpod', 'Bloc', 'GraphQL']),
        ],
        profile: (p) => p.copyWith(
          headline: 'Ingeniero de sistemas',
          summary:
              'Profesional con experiencia creando productos digitales para '
              'empresas de pagos y logística, con foco en calidad, buenas '
              'prácticas y comunicación con los equipos de negocio.',
        ),
      ),
      roles: ['Flutter Developer', 'Mobile Developer'],
    );
    final kinds = _kinds(review);
    expect(
      kinds,
      containsAll([
        ReviewIssueKind.techNotInSkills,
        ReviewIssueKind.headlineNoRole,
        ReviewIssueKind.summaryNoTech,
        ReviewIssueKind.summaryNoYears,
      ]),
    );
    final tech = review.issues.firstWhere(
      (i) => i.kind == ReviewIssueKind.techNotInSkills,
    );
    expect(tech.detail, 'Bloc, GraphQL');
    expect(tech.count, 2);
    // Sin cargos objetivo no se exige el cargo en el titular.
    expect(
      _kinds(_review(_complete(profile: (p) => p.copyWith(headline: 'Dev')))),
      isNot(contains(ReviewIssueKind.headlineNoRole)),
    );
  });

  test('formato: símbolos, mayúsculas, idiomas y longitud', () {
    final review = _review(
      _complete(
        experiences: [
          _experience([
            '★ Reduje el arranque un 40 % con carga diferida',
            'LANCÉ TRES APLICACIONES CON MÁS DE 20.000 USUARIOS',
            'Built the payments module for the mobile app in 2 months',
            'Led the migration of the app to the new design system in 3 sprints',
          ]),
        ],
      ),
    );
    final kinds = _kinds(review);
    expect(
      kinds,
      containsAll([
        ReviewIssueKind.specialCharacters,
        ReviewIssueKind.allCaps,
        ReviewIssueKind.mixedLanguages,
      ]),
    );
    final short = _review(
      _complete(
        experiences: [
          _experience(['Lancé 2 apps', 'Reduje errores un 30 %']),
        ],
        profile: (p) => p.copyWith(summary: ''),
      ),
    );
    expect(_kinds(short), contains(ReviewIssueKind.tooShort));
  });

  test('perfil profesional corto o largo', () {
    ProfileData withSummary(String summary) =>
        _complete(profile: (p) => p.copyWith(summary: summary));
    expect(
      _kinds(_review(withSummary('Flutter dev con 3 años.'))),
      contains(ReviewIssueKind.shortSummary),
    );
    expect(
      _kinds(_review(withSummary('Flutter, 3 años. ${'a' * 800}'))),
      contains(ReviewIssueKind.longSummary),
    );
  });

  group('palabras clave', () {
    final corpus = resumeCorpus(_complete());

    test('encuentra términos de cualquier parte de la HV', () {
      expect(resumeHasKeyword(corpus, 'Riverpod'), isTrue);
      expect(resumeHasKeyword(corpus, 'flutter'), isTrue);
      expect(resumeHasKeyword(corpus, 'Firebase'), isTrue);
    });

    test('solo palabras completas y sin importar tildes', () {
      final text = resumeCorpus(
        ProfileData(
          profile: const Profile(summary: 'Uso Google Play y gestión ágil'),
        ),
      );
      expect(resumeHasKeyword(text, 'Go'), isFalse);
      expect(resumeHasKeyword(text, 'Google Play'), isTrue);
      expect(resumeHasKeyword(text, 'Gestion'), isTrue);
      expect(resumeHasKeyword(text, 'CI/CD'), isFalse);
    });

    test('plurales y otro orden de las palabras', () {
      final text = resumeCorpus(
        ProfileData(
          profile: const Profile(summary: 'Integración de APIs REST y tests'),
        ),
      );
      expect(resumeHasKeyword(text, 'REST API'), isTrue);
      expect(resumeHasKeyword(text, 'API'), isTrue);
      expect(resumeHasKeyword(text, 'test'), isTrue);
      expect(resumeHasKeyword(text, 'GraphQL API'), isFalse);
    });
  });
}
