import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/domain/services/resume_review.dart';

part 'keyword_analysis.freezed.dart';

/// Variantes habituales que significan lo mismo para un ATS. Se suman a las
/// que da la IA para cada palabra clave.
const List<List<String>> _synonymGroups = <List<String>>[
  <String>['REST API', 'RESTful', 'APIs REST', 'API REST', 'REST'],
  <String>['CI/CD', 'integración continua', 'continuous integration'],
  <String>['JavaScript', 'JS'],
  <String>['TypeScript', 'TS'],
  <String>[
    'Unit testing',
    'pruebas unitarias',
    'unit tests',
    'tests unitarios',
  ],
  <String>[
    'Integration testing',
    'pruebas de integración',
    'integration tests',
  ],
  <String>['Widget testing', 'widget tests', 'pruebas de widgets'],
  <String>['Testing', 'pruebas', 'tests', 'QA'],
  <String>['State management', 'gestión de estado', 'manejo de estado'],
  <String>['Clean Architecture', 'arquitectura limpia'],
  <String>['Agile', 'ágil', 'metodologías ágiles', 'Scrum', 'Kanban'],
  <String>['Git', 'GitHub', 'GitLab', 'Bitbucket'],
  <String>['Google Play', 'Play Store', 'Google Play Store'],
  <String>['App Store', 'Apple App Store', 'App Store Connect'],
  <String>['Native Android', 'Android nativo', 'Kotlin', 'Java Android'],
  <String>['Native iOS', 'iOS nativo', 'Swift', 'SwiftUI'],
  <String>['Firebase', 'Firestore', 'Firebase Auth', 'Crashlytics'],
  <String>['Bloc', 'flutter_bloc', 'Cubit'],
  <String>['ChangeNotifier'],
  <String>['GraphQL', 'Apollo'],
  <String>['WebSockets', 'WebSocket', 'sockets'],
  <String>['SQL', 'PostgreSQL', 'MySQL', 'SQLite'],
  <String>['UI/UX', 'UX', 'diseño de interfaces', 'user experience'],
  <String>['Performance', 'rendimiento', 'optimización'],
  <String>['Accessibility', 'accesibilidad', 'a11y'],
  <String>['English', 'inglés'],
];

/// Tecnologías y prácticas que se buscan en las ofertas para medir la
/// cobertura de la HV (se suman las habilidades del usuario y las palabras
/// clave de sus cargos). Sin palabras comunes en inglés que confundirían
/// («Go», «Provider», «SOLID», «Performance»).
const List<String> techCatalog = <String>[
  'Flutter',
  'Dart',
  'Kotlin',
  'Swift',
  'SwiftUI',
  'Java',
  'JavaScript',
  'TypeScript',
  'React',
  'React Native',
  'Angular',
  'Vue',
  'Node.js',
  'Python',
  'C#',
  '.NET',
  'PHP',
  'Ruby',
  'Rust',
  'Riverpod',
  'Bloc',
  'GetX',
  'MobX',
  'Redux',
  'REST API',
  'GraphQL',
  'gRPC',
  'WebSockets',
  'Firebase',
  'Supabase',
  'AWS',
  'GCP',
  'Azure',
  'Docker',
  'Kubernetes',
  'CI/CD',
  'Fastlane',
  'Codemagic',
  'Git',
  'SQL',
  'NoSQL',
  'MongoDB',
  'Redis',
  'Hive',
  'Clean Architecture',
  'MVVM',
  'TDD',
  'Unit testing',
  'Integration testing',
  'Widget testing',
  'Agile',
  'Microservices',
  'App Store',
  'Google Play',
  'Platform Channels',
  'Native Android',
  'Native iOS',
  'UI/UX',
  'Figma',
  'Accessibility',
  'Push notifications',
  'English',
  'Jira',
];

/// Todas las formas de una palabra clave: ella, sus variantes de la IA y las
/// del diccionario si pertenece a algún grupo.
List<String> keywordTerms(
  String keyword, {
  List<String> aliases = const <String>[],
}) {
  final Set<String> terms = <String>{keyword, ...aliases};
  for (final List<String> group in _synonymGroups) {
    if (group.any(
      (String term) =>
          terms.any((String t) => t.toLowerCase() == term.toLowerCase()),
    )) {
      terms.addAll(group);
    }
  }
  return terms.where((String t) => t.trim().isNotEmpty).toList();
}

/// Dónde aparece una palabra clave en la HV. Los ATS la valoran más dentro
/// de la experiencia (logros) que en una lista de habilidades.
@freezed
abstract class KeywordPresence with _$KeywordPresence {
  const KeywordPresence._();

  const factory KeywordPresence({
    @Default(false) bool inExperience,
    @Default(false) bool inSummary,
    @Default(false) bool inSkills,
    @Default(false) bool inProjects,
  }) = _KeywordPresence;

  bool get found => inExperience || inSummary || inSkills || inProjects;

  /// Solo en la lista de habilidades: conviene mencionarla en un logro.
  bool get onlyInSkills =>
      inSkills && !inExperience && !inSummary && !inProjects;
}

/// Textos de la HV por sección, ya normalizados para buscar.
class ResumeSections {
  ResumeSections(ProfileData data)
    : experience = _corpus(<String>[
        for (final Experience e in data.experiences) ...<String>[
          e.role,
          ...e.achievements,
          ...e.technologies,
        ],
      ]),
      summary = _corpus(<String>[data.profile.headline, data.profile.summary]),
      skills = _corpus(<String>[for (final Skill s in data.skills) s.name]),
      projects = _corpus(<String>[
        for (final Project p in data.projects) ...<String>[
          p.name,
          p.description,
          ...p.technologies,
        ],
      ]);

  final String experience;
  final String summary;
  final String skills;
  final String projects;

  static String _corpus(List<String> texts) =>
      resumeCorpus(ProfileData(profile: Profile(summary: texts.join('\n'))));

  KeywordPresence presenceOf(List<String> terms) {
    bool any(String corpus) => terms.any(
      (String term) => resumeHasKeyword(corpus: corpus, keyword: term),
    );
    return KeywordPresence(
      inExperience: any(experience),
      inSummary: any(summary),
      inSkills: any(skills),
      inProjects: any(projects),
    );
  }
}

/// En cuántas ofertas aparece alguna forma de la palabra clave (cargo,
/// requisitos y descripción). Cuenta las guardadas y las sugeridas.
int offersMentioning({
  required List<SavedJob> jobs,
  required List<String> terms,
}) => jobs.where((SavedJob saved) {
  final Job job = saved.job;
  final String text = resumeCorpus(
    ProfileData(
      profile: Profile(
        summary: <String>[
          job.title,
          ...job.requirements,
          job.description,
        ].join('\n'),
      ),
    ),
  );
  return terms.any(
    (String term) => resumeHasKeyword(corpus: text, keyword: term),
  );
}).length;

/// Ofertas que sirven para medir el mercado: con texto y no descartadas.
List<SavedJob> marketJobs(List<SavedJob> jobs) => jobs
    .where(
      (SavedJob saved) =>
          !saved.job.dismissed &&
          (saved.job.requirements.isNotEmpty ||
              saved.job.description.trim().isNotEmpty),
    )
    .toList();
