import 'package:flutter_test/flutter_test.dart';
import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/domain/services/resume_review.dart';

final DateTime _now = DateTime(2026, 10, 16);

const List<String> _bullets = <String>[
  'Reduje el tiempo de arranque de la app de pagos un 40 % con carga diferida',
  'Lancé 3 aplicaciones en Google Play y App Store con más de 20.000 usuarios',
  'Automaticé las pruebas de integración y bajé los errores en producción '
      'un 35 %',
  'Diseñé la arquitectura limpia de 4 módulos con Riverpod y GoRouter',
  'Integré 6 servicios REST y WebSockets con reintentos y caché sin conexión',
];

Experience _experience(
  List<String> achievements, {
  String id = 'e1',
  DateTime? start,
  DateTime? end,
  List<String> technologies = const <String>['Riverpod'],
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
  const Profile base = Profile(
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
    links: <String, String>{'linkedin': 'https://linkedin.com/in/juan'},
  );
  return ProfileData(
    profile: profile == null ? base : profile(base),
    experiences: experiences ?? <Experience>[_experience(_bullets)],
    skills: <Skill>[
      for (final String name in <String>[
        'Dart',
        'Flutter',
        'Riverpod',
        'Git',
        'Firebase',
      ])
        Skill(name: name),
    ],
    education: const <Education>[
      Education(institution: 'UFPS', degree: 'Ingeniería'),
    ],
  );
}

ResumeReview _review(
  ProfileData data, {
  List<String> roles = const <String>[],
}) => reviewResume(data, targetRoles: roles, now: _now);

List<ReviewIssueKind> _kinds(ResumeReview review) =>
    review.issues.map((ReviewIssue issue) => issue.kind).toList();

void main() {
  test('las categorías suman 100', () {
    expect(
      ReviewCategory.values.fold(
        0,
        (int sum, ReviewCategory c) => sum + c.points,
      ),
      100,
    );
  });

  test('una HV completa saca 100 en todas las categorías', () {
    final ResumeReview review = _review(
      _complete(),
      roles: <String>['Flutter Developer'],
    );
    expect(_kinds(review), isEmpty);
    expect(review.score, 100);
    for (final ReviewCategory category in ReviewCategory.values) {
      expect(review.categories[category], category.points);
    }
  });

  test('un perfil vacío pierde puntos sin bajar de 0 por categoría', () {
    final ResumeReview review = _review(const ProfileData());
    expect(
      _kinds(review),
      containsAll(<dynamic>[
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
    final ResumeReview review = _review(
      _complete(
        profile: (Profile p) => p.copyWith(
          email: 'juan@correo',
          phone: '320 000 0000',
          location: '',
          links: <String, String>{'linkedin': 'linkedin.com/in/juan'},
        ),
      ),
    );
    expect(_kinds(review), <ReviewIssueKind>[
      ReviewIssueKind.invalidEmail,
      ReviewIssueKind.phoneNoCountryCode,
      ReviewIssueKind.noLocation,
      ReviewIssueKind.invalidLink,
    ]);
    expect(review.categories[ReviewCategory.contact], 20 - 6 - 2 - 2 - 2);
  });

  test('fechas: fin antes de inicio, futuras, huecos y varios actuales', () {
    final ResumeReview review = _review(
      _complete(
        experiences: <Experience>[
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
            <String>['Lideré 2 proyectos con 5 personas'],
            id: 'c',
            start: DateTime(2027, 3),
          ),
          _experience(
            <String>['Migré 3 apps a Flutter 3'],
            id: 'd',
            start: DateTime(2023, 5),
            end: DateTime(2023, 1),
          ),
        ],
      ),
    );
    final List<ReviewIssueKind> kinds = _kinds(review);
    expect(kinds, contains(ReviewIssueKind.endBeforeStart));
    expect(kinds, contains(ReviewIssueKind.futureDate));
    expect(kinds, contains(ReviewIssueKind.severalCurrent));
    final ReviewIssue gap = review.issues.firstWhere(
      (ReviewIssue i) => i.kind == ReviewIssueKind.dateGap,
    );
    expect(gap.experience?.id, 'b');
    expect(gap.count, 10);
  });

  test('logros sin cifras, como tareas, en primera persona o largos', () {
    final String long =
        'Desarrollé la nueva pantalla de pagos con Flutter ' * 6;
    final ResumeReview review = _review(
      _complete(
        experiences: <Experience>[
          _experience(<String>[
            'Responsable de mantener la app',
            'Mi tarea era revisar el código',
            long,
          ]),
        ],
      ),
    );
    final List<ReviewIssueKind> kinds = _kinds(review);
    expect(
      kinds,
      containsAll(<dynamic>[
        ReviewIssueKind.fewNumbers,
        ReviewIssueKind.weakStart,
        ReviewIssueKind.firstPerson,
        ReviewIssueKind.longBullets,
      ]),
    );
    final ReviewIssue fewNumbers = review.issues.firstWhere(
      (ReviewIssue i) => i.kind == ReviewIssueKind.fewNumbers,
    );
    expect(fewNumbers.count, 3);
    expect(fewNumbers.experience?.id, 'e1');
  });

  test('experiencia sin logros', () {
    final ResumeReview review = _review(
      _complete(experiences: <Experience>[_experience(<String>[])]),
    );
    expect(_kinds(review), contains(ReviewIssueKind.noAchievements));
  });

  test('logros repetidos y frases vacías', () {
    final ResumeReview review = _review(
      _complete(
        experiences: <Experience>[
          _experience(_bullets, id: 'a'),
          _experience(
            <String>[_bullets.first, 'Soy proactivo y con trabajo en equipo'],
            id: 'b',
            start: DateTime(2022, 1),
            end: DateTime(2024, 8),
          ),
        ],
      ),
    );
    final ReviewIssue duplicates = review.issues.firstWhere(
      (ReviewIssue i) => i.kind == ReviewIssueKind.duplicates,
    );
    expect(duplicates.count, 1);
    final ReviewIssue buzzwords = review.issues.firstWhere(
      (ReviewIssue i) => i.kind == ReviewIssueKind.buzzwords,
    );
    expect(buzzwords.detail, 'proactivo, trabajo en equipo');
  });

  test('coherencia: tecnologías, titular y perfil', () {
    final ResumeReview review = _review(
      _complete(
        experiences: <Experience>[
          _experience(
            _bullets,
            technologies: <String>['Riverpod', 'Bloc', 'GraphQL'],
          ),
        ],
        profile: (Profile p) => p.copyWith(
          headline: 'Ingeniero de sistemas',
          summary:
              'Profesional con experiencia creando productos digitales para '
              'empresas de pagos y logística, con foco en calidad, buenas '
              'prácticas y comunicación con los equipos de negocio.',
        ),
      ),
      roles: <String>['Flutter Developer', 'Mobile Developer'],
    );
    final List<ReviewIssueKind> kinds = _kinds(review);
    expect(
      kinds,
      containsAll(<dynamic>[
        ReviewIssueKind.techNotInSkills,
        ReviewIssueKind.headlineNoRole,
        ReviewIssueKind.summaryNoTech,
        ReviewIssueKind.summaryNoYears,
      ]),
    );
    final ReviewIssue tech = review.issues.firstWhere(
      (ReviewIssue i) => i.kind == ReviewIssueKind.techNotInSkills,
    );
    expect(tech.detail, 'Bloc, GraphQL');
    expect(tech.count, 2);
    // Sin cargos objetivo no se exige el cargo en el titular.
    expect(
      _kinds(
        _review(_complete(profile: (Profile p) => p.copyWith(headline: 'Dev'))),
      ),
      isNot(contains(ReviewIssueKind.headlineNoRole)),
    );
  });

  test('formato: símbolos, mayúsculas, idiomas y longitud', () {
    final ResumeReview review = _review(
      _complete(
        experiences: <Experience>[
          _experience(<String>[
            '★ Reduje el arranque un 40 % con carga diferida',
            'LANCÉ TRES APLICACIONES CON MÁS DE 20.000 USUARIOS',
            'Built the payments module for the mobile app in 2 months',
            'Led the migration of the app to the new design system '
                'in 3 sprints',
          ]),
        ],
      ),
    );
    final List<ReviewIssueKind> kinds = _kinds(review);
    expect(
      kinds,
      containsAll(<dynamic>[
        ReviewIssueKind.specialCharacters,
        ReviewIssueKind.allCaps,
        ReviewIssueKind.mixedLanguages,
      ]),
    );
    final ResumeReview short = _review(
      _complete(
        experiences: <Experience>[
          _experience(<String>['Lancé 2 apps', 'Reduje errores un 30 %']),
        ],
        profile: (Profile p) => p.copyWith(summary: ''),
      ),
    );
    expect(_kinds(short), contains(ReviewIssueKind.tooShort));
  });

  test('perfil profesional corto o largo', () {
    ProfileData withSummary(String summary) =>
        _complete(profile: (Profile p) => p.copyWith(summary: summary));
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
    final String corpus = resumeCorpus(_complete());

    test('encuentra términos de cualquier parte de la HV', () {
      expect(resumeHasKeyword(corpus: corpus, keyword: 'Riverpod'), isTrue);
      expect(resumeHasKeyword(corpus: corpus, keyword: 'flutter'), isTrue);
      expect(resumeHasKeyword(corpus: corpus, keyword: 'Firebase'), isTrue);
    });

    test('solo palabras completas y sin importar tildes', () {
      final String text = resumeCorpus(
        ProfileData(
          profile: const Profile(summary: 'Uso Google Play y gestión ágil'),
        ),
      );
      expect(resumeHasKeyword(corpus: text, keyword: 'Go'), isFalse);
      expect(resumeHasKeyword(corpus: text, keyword: 'Google Play'), isTrue);
      expect(resumeHasKeyword(corpus: text, keyword: 'Gestion'), isTrue);
      expect(resumeHasKeyword(corpus: text, keyword: 'CI/CD'), isFalse);
    });

    test('plurales y otro orden de las palabras', () {
      final String text = resumeCorpus(
        ProfileData(
          profile: const Profile(summary: 'Integración de APIs REST y tests'),
        ),
      );
      expect(resumeHasKeyword(corpus: text, keyword: 'REST API'), isTrue);
      expect(resumeHasKeyword(corpus: text, keyword: 'API'), isTrue);
      expect(resumeHasKeyword(corpus: text, keyword: 'test'), isTrue);
      expect(resumeHasKeyword(corpus: text, keyword: 'GraphQL API'), isFalse);
    });
  });
}
