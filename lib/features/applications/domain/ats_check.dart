import 'package:freezed_annotation/freezed_annotation.dart';

import '../../profile/domain/profile.dart';
import '../../profile/domain/resume_review.dart';
import 'application_draft.dart';

part 'ats_check.freezed.dart';

/// Qué se comprueba en el texto que extrae un ATS del PDF.
enum AtsCheckKind {
  name,
  email,
  phone,
  link,
  location,
  sections,
  experiences,
  dates,
  skills,
  characters,
  completeness,
  pages,
}

@freezed
abstract class AtsCheck with _$AtsCheck {
  const factory AtsCheck(
    AtsCheckKind kind, {
    required bool passed,

    /// Lo que falta (sección, cargo, habilidades…) cuando no pasa.
    @Default('') String detail,
  }) = _AtsCheck;
}

/// Textos de las secciones tal como las escribe el PDF.
typedef AtsHeadings = ({
  String summary,
  String experience,
  String education,
  String skills,
});

/// Un ATS lee bien hasta dos páginas.
const maxAtsPages = 2;

/// Parte mínima del texto esperado que debe salir del PDF.
const minExtractedRatio = 0.85;

final _monthYear = RegExp(
  r'(ene|feb|mar|abr|may|jun|jul|ago|sep|sept|oct|nov|dic|jan|apr|aug|dec)[a-z]*\.?\s+\d{4}',
  caseSensitive: false,
);
// Carácter de sustitución y uso privado: glifos que el lector no entendió.
final _broken = RegExp('[�-]');

/// Comprueba qué reconoce un ATS en el [text] extraído del PDF de [draft].
List<AtsCheck> checkAtsText({
  required String text,
  required int pages,
  required Profile profile,
  required ApplicationDraft draft,
  required List<Education> education,
  required AtsHeadings headings,
}) {
  final corpus = _normalize(text);
  bool has(String value) =>
      value.trim().isEmpty || corpus.contains(_normalize(value.trim()));
  final resume = draft.resume;
  final digits = text.replaceAll(RegExp(r'\D'), '');
  final phoneDigits = profile.phone.replaceAll(RegExp(r'\D'), '');
  final link = profile.links.values.firstWhere(
    (url) => url.trim().isNotEmpty,
    orElse: () => '',
  );
  final missingSections = [
    if (resume.summary.isNotEmpty) headings.summary,
    if (resume.experiences.isNotEmpty) headings.experience,
    if (education.isNotEmpty) headings.education,
    if (resume.skills.isNotEmpty) headings.skills,
  ].where((heading) => !has(heading)).toList();
  final missingJobs = [
    for (final e in resume.experiences)
      if (!has(e.role) || !has(e.company)) '${e.role} — ${e.company}',
  ];
  final dates = _monthYear.allMatches(text).length;
  final missingSkills = resume.skills.where((s) => !has(s)).toList();
  final expected = [
    profile.fullName,
    resume.headline,
    resume.summary,
    for (final e in resume.experiences) ...[e.role, e.company, ...e.bullets],
    ...resume.skills,
  ].join(' ');
  final expectedLetters = _letters(expected);
  final ratio = expectedLetters == 0 ? 1.0 : _letters(text) / expectedLetters;
  return [
    AtsCheck(
      AtsCheckKind.name,
      passed: profile.fullName.isNotEmpty && has(profile.fullName),
    ),
    AtsCheck(
      AtsCheckKind.email,
      passed: profile.email.isNotEmpty && has(profile.email),
    ),
    AtsCheck(
      AtsCheckKind.phone,
      passed:
          phoneDigits.length >= 7 &&
          digits.contains(phoneDigits.substring(phoneDigits.length - 7)),
    ),
    if (link.isNotEmpty)
      AtsCheck(
        AtsCheckKind.link,
        passed: has(link.replaceFirst(RegExp(r'^https?://'), '')),
      ),
    if (profile.location.isNotEmpty)
      AtsCheck(AtsCheckKind.location, passed: has(profile.location)),
    AtsCheck(
      AtsCheckKind.sections,
      passed: missingSections.isEmpty,
      detail: missingSections.join(', '),
    ),
    if (resume.experiences.isNotEmpty) ...[
      AtsCheck(
        AtsCheckKind.experiences,
        passed: missingJobs.isEmpty,
        detail: missingJobs.join(', '),
      ),
      AtsCheck(AtsCheckKind.dates, passed: dates >= resume.experiences.length),
    ],
    if (resume.skills.isNotEmpty)
      AtsCheck(
        AtsCheckKind.skills,
        passed: missingSkills.isEmpty,
        detail: missingSkills.take(5).join(', '),
      ),
    AtsCheck(AtsCheckKind.characters, passed: !_broken.hasMatch(text)),
    AtsCheck(
      AtsCheckKind.completeness,
      passed: ratio >= minExtractedRatio,
      detail: '${(ratio.clamp(0, 1) * 100).round()}',
    ),
    AtsCheck(
      AtsCheckKind.pages,
      passed: pages <= maxAtsPages,
      detail: '$pages',
    ),
  ];
}

int _letters(String text) =>
    text.replaceAll(RegExp(r'[^A-Za-zÁÉÍÓÚÑáéíóúñÜü0-9]'), '').length;

/// Minúsculas, sin tildes y con los espacios juntados (el PDF parte líneas).
String _normalize(String text) =>
    resumeCorpus(ProfileData(profile: Profile(summary: text)))
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
