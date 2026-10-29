import 'package:freezed_annotation/freezed_annotation.dart';

import '../../jobs/domain/job.dart';
import '../../profile/domain/keyword_analysis.dart';
import '../../profile/domain/profile.dart';
import '../../profile/domain/resume_review.dart';

part 'learning.freezed.dart';

enum LearningStatus { pending, learning, mastered }

/// Plan generado por la IA para aprender un tema.
@Freezed(fromJson: false, toJson: false)
abstract class LearningPlan with _$LearningPlan {
  const factory LearningPlan({
    required String why,
    required List<({String title, String detail})> steps,
    required List<({String title, String url, String kind})> resources,
    required String project,
    required int hours,
  }) = _LearningPlan;

  factory LearningPlan.fromJson(Map<String, dynamic> json) => LearningPlan(
    why: json['why'] as String? ?? '',
    steps: [
      for (final item in json['steps'] as List? ?? const [])
        (
          title: (item as Map)['title'] as String? ?? '',
          detail: item['detail'] as String? ?? '',
        ),
    ],
    resources: [
      for (final item in json['resources'] as List? ?? const [])
        (
          title: (item as Map)['title'] as String? ?? '',
          url: item['url'] as String? ?? '',
          kind: item['kind'] as String? ?? 'docs',
        ),
    ],
    project: json['project'] as String? ?? '',
    hours: (json['hours'] as num?)?.toInt() ?? 0,
  );
}

@freezed
abstract class LearningTopic with _$LearningTopic {
  const factory LearningTopic({
    required String id,
    required String topic,
    @Default(LearningStatus.pending) LearningStatus status,

    /// En cuántas ofertas aparecía al añadirlo.
    @Default(0) int demand,
    LearningPlan? plan,
  }) = _LearningTopic;
}

/// Tema que conviene aprender: falta en la HV y lo piden las ofertas.
@freezed
abstract class LearningCandidate with _$LearningCandidate {
  const factory LearningCandidate({
    required String topic,

    /// En cuántas de las ofertas del usuario aparece.
    required int demand,

    /// La IA lo marcó como imprescindible para sus cargos.
    @Default(false) bool important,
  }) = _LearningCandidate;
}

/// Máximo de sugerencias que se muestran.
const maxLearningCandidates = 8;

/// Requisitos sin cumplir de las ofertas más largos que esto suelen ser
/// frases («Experiencia liderando equipos…»), no temas que aprender.
const _maxGapLength = 40;

/// Qué aprender, de más a menos útil: palabras clave de los cargos que no
/// aparecen en la HV y requisitos que más faltan en las ofertas analizadas.
/// No repite lo que ya está en el plan.
List<LearningCandidate> learningCandidates({
  required ProfileData profile,
  required List<({String keyword, List<String> aliases, bool important})>
  keywords,
  required List<({String label, int count})> gaps,
  required List<SavedJob> market,
  required List<LearningTopic> planned,
}) {
  final sections = ResumeSections(profile);
  final corpus = resumeCorpus(profile);
  final taken = {for (final t in planned) t.topic.trim().toLowerCase()};
  final candidates = <String, LearningCandidate>{};

  void add(String topic, int demand, bool important) {
    final key = topic.trim().toLowerCase();
    if (key.isEmpty || taken.contains(key)) return;
    final current = candidates[key];
    if (current == null || demand > current.demand) {
      candidates[key] = LearningCandidate(
        topic: topic.trim(),
        demand: demand,
        important: important || (current?.important ?? false),
      );
    }
  }

  for (final k in keywords) {
    final terms = keywordTerms(k.keyword, k.aliases);
    if (sections.presenceOf(terms).found) continue;
    add(k.keyword, offersMentioning(market, terms), k.important);
  }
  for (final gap in gaps) {
    final label = gap.label.trim();
    if (label.length > _maxGapLength || resumeHasKeyword(corpus, label)) {
      continue;
    }
    add(label, gap.count, false);
  }
  return (candidates.values.toList()..sort(
        (a, b) => b.demand != a.demand
            ? b.demand.compareTo(a.demand)
            : (b.important ? 1 : 0) - (a.important ? 1 : 0),
      ))
      .take(maxLearningCandidates)
      .toList();
}

/// Plan ordenado: primero lo que se está aprendiendo, luego lo pendiente y
/// al final lo dominado; dentro de cada grupo, lo más pedido primero.
List<LearningTopic> sortTopics(List<LearningTopic> topics) =>
    [...topics]..sort((a, b) {
      const order = {
        LearningStatus.learning: 0,
        LearningStatus.pending: 1,
        LearningStatus.mastered: 2,
      };
      final byStatus = order[a.status]!.compareTo(order[b.status]!);
      return byStatus != 0 ? byStatus : b.demand.compareTo(a.demand);
    });
