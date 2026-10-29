import 'package:freezed_annotation/freezed_annotation.dart';

import '../../jobs/domain/job.dart';
import '../../profile/domain/keyword_analysis.dart';
import '../../profile/domain/profile.dart';
import '../../profile/domain/resume_review.dart';
import 'application_draft.dart';

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
      keywords.where((k) => !inTailored.contains(k)).toList();
}

/// Palabras clave de [job]: las del catálogo, las habilidades del usuario y
/// [extra] (las de sus cargos) que aparecen en la oferta.
KeywordCoverage keywordCoverage({
  required Job job,
  required ProfileData base,
  required TailoredResume tailored,
  List<String> extra = const [],
}) {
  final jobText = _corpus([job.title, ...job.requirements, job.description]);
  final candidates = <String, List<String>>{};
  for (final keyword in [
    ...techCatalog,
    for (final skill in base.skills) skill.name,
    ...extra,
  ]) {
    final key = keyword.trim();
    if (key.isEmpty ||
        candidates.keys.any((k) => k.toLowerCase() == key.toLowerCase())) {
      continue;
    }
    final terms = keywordTerms(key);
    // Una palabra ya contada como variante de otra no se repite.
    if (candidates.values.any(
      (other) => other.any((t) => t.toLowerCase() == key.toLowerCase()),
    )) {
      continue;
    }
    if (terms.any((term) => resumeHasKeyword(jobText, term))) {
      candidates[key] = terms;
    }
  }
  final baseText = resumeCorpus(base);
  final tailoredText = _corpus([
    tailored.headline,
    tailored.summary,
    for (final e in tailored.experiences) ...[e.role, ...e.bullets],
    ...tailored.skills,
  ]);
  bool found(String corpus, List<String> terms) =>
      terms.any((term) => resumeHasKeyword(corpus, term));
  return KeywordCoverage(
    keywords: candidates.keys.toList(),
    inBase: {
      for (final entry in candidates.entries)
        if (found(baseText, entry.value)) entry.key,
    },
    inTailored: {
      for (final entry in candidates.entries)
        if (found(tailoredText, entry.value)) entry.key,
    },
  );
}

String _corpus(List<String> texts) =>
    resumeCorpus(ProfileData(profile: Profile(summary: texts.join('\n'))));
