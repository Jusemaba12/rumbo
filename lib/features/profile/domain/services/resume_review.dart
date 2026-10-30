import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/domain/services/profile_completeness.dart';

part 'resume_review.freezed.dart';

/// Partes de la HV que se puntúan por separado. [points] es lo que vale cada
/// una; suman 100.
enum ReviewCategory {
  contact(20),
  structure(25),
  achievements(30),
  coherence(15),
  format(10);

  const ReviewCategory(this.points);

  final int points;
}

/// Gravedad de un problema, según cuánto resta.
enum ReviewSeverity { high, medium, low }

/// Qué falla. Cada tipo pertenece a una categoría y resta [penalty] puntos
/// de ella (los que se repiten por experiencia restan una vez por cada una).
enum ReviewIssueKind {
  // Contacto
  noName(category: ReviewCategory.contact, penalty: 8),
  noEmail(category: ReviewCategory.contact, penalty: 8),
  invalidEmail(category: ReviewCategory.contact, penalty: 6),
  noPhone(category: ReviewCategory.contact, penalty: 5),
  phoneNoCountryCode(category: ReviewCategory.contact, penalty: 2),
  noLocation(category: ReviewCategory.contact, penalty: 2),
  noLink(category: ReviewCategory.contact, penalty: 3),
  invalidLink(category: ReviewCategory.contact, penalty: 2),
  // Estructura
  noHeadline(category: ReviewCategory.structure, penalty: 6),
  noSummary(category: ReviewCategory.structure, penalty: 6),
  shortSummary(category: ReviewCategory.structure, penalty: 2),
  longSummary(category: ReviewCategory.structure, penalty: 2),
  noExperience(category: ReviewCategory.structure, penalty: 15),
  noEducation(category: ReviewCategory.structure, penalty: 3),
  endBeforeStart(category: ReviewCategory.structure, penalty: 6),
  futureDate(category: ReviewCategory.structure, penalty: 3),
  dateGap(category: ReviewCategory.structure, penalty: 2),
  severalCurrent(category: ReviewCategory.structure, penalty: 2),
  // Logros
  noAchievements(category: ReviewCategory.achievements, penalty: 6),
  fewNumbers(category: ReviewCategory.achievements, penalty: 5),
  weakStart(category: ReviewCategory.achievements, penalty: 3),
  firstPerson(category: ReviewCategory.achievements, penalty: 3),
  duplicates(category: ReviewCategory.achievements, penalty: 2),
  longBullets(category: ReviewCategory.achievements, penalty: 2),
  buzzwords(category: ReviewCategory.achievements, penalty: 2),
  // Coherencia y palabras clave
  fewSkills(category: ReviewCategory.coherence, penalty: 5),
  techNotInSkills(category: ReviewCategory.coherence, penalty: 3),
  headlineNoRole(category: ReviewCategory.coherence, penalty: 4),
  summaryNoTech(category: ReviewCategory.coherence, penalty: 2),
  summaryNoYears(category: ReviewCategory.coherence, penalty: 2),
  // Formato
  specialCharacters(category: ReviewCategory.format, penalty: 4),
  allCaps(category: ReviewCategory.format, penalty: 2),
  mixedLanguages(category: ReviewCategory.format, penalty: 3),
  tooLong(category: ReviewCategory.format, penalty: 3),
  tooShort(category: ReviewCategory.format, penalty: 3);

  const ReviewIssueKind({required this.category, required this.penalty});

  final ReviewCategory category;
  final int penalty;

  ReviewSeverity get severity => penalty >= 6
      ? ReviewSeverity.high
      : penalty >= 3
      ? ReviewSeverity.medium
      : ReviewSeverity.low;
}

@freezed
abstract class ReviewIssue with _$ReviewIssue {
  const ReviewIssue._();

  const factory ReviewIssue(
    ReviewIssueKind kind, {

    /// Experiencia afectada, para llevar al usuario a corregirla.
    Experience? experience,

    /// Dato numérico del mensaje (logros sin cifras, longitud, meses…).
    @Default(0) int count,

    /// Texto del mensaje (tecnologías que faltan, palabras vacías…).
    String? detail,
  }) = _ReviewIssue;

  ReviewCategory get category => kind.category;

  ReviewSeverity get severity => kind.severity;
}

@freezed
abstract class ResumeReview with _$ResumeReview {
  const ResumeReview._();

  const factory ResumeReview({
    /// Puntos obtenidos en cada categoría (de 0 a su máximo).
    required Map<ReviewCategory, int> categories,

    /// De más a menos grave.
    required List<ReviewIssue> issues,
  }) = _ResumeReview;

  /// 0-100: suma de las categorías.
  int get score =>
      categories.values.fold(0, (int sum, int points) => sum + points);

  List<ReviewIssue> issuesIn(ReviewCategory category) =>
      issues.where((ReviewIssue issue) => issue.category == category).toList();
}

/// Longitudes razonables del perfil profesional, en caracteres.
const int minSummaryLength = 150;
const int maxSummaryLength = 700;

/// Un logro más largo que esto suele ser un párrafo, no una viñeta.
const int maxBulletLength = 220;

/// Hueco entre empleos que conviene explicar.
const int maxGapDays = 183;

/// Palabras de la HV (titular, perfil y logros): 100-900 cabe en 1-2 páginas.
const int minResumeWords = 100;
const int maxResumeWords = 900;

/// Comienzos que describen tareas en vez de logros.
const List<String> _weakStarts = <String>[
  'responsable de',
  'encargado de',
  'encargada de',
  'apoyo en',
  'apoyé',
  'ayudé',
  'participé en',
  'tareas de',
  'funciones de',
  'colaboré en',
  'responsible for',
  'helped',
  'worked on',
  'assisted',
  'duties included',
];

/// Frases vacías que los reclutadores y los ATS ignoran.
const List<String> _buzzwords = <String>[
  'proactivo',
  'proactiva',
  'trabajo en equipo',
  'orientado a resultados',
  'orientada a resultados',
  'dinámico',
  'dinámica',
  'apasionado',
  'apasionada',
  'team player',
  'hard-working',
  'hardworking',
  'detail-oriented',
  'results-driven',
  'self-motivated',
];

final RegExp _digit = RegExp(r'\d');
final RegExp _email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]{2,}$');
final RegExp _firstPerson = RegExp(
  r'(^|[^a-záéíóúñ])(yo|mi|mis|me|conmigo|i|my|me)([^a-záéíóúñ]|$)',
  caseSensitive: false,
);
final RegExp _years = RegExp(
  r'\d+\+?\s*(años|año|years|year|yrs)',
  caseSensitive: false,
);
// Emojis, símbolos decorativos y viñetas pegadas que los ATS leen mal.
final RegExp _special = RegExp(
  r'[\u{1F300}-\u{1FAFF}\u{2600}-\u{27BF}\u{2B50}\u{2190}-\u{21FF}\u{25A0}-\u{25FF}★☆✔✓➤►▪●•]',
  unicode: true,
);
const Set<String> _spanishWords = <String>{
  'de',
  'la',
  'que',
  'el',
  'en',
  'y',
  'los',
  'para',
  'con',
  'las',
  'por',
  'una',
  'del',
};
const Set<String> _englishWords = <String>{
  'the',
  'and',
  'of',
  'to',
  'in',
  'for',
  'with',
  'on',
  'an',
  'by',
  'from',
};

/// Revisa la HV base con reglas que usan los ATS y los reclutadores, sin IA.
/// [targetRoles] son los cargos de las preferencias de búsqueda.
ResumeReview reviewResume(
  ProfileData data, {
  List<String> targetRoles = const <String>[],
  DateTime? now,
}) {
  final DateTime today = now ?? DateTime.now();
  final List<ReviewIssue> issues =
      <ReviewIssue>[
        ..._contactIssues(data.profile),
        ..._structureIssues(data: data, now: today),
        for (final Experience experience in sortExperiences(data.experiences))
          ..._experienceIssues(experience),
        ..._duplicateIssues(data),
        ..._coherenceIssues(data: data, targetRoles: targetRoles),
        ..._formatIssues(data),
      ]..sort(
        (ReviewIssue a, ReviewIssue b) =>
            b.kind.penalty.compareTo(a.kind.penalty),
      );
  final Map<ReviewCategory, int> lost = <ReviewCategory, int>{};
  for (final ReviewIssue issue in issues) {
    lost[issue.category] = (lost[issue.category] ?? 0) + issue.kind.penalty;
  }
  return ResumeReview(
    categories: <ReviewCategory, int>{
      for (final ReviewCategory category in ReviewCategory.values)
        category: (category.points - (lost[category] ?? 0)).clamp(
          0,
          category.points,
        ),
    },
    issues: issues,
  );
}

Iterable<ReviewIssue> _contactIssues(Profile profile) sync* {
  final String email = profile.email.trim();
  final String phone = profile.phone.trim();
  if (profile.fullName.trim().isEmpty) {
    yield const ReviewIssue(ReviewIssueKind.noName);
  }
  if (email.isEmpty) {
    yield const ReviewIssue(ReviewIssueKind.noEmail);
  } else if (!_email.hasMatch(email)) {
    yield const ReviewIssue(ReviewIssueKind.invalidEmail);
  }
  if (phone.isEmpty) {
    yield const ReviewIssue(ReviewIssueKind.noPhone);
  } else if (!phone.startsWith('+')) {
    yield const ReviewIssue(ReviewIssueKind.phoneNoCountryCode);
  }
  if (profile.location.trim().isEmpty) {
    yield const ReviewIssue(ReviewIssueKind.noLocation);
  }
  final List<String> links = profile.links.values
      .map((String url) => url.trim())
      .where((String url) => url.isNotEmpty)
      .toList();
  if (links.isEmpty) {
    yield const ReviewIssue(ReviewIssueKind.noLink);
  } else {
    final int invalid = links.where((String url) {
      final Uri? uri = Uri.tryParse(url);
      return uri == null ||
          !(uri.scheme == 'http' || uri.scheme == 'https') ||
          !uri.host.contains('.');
    }).length;
    if (invalid > 0) {
      yield ReviewIssue(ReviewIssueKind.invalidLink, count: invalid);
    }
  }
}

Iterable<ReviewIssue> _structureIssues({
  required ProfileData data,
  required DateTime now,
}) sync* {
  final Profile profile = data.profile;
  final String summary = profile.summary.trim();
  if (profile.headline.trim().isEmpty) {
    yield const ReviewIssue(ReviewIssueKind.noHeadline);
  }
  if (summary.isEmpty) {
    yield const ReviewIssue(ReviewIssueKind.noSummary);
  } else if (summary.length < minSummaryLength) {
    yield ReviewIssue(ReviewIssueKind.shortSummary, count: summary.length);
  } else if (summary.length > maxSummaryLength) {
    yield ReviewIssue(ReviewIssueKind.longSummary, count: summary.length);
  }
  if (data.experiences.isEmpty) {
    yield const ReviewIssue(ReviewIssueKind.noExperience);
  }
  if (data.education.isEmpty) {
    yield const ReviewIssue(ReviewIssueKind.noEducation);
  }
  final List<Experience> ordered = <Experience>[...data.experiences]
    ..sort((Experience a, Experience b) => a.startDate.compareTo(b.startDate));
  for (final Experience experience in ordered) {
    final DateTime? end = experience.endDate;
    if (end != null && end.isBefore(experience.startDate)) {
      yield ReviewIssue(ReviewIssueKind.endBeforeStart, experience: experience);
    }
    // Un mes de margen: hay quien pone el mes en curso como fin.
    final DateTime limit = now.add(const Duration(days: 31));
    if (experience.startDate.isAfter(limit) ||
        (end != null && end.isAfter(limit))) {
      yield ReviewIssue(ReviewIssueKind.futureDate, experience: experience);
    }
  }
  // Huecos: del fin más tardío hasta el siguiente empleo.
  DateTime? coveredUntil;
  bool current = false;
  for (final Experience experience in ordered) {
    if (coveredUntil != null && !current) {
      final int gap = experience.startDate.difference(coveredUntil).inDays;
      if (gap > maxGapDays) {
        yield ReviewIssue(
          ReviewIssueKind.dateGap,
          experience: experience,
          count: (gap / 30).round(),
        );
      }
    }
    final DateTime? end = experience.endDate;
    if (end == null) {
      current = true;
    } else if (coveredUntil == null || end.isAfter(coveredUntil)) {
      coveredUntil = end;
    }
  }
  final int currentJobs = data.experiences
      .where((Experience e) => e.isCurrent)
      .length;
  if (currentJobs > 1) {
    yield ReviewIssue(ReviewIssueKind.severalCurrent, count: currentJobs);
  }
}

Iterable<ReviewIssue> _experienceIssues(Experience experience) sync* {
  final List<String> bullets = _bullets(experience);
  if (bullets.isEmpty) {
    yield ReviewIssue(ReviewIssueKind.noAchievements, experience: experience);
    return;
  }
  // Las cifras (%, tiempos, usuarios) son lo que más pesa en una HV.
  final int withoutNumbers = bullets
      .where((String b) => !_digit.hasMatch(b))
      .length;
  if (bullets.length >= 2 && withoutNumbers * 2 > bullets.length) {
    yield ReviewIssue(
      ReviewIssueKind.fewNumbers,
      experience: experience,
      count: withoutNumbers,
    );
  }
  final int weak = bullets.where((String b) {
    final String lower = b.toLowerCase();
    return _weakStarts.any(lower.startsWith);
  }).length;
  if (weak > 0) {
    yield ReviewIssue(
      ReviewIssueKind.weakStart,
      experience: experience,
      count: weak,
    );
  }
  final int personal = bullets.where(_firstPerson.hasMatch).length;
  if (personal > 0) {
    yield ReviewIssue(
      ReviewIssueKind.firstPerson,
      experience: experience,
      count: personal,
    );
  }
  final int long = bullets
      .where((String b) => b.length > maxBulletLength)
      .length;
  if (long > 0) {
    yield ReviewIssue(
      ReviewIssueKind.longBullets,
      experience: experience,
      count: long,
    );
  }
}

/// Logros repetidos (copiados entre empleos) y frases vacías.
Iterable<ReviewIssue> _duplicateIssues(ProfileData data) sync* {
  final Set<String> seen = <String>{};
  int repeated = 0;
  for (final Experience experience in data.experiences) {
    for (final String bullet in _bullets(experience)) {
      if (!seen.add(_normalize(bullet))) repeated++;
    }
  }
  if (repeated > 0) {
    yield ReviewIssue(ReviewIssueKind.duplicates, count: repeated);
  }
  final String text = _normalize(
    <String>[
      data.profile.summary,
      for (final Experience e in data.experiences) ..._bullets(e),
    ].join('\n'),
  );
  final List<String> found = <String>[
    for (final String word in _buzzwords)
      if (resumeHasKeyword(corpus: text, keyword: word)) word,
  ];
  if (found.isNotEmpty) {
    yield ReviewIssue(
      ReviewIssueKind.buzzwords,
      detail: found.take(3).join(', '),
    );
  }
}

Iterable<ReviewIssue> _coherenceIssues({
  required ProfileData data,
  required List<String> targetRoles,
}) sync* {
  if (data.skills.length < minSkillsForCompleteProfile) {
    yield ReviewIssue(ReviewIssueKind.fewSkills, count: data.skills.length);
  }
  // Tecnologías usadas en la experiencia que no están en Habilidades.
  final Set<String> skills = <String>{
    for (final Skill s in data.skills) _normalize(s.name.trim()),
  };
  final Set<String> missing = <String>{};
  for (final Experience experience in data.experiences) {
    for (final String tech in experience.technologies) {
      final String name = tech.trim();
      if (name.isNotEmpty && !skills.contains(_normalize(name))) {
        missing.add(name);
      }
    }
  }
  if (missing.isNotEmpty) {
    yield ReviewIssue(
      ReviewIssueKind.techNotInSkills,
      count: missing.length,
      detail: missing.take(3).join(', '),
    );
  }
  final String headline = _normalize(data.profile.headline);
  final List<String> roles = targetRoles
      .where((String r) => r.trim().isNotEmpty)
      .toList();
  if (headline.isNotEmpty &&
      roles.isNotEmpty &&
      !roles.any(
        (String role) =>
            resumeHasKeyword(corpus: headline, keyword: role) ||
            resumeHasKeyword(
              corpus: headline,
              keyword: role.trim().split(RegExp(r'\s+')).first,
            ),
      )) {
    yield ReviewIssue(ReviewIssueKind.headlineNoRole, detail: roles.first);
  }
  final String summary = data.profile.summary.trim();
  if (summary.isNotEmpty) {
    final String corpus = _normalize(summary);
    final Iterable<String> top = data.skills.take(5).map((Skill s) => s.name);
    if (top.isNotEmpty &&
        !top.any(
          (String name) => resumeHasKeyword(corpus: corpus, keyword: name),
        )) {
      yield const ReviewIssue(ReviewIssueKind.summaryNoTech);
    }
    if (!_years.hasMatch(summary)) {
      yield const ReviewIssue(ReviewIssueKind.summaryNoYears);
    }
  }
}

Iterable<ReviewIssue> _formatIssues(ProfileData data) sync* {
  final Profile profile = data.profile;
  final List<String> bullets = <String>[
    for (final Experience e in data.experiences) ..._bullets(e),
  ];
  final List<String> texts = <String>[
    profile.headline,
    profile.summary,
    ...bullets,
  ].map((String t) => t.trim()).where((String t) => t.isNotEmpty).toList();
  final int special = texts.where(_special.hasMatch).length;
  if (special > 0) {
    yield ReviewIssue(ReviewIssueKind.specialCharacters, count: special);
  }
  final int shouting = texts.where((String t) {
    final String letters = t.replaceAll(RegExp(r'[^A-Za-zÁÉÍÓÚÑáéíóúñ]'), '');
    if (letters.length < 20) return false;
    final int upper = letters.replaceAll(RegExp(r'[^A-ZÁÉÍÓÚÑ]'), '').length;
    return upper / letters.length > 0.6;
  }).length;
  if (shouting > 0) {
    yield ReviewIssue(ReviewIssueKind.allCaps, count: shouting);
  }
  // Idioma de cada texto largo por sus palabras más comunes.
  int spanish = 0;
  int english = 0;
  for (final String text in texts) {
    final List<String> words = _normalize(text).split(RegExp(r'[^a-z]+'));
    final int es = words.where(_spanishWords.contains).length;
    final int en = words.where(_englishWords.contains).length;
    if (es + en < 2) continue;
    if (es > en) {
      spanish++;
    } else if (en > es) {
      english++;
    }
  }
  if (spanish >= 2 && english >= 2) {
    yield const ReviewIssue(ReviewIssueKind.mixedLanguages);
  }
  if (data.experiences.isNotEmpty) {
    final int words = texts
        .expand((String t) => t.split(RegExp(r'\s+')))
        .where((String w) => w.isNotEmpty)
        .length;
    if (words > maxResumeWords) {
      yield ReviewIssue(ReviewIssueKind.tooLong, count: words);
    } else if (words < minResumeWords) {
      yield ReviewIssue(ReviewIssueKind.tooShort, count: words);
    }
  }
}

List<String> _bullets(Experience experience) => experience.achievements
    .map((String text) => text.trim())
    .where((String text) => text.isNotEmpty)
    .toList();

/// Todo el texto de la HV en minúsculas y sin tildes, para buscar palabras.
String resumeCorpus(ProfileData data) => _normalize(
  <String>[
    data.profile.headline,
    data.profile.summary,
    for (final Experience e in data.experiences) ...<String>[
      e.role,
      ...e.achievements,
      ...e.technologies,
    ],
    for (final Project p in data.projects) ...<String>[
      p.name,
      p.description,
      ...p.technologies,
    ],
    for (final Skill s in data.skills) s.name,
    for (final Education e in data.education) e.degree,
  ].join('\n'),
);

/// Si la palabra clave aparece en el texto de la HV como palabras completas
/// («Go» no cuenta dentro de «Google»). Acepta plurales («APIs») y, si tiene
/// varias palabras, otro orden («APIs REST» para «REST API»).
bool resumeHasKeyword({required String corpus, required String keyword}) {
  final String needle = _normalize(keyword.trim());
  if (needle.isEmpty) return false;
  if (_wordPattern(needle).hasMatch(corpus)) return true;
  final List<String> words = needle.split(RegExp(r'\s+'));
  return words.length > 1 &&
      words.every((String word) => _wordPattern(word).hasMatch(corpus));
}

RegExp _wordPattern(String text) =>
    RegExp('(?<![a-z0-9])${RegExp.escape(text)}(?:e?s)?(?![a-z0-9])');

String _normalize(String text) {
  const String from = 'áàäâéèëêíìïîóòöôúùüûñ';
  const String to = 'aaaaeeeeiiiioooouuuun';
  final String lower = text.toLowerCase();
  final StringBuffer buffer = StringBuffer();
  for (final String char in lower.split('')) {
    final int index = from.indexOf(char);
    buffer.write(index == -1 ? char : to[index]);
  }
  return buffer.toString();
}
