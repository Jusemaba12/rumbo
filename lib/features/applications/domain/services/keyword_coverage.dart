import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rumbo/features/applications/domain/entities/application_draft.dart';
import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/domain/services/keyword_analysis.dart';
import 'package:rumbo/features/profile/domain/services/resume_review.dart';

part 'keyword_coverage.freezed.dart';

/// Cuántas palabras clave de una oferta cubre la HV, antes y después de
/// adaptarla.
@freezed
abstract class KeywordCoverage with _$KeywordCoverage {
  const KeywordCoverage._();

  const factory KeywordCoverage({
    /// Palabras clave que pide la oferta.
    required List<String> keywords,
    required Set<String> inBase,
    required Set<String> inTailored,
  }) = _KeywordCoverage;

  int get basePercent =>
      keywords.isEmpty ? 0 : (inBase.length * 100 / keywords.length).round();

  int get tailoredPercent => keywords.isEmpty
      ? 0
      : (inTailored.length * 100 / keywords.length).round();

  List<String> get missing =>
      keywords.where((String k) => !inTailored.contains(k)).toList();
}

/// Palabras clave de [job]: las del catálogo, las habilidades del usuario y
/// [extra] (las de sus cargos) que aparecen en la oferta.
KeywordCoverage keywordCoverage({
  required Job job,
  required ProfileData base,
  required TailoredResume tailored,
  List<String> extra = const <String>[],
}) {
  final String jobText = _corpus(<String>[
    job.title,
    ...job.requirements,
    job.description,
  ]);
  final Map<String, List<String>> candidates = <String, List<String>>{};
  for (final String keyword in <String>[
    ...techCatalog,
    for (final Skill skill in base.skills) skill.name,
    ...extra,
  ]) {
    final String key = keyword.trim();
    if (key.isEmpty ||
        candidates.keys.any(
          (String k) => k.toLowerCase() == key.toLowerCase(),
        )) {
      continue;
    }
    final List<String> terms = keywordTerms(key);
    // Una palabra ya contada como variante de otra no se repite.
    if (candidates.values.any(
      (List<String> other) =>
          other.any((String t) => t.toLowerCase() == key.toLowerCase()),
    )) {
      continue;
    }
    if (terms.any(
      (String term) => resumeHasKeyword(corpus: jobText, keyword: term),
    )) {
      candidates[key] = terms;
    }
  }
  final String baseText = resumeCorpus(base);
  final String tailoredText = _corpus(<String>[
    tailored.headline,
    tailored.summary,
    for (final TailoredExperience e in tailored.experiences) ...<String>[
      e.role,
      ...e.bullets,
    ],
    ...tailored.skills,
  ]);
  bool found(String corpus, List<String> terms) => terms.any(
    (String term) => resumeHasKeyword(corpus: corpus, keyword: term),
  );
  return KeywordCoverage(
    keywords: candidates.keys.toList(),
    inBase: <String>{
      for (final MapEntry<String, List<String>> entry in candidates.entries)
        if (found(baseText, entry.value)) entry.key,
    },
    inTailored: <String>{
      for (final MapEntry<String, List<String>> entry in candidates.entries)
        if (found(tailoredText, entry.value)) entry.key,
    },
  );
}

String _corpus(List<String> texts) =>
    resumeCorpus(ProfileData(profile: Profile(summary: texts.join('\n'))));
