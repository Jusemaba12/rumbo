import 'package:freezed_annotation/freezed_annotation.dart';

import 'profile.dart';
import 'profile_completeness.dart';

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
  noName(ReviewCategory.contact, 8),
  noEmail(ReviewCategory.contact, 8),
  invalidEmail(ReviewCategory.contact, 6),
  noPhone(ReviewCategory.contact, 5),
  phoneNoCountryCode(ReviewCategory.contact, 2),
  noLocation(ReviewCategory.contact, 2),
  noLink(ReviewCategory.contact, 3),
  invalidLink(ReviewCategory.contact, 2),
  // Estructura
  noHeadline(ReviewCategory.structure, 6),
  noSummary(ReviewCategory.structure, 6),
  shortSummary(ReviewCategory.structure, 2),
  longSummary(ReviewCategory.structure, 2),
  noExperience(ReviewCategory.structure, 15),
  noEducation(ReviewCategory.structure, 3),
  endBeforeStart(ReviewCategory.structure, 6),
  futureDate(ReviewCategory.structure, 3),
  dateGap(ReviewCategory.structure, 2),
  severalCurrent(ReviewCategory.structure, 2),
  // Logros
  noAchievements(ReviewCategory.achievements, 6),
  fewNumbers(ReviewCategory.achievements, 5),
  weakStart(ReviewCategory.achievements, 3),
  firstPerson(ReviewCategory.achievements, 3),
  duplicates(ReviewCategory.achievements, 2),
  longBullets(ReviewCategory.achievements, 2),
  buzzwords(ReviewCategory.achievements, 2),
  // Coherencia y palabras clave
  fewSkills(ReviewCategory.coherence, 5),
  techNotInSkills(ReviewCategory.coherence, 3),
  headlineNoRole(ReviewCategory.coherence, 4),
  summaryNoTech(ReviewCategory.coherence, 2),
  summaryNoYears(ReviewCategory.coherence, 2),
  // Formato
  specialCharacters(ReviewCategory.format, 4),
  allCaps(ReviewCategory.format, 2),
  mixedLanguages(ReviewCategory.format, 3),
  tooLong(ReviewCategory.format, 3),
  tooShort(ReviewCategory.format, 3);

  const ReviewIssueKind(this.category, this.penalty);

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
  int get score => categories.values.fold(0, (sum, points) => sum + points);

  List<ReviewIssue> issuesIn(ReviewCategory category) =>
      issues.where((issue) => issue.category == category).toList();
}

/// Longitudes razonables del perfil profesional, en caracteres.
const minSummaryLength = 150;
const maxSummaryLength = 700;

/// Un logro más largo que esto suele ser un párrafo, no una viñeta.
const maxBulletLength = 220;

/// Hueco entre empleos que conviene explicar.
const maxGapDays = 183;

/// Palabras de la HV (titular, perfil y logros): 100-900 cabe en 1-2 páginas.
const minResumeWords = 100;
const maxResumeWords = 900;

/// Comienzos que describen tareas en vez de logros.
const _weakStarts = [
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
const _buzzwords = [
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

final _digit = RegExp(r'\d');
final _email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]{2,}$');
final _firstPerson = RegExp(
  r'(^|[^a-záéíóúñ])(yo|mi|mis|me|conmigo|i|my|me)([^a-záéíóúñ]|$)',
  caseSensitive: false,
);
final _years = RegExp(
  r'\d+\+?\s*(años|año|years|year|yrs)',
  caseSensitive: false,
);
// Emojis, símbolos decorativos y viñetas pegadas que los ATS leen mal.
final _special = RegExp(
  r'[\u{1F300}-\u{1FAFF}\u{2600}-\u{27BF}\u{2B50}\u{2190}-\u{21FF}\u{25A0}-\u{25FF}★☆✔✓➤►▪●•]',
  unicode: true,
);
const _spanishWords = {
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
const _englishWords = {
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
  List<String> targetRoles = const [],
  DateTime? now,
}) {
  final today = now ?? DateTime.now();
  final issues = <ReviewIssue>[
    ..._contactIssues(data.profile),
    ..._structureIssues(data, today),
    for (final experience in sortExperiences(data.experiences))
      ..._experienceIssues(experience),
    ..._duplicateIssues(data),
    ..._coherenceIssues(data, targetRoles),
    ..._formatIssues(data),
  ]..sort((a, b) => b.kind.penalty.compareTo(a.kind.penalty));
  final lost = <ReviewCategory, int>{};
  for (final issue in issues) {
    lost[issue.category] = (lost[issue.category] ?? 0) + issue.kind.penalty;
  }
  return ResumeReview(
    categories: {
      for (final category in ReviewCategory.values)
        category: (category.points - (lost[category] ?? 0)).clamp(
          0,
          category.points,
        ),
    },
    issues: issues,
  );
}

Iterable<ReviewIssue> _contactIssues(Profile profile) sync* {
  final email = profile.email.trim();
  final phone = profile.phone.trim();
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
  final links = profile.links.values
      .map((url) => url.trim())
      .where((url) => url.isNotEmpty)
      .toList();
  if (links.isEmpty) {
    yield const ReviewIssue(ReviewIssueKind.noLink);
  } else {
    final invalid = links.where((url) {
      final uri = Uri.tryParse(url);
      return uri == null ||
          !(uri.scheme == 'http' || uri.scheme == 'https') ||
          !uri.host.contains('.');
    }).length;
    if (invalid > 0) {
      yield ReviewIssue(ReviewIssueKind.invalidLink, count: invalid);
    }
  }
}

Iterable<ReviewIssue> _structureIssues(ProfileData data, DateTime now) sync* {
  final profile = data.profile;
  final summary = profile.summary.trim();
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
  final ordered = [...data.experiences]
    ..sort((a, b) => a.startDate.compareTo(b.startDate));
  for (final experience in ordered) {
    final end = experience.endDate;
    if (end != null && end.isBefore(experience.startDate)) {
      yield ReviewIssue(ReviewIssueKind.endBeforeStart, experience: experience);
    }
    // Un mes de margen: hay quien pone el mes en curso como fin.
    final limit = now.add(const Duration(days: 31));
    if (experience.startDate.isAfter(limit) ||
        (end != null && end.isAfter(limit))) {
      yield ReviewIssue(ReviewIssueKind.futureDate, experience: experience);
    }
  }
  // Huecos: del fin más tardío hasta el siguiente empleo.
  DateTime? coveredUntil;
  var current = false;
  for (final experience in ordered) {
    if (coveredUntil != null && !current) {
      final gap = experience.startDate.difference(coveredUntil).inDays;
      if (gap > maxGapDays) {
        yield ReviewIssue(
          ReviewIssueKind.dateGap,
          experience: experience,
          count: (gap / 30).round(),
        );
      }
    }
    final end = experience.endDate;
    if (end == null) {
      current = true;
    } else if (coveredUntil == null || end.isAfter(coveredUntil)) {
      coveredUntil = end;
    }
  }
  final currentJobs = data.experiences.where((e) => e.isCurrent).length;
  if (currentJobs > 1) {
    yield ReviewIssue(ReviewIssueKind.severalCurrent, count: currentJobs);
  }
}

Iterable<ReviewIssue> _experienceIssues(Experience experience) sync* {
  final bullets = _bullets(experience);
  if (bullets.isEmpty) {
    yield ReviewIssue(ReviewIssueKind.noAchievements, experience: experience);
    return;
  }
  // Las cifras (%, tiempos, usuarios) son lo que más pesa en una HV.
  final withoutNumbers = bullets.where((b) => !_digit.hasMatch(b)).length;
  if (bullets.length >= 2 && withoutNumbers * 2 > bullets.length) {
    yield ReviewIssue(
      ReviewIssueKind.fewNumbers,
      experience: experience,
      count: withoutNumbers,
    );
  }
  final weak = bullets.where((b) {
    final lower = b.toLowerCase();
    return _weakStarts.any(lower.startsWith);
  }).length;
  if (weak > 0) {
    yield ReviewIssue(
      ReviewIssueKind.weakStart,
      experience: experience,
      count: weak,
    );
  }
  final personal = bullets.where(_firstPerson.hasMatch).length;
  if (personal > 0) {
    yield ReviewIssue(
      ReviewIssueKind.firstPerson,
      experience: experience,
      count: personal,
    );
  }
  final long = bullets.where((b) => b.length > maxBulletLength).length;
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
  final seen = <String>{};
  var repeated = 0;
  for (final experience in data.experiences) {
    for (final bullet in _bullets(experience)) {
      if (!seen.add(_normalize(bullet))) repeated++;
    }
  }
  if (repeated > 0) {
    yield ReviewIssue(ReviewIssueKind.duplicates, count: repeated);
  }
  final text = _normalize(
    [
      data.profile.summary,
      for (final e in data.experiences) ..._bullets(e),
    ].join('\n'),
  );
  final found = [
    for (final word in _buzzwords)
      if (resumeHasKeyword(text, word)) word,
  ];
  if (found.isNotEmpty) {
    yield ReviewIssue(
      ReviewIssueKind.buzzwords,
      detail: found.take(3).join(', '),
    );
  }
}

Iterable<ReviewIssue> _coherenceIssues(
  ProfileData data,
  List<String> targetRoles,
) sync* {
  if (data.skills.length < minSkillsForCompleteProfile) {
    yield ReviewIssue(ReviewIssueKind.fewSkills, count: data.skills.length);
  }
  // Tecnologías usadas en la experiencia que no están en Habilidades.
  final skills = {for (final s in data.skills) _normalize(s.name.trim())};
  final missing = <String>{};
  for (final experience in data.experiences) {
    for (final tech in experience.technologies) {
      final name = tech.trim();
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
  final headline = _normalize(data.profile.headline);
  final roles = targetRoles.where((r) => r.trim().isNotEmpty).toList();
  if (headline.isNotEmpty &&
      roles.isNotEmpty &&
      !roles.any(
        (role) =>
            resumeHasKeyword(headline, role) ||
            resumeHasKeyword(headline, role.trim().split(RegExp(r'\s+')).first),
      )) {
    yield ReviewIssue(ReviewIssueKind.headlineNoRole, detail: roles.first);
  }
  final summary = data.profile.summary.trim();
  if (summary.isNotEmpty) {
    final corpus = _normalize(summary);
    final top = data.skills.take(5).map((s) => s.name);
    if (top.isNotEmpty && !top.any((name) => resumeHasKeyword(corpus, name))) {
      yield const ReviewIssue(ReviewIssueKind.summaryNoTech);
    }
    if (!_years.hasMatch(summary)) {
      yield const ReviewIssue(ReviewIssueKind.summaryNoYears);
    }
  }
}

Iterable<ReviewIssue> _formatIssues(ProfileData data) sync* {
  final profile = data.profile;
  final bullets = [for (final e in data.experiences) ..._bullets(e)];
  final texts = [
    profile.headline,
    profile.summary,
    ...bullets,
  ].map((t) => t.trim()).where((t) => t.isNotEmpty).toList();
  final special = texts.where(_special.hasMatch).length;
  if (special > 0) {
    yield ReviewIssue(ReviewIssueKind.specialCharacters, count: special);
  }
  final shouting = texts.where((t) {
    final letters = t.replaceAll(RegExp(r'[^A-Za-zÁÉÍÓÚÑáéíóúñ]'), '');
    if (letters.length < 20) return false;
    final upper = letters.replaceAll(RegExp(r'[^A-ZÁÉÍÓÚÑ]'), '').length;
    return upper / letters.length > 0.6;
  }).length;
  if (shouting > 0) {
    yield ReviewIssue(ReviewIssueKind.allCaps, count: shouting);
  }
  // Idioma de cada texto largo por sus palabras más comunes.
  var spanish = 0;
  var english = 0;
  for (final text in texts) {
    final words = _normalize(text).split(RegExp(r'[^a-z]+'));
    final es = words.where(_spanishWords.contains).length;
    final en = words.where(_englishWords.contains).length;
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
    final words = texts
        .expand((t) => t.split(RegExp(r'\s+')))
        .where((w) => w.isNotEmpty)
        .length;
    if (words > maxResumeWords) {
      yield ReviewIssue(ReviewIssueKind.tooLong, count: words);
    } else if (words < minResumeWords) {
      yield ReviewIssue(ReviewIssueKind.tooShort, count: words);
    }
  }
}

List<String> _bullets(Experience experience) => experience.achievements
    .map((text) => text.trim())
    .where((text) => text.isNotEmpty)
    .toList();

/// Todo el texto de la HV en minúsculas y sin tildes, para buscar palabras.
String resumeCorpus(ProfileData data) => _normalize(
  [
    data.profile.headline,
    data.profile.summary,
    for (final e in data.experiences) ...[
      e.role,
      ...e.achievements,
      ...e.technologies,
    ],
    for (final p in data.projects) ...[
      p.name,
      p.description,
      ...p.technologies,
    ],
    for (final s in data.skills) s.name,
    for (final e in data.education) e.degree,
  ].join('\n'),
);

/// Si la palabra clave aparece en el texto de la HV como palabras completas
/// («Go» no cuenta dentro de «Google»). Acepta plurales («APIs») y, si tiene
/// varias palabras, otro orden («APIs REST» para «REST API»).
bool resumeHasKeyword(String corpus, String keyword) {
  final needle = _normalize(keyword.trim());
  if (needle.isEmpty) return false;
  if (_wordPattern(needle).hasMatch(corpus)) return true;
  final words = needle.split(RegExp(r'\s+'));
  return words.length > 1 &&
      words.every((word) => _wordPattern(word).hasMatch(corpus));
}

RegExp _wordPattern(String text) =>
    RegExp('(?<![a-z0-9])${RegExp.escape(text)}(?:e?s)?(?![a-z0-9])');

String _normalize(String text) {
  const from = 'áàäâéèëêíìïîóòöôúùüûñ';
  const to = 'aaaaeeeeiiiioooouuuun';
  final lower = text.toLowerCase();
  final buffer = StringBuffer();
  for (final char in lower.split('')) {
    final index = from.indexOf(char);
    buffer.write(index == -1 ? char : to[index]);
  }
  return buffer.toString();
}
