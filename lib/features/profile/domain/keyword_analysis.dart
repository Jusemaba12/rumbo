import 'package:freezed_annotation/freezed_annotation.dart';

import '../../jobs/domain/job.dart';
import 'profile.dart';
import 'resume_review.dart';

part 'keyword_analysis.freezed.dart';

/// Variantes habituales que significan lo mismo para un ATS. Se suman a las
/// que da la IA para cada palabra clave.
const _synonymGroups = [
  ['REST API', 'RESTful', 'APIs REST', 'API REST', 'REST'],
  ['CI/CD', 'integración continua', 'continuous integration'],
  ['JavaScript', 'JS'],
  ['TypeScript', 'TS'],
  ['Unit testing', 'pruebas unitarias', 'unit tests', 'tests unitarios'],
  ['Integration testing', 'pruebas de integración', 'integration tests'],
  ['Widget testing', 'widget tests', 'pruebas de widgets'],
  ['Testing', 'pruebas', 'tests', 'QA'],
  ['State management', 'gestión de estado', 'manejo de estado'],
  ['Clean Architecture', 'arquitectura limpia'],
  ['Agile', 'ágil', 'metodologías ágiles', 'Scrum', 'Kanban'],
  ['Git', 'GitHub', 'GitLab', 'Bitbucket'],
  ['Google Play', 'Play Store', 'Google Play Store'],
  ['App Store', 'Apple App Store', 'App Store Connect'],
  ['Native Android', 'Android nativo', 'Kotlin', 'Java Android'],
  ['Native iOS', 'iOS nativo', 'Swift', 'SwiftUI'],
  ['Firebase', 'Firestore', 'Firebase Auth', 'Crashlytics'],
  ['Bloc', 'flutter_bloc', 'Cubit'],
  ['ChangeNotifier'],
  ['GraphQL', 'Apollo'],
  ['WebSockets', 'WebSocket', 'sockets'],
  ['SQL', 'PostgreSQL', 'MySQL', 'SQLite'],
  ['UI/UX', 'UX', 'diseño de interfaces', 'user experience'],
  ['Performance', 'rendimiento', 'optimización'],
  ['Accessibility', 'accesibilidad', 'a11y'],
  ['English', 'inglés'],
];

/// Tecnologías y prácticas que se buscan en las ofertas para medir la
/// cobertura de la HV (se suman las habilidades del usuario y las palabras
/// clave de sus cargos). Sin palabras comunes en inglés que confundirían
/// («Go», «Provider», «SOLID», «Performance»).
const techCatalog = [
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
List<String> keywordTerms(String keyword, [List<String> aliases = const []]) {
  final terms = <String>{keyword, ...aliases};
  for (final group in _synonymGroups) {
    if (group.any(
      (term) => terms.any((t) => t.toLowerCase() == term.toLowerCase()),
    )) {
      terms.addAll(group);
    }
  }
  return terms.where((t) => t.trim().isNotEmpty).toList();
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
    : experience = _corpus([
        for (final e in data.experiences) ...[
          e.role,
          ...e.achievements,
          ...e.technologies,
        ],
      ]),
      summary = _corpus([data.profile.headline, data.profile.summary]),
      skills = _corpus([for (final s in data.skills) s.name]),
      projects = _corpus([
        for (final p in data.projects) ...[
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
    bool any(String corpus) =>
        terms.any((term) => resumeHasKeyword(corpus, term));
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
int offersMentioning(List<SavedJob> jobs, List<String> terms) => jobs.where((
  saved,
) {
  final job = saved.job;
  final text = resumeCorpus(
    ProfileData(
      profile: Profile(
        summary: [job.title, ...job.requirements, job.description].join('\n'),
      ),
    ),
  );
  return terms.any((term) => resumeHasKeyword(text, term));
}).length;

/// Ofertas que sirven para medir el mercado: con texto y no descartadas.
List<SavedJob> marketJobs(List<SavedJob> jobs) => jobs
    .where(
      (saved) =>
          !saved.job.dismissed &&
          (saved.job.requirements.isNotEmpty ||
              saved.job.description.trim().isNotEmpty),
    )
    .toList();
