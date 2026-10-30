import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/learning/domain/entities/learning.dart';
import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/domain/services/keyword_analysis.dart';
import 'package:rumbo/features/profile/domain/services/resume_review.dart';

/// Máximo de sugerencias que se muestran.
const int maxLearningCandidates = 8;

/// Requisitos sin cumplir de las ofertas más largos que esto suelen ser
/// frases («Experiencia liderando equipos…»), no temas que aprender.
const int _maxGapLength = 40;

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
  final ResumeSections sections = ResumeSections(profile);
  final String corpus = resumeCorpus(profile);
  final Set<String> taken = <String>{
    for (final LearningTopic t in planned) t.topic.trim().toLowerCase(),
  };
  final Map<String, LearningCandidate> candidates =
      <String, LearningCandidate>{};

  void add(String topic, int demand, bool important) {
    final String key = topic.trim().toLowerCase();
    if (key.isEmpty || taken.contains(key)) return;
    final LearningCandidate? current = candidates[key];
    if (current == null || demand > current.demand) {
      candidates[key] = LearningCandidate(
        topic: topic.trim(),
        demand: demand,
        important: important || (current?.important ?? false),
      );
    }
  }

  for (final ({List<String> aliases, bool important, String keyword}) k
      in keywords) {
    final List<String> terms = keywordTerms(k.keyword, aliases: k.aliases);
    if (sections.presenceOf(terms).found) continue;
    add(k.keyword, offersMentioning(jobs: market, terms: terms), k.important);
  }
  for (final ({int count, String label}) gap in gaps) {
    final String label = gap.label.trim();
    if (label.length > _maxGapLength ||
        resumeHasKeyword(corpus: corpus, keyword: label)) {
      continue;
    }
    add(label, gap.count, false);
  }
  return (candidates.values.toList()..sort(
        (LearningCandidate a, LearningCandidate b) => b.demand != a.demand
            ? b.demand.compareTo(a.demand)
            : (b.important ? 1 : 0) - (a.important ? 1 : 0),
      ))
      .take(maxLearningCandidates)
      .toList();
}

/// Plan ordenado: primero lo que se está aprendiendo, luego lo pendiente y
/// al final lo dominado; dentro de cada grupo, lo más pedido primero.
List<LearningTopic> sortTopics(List<LearningTopic> topics) =>
    <LearningTopic>[...topics]..sort((LearningTopic a, LearningTopic b) {
      const Map<LearningStatus, int> order = <LearningStatus, int>{
        LearningStatus.learning: 0,
        LearningStatus.pending: 1,
        LearningStatus.mastered: 2,
      };
      final int byStatus = order[a.status]!.compareTo(order[b.status]!);
      return byStatus != 0 ? byStatus : b.demand.compareTo(a.demand);
    });
