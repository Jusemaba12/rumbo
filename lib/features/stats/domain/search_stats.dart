import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../applications/domain/application.dart';
import '../../applications/domain/application_status.dart';
import '../../jobs/domain/job.dart';

part 'search_stats.freezed.dart';

/// Estados que cuentan como «la empresa respondió».
const _responses = {
  ApplicationStatus.inReview,
  ApplicationStatus.technicalTest,
  ApplicationStatus.interview,
  ApplicationStatus.offer,
  ApplicationStatus.accepted,
  ApplicationStatus.declined,
  ApplicationStatus.rejected,
};

const _interviews = {
  ApplicationStatus.technicalTest,
  ApplicationStatus.interview,
  ApplicationStatus.offer,
  ApplicationStatus.accepted,
  ApplicationStatus.declined,
};

const _offers = {
  ApplicationStatus.offer,
  ApplicationStatus.accepted,
  ApplicationStatus.declined,
};

/// Embudo de la búsqueda: cuántos procesos llegaron a cada etapa.
@freezed
abstract class Funnel with _$Funnel {
  const Funnel._();

  const factory Funnel({
    required int saved,
    required int applied,
    required int responded,
    required int interviews,
    required int offers,
  }) = _Funnel;

  /// Porcentaje de postulaciones que recibieron respuesta; nulo sin datos.
  int? get responseRate =>
      applied == 0 ? null : (responded * 100 / applied).round();

  int? get interviewRate =>
      applied == 0 ? null : (interviews * 100 / applied).round();
}

/// Resultados por origen de la oferta (portal o añadida a mano).
@freezed
abstract class SourceStats with _$SourceStats {
  const factory SourceStats({
    /// Id de la fuente; `manual` agrupa las ofertas añadidas a mano.
    required String source,
    required int applied,
    required int responded,
  }) = _SourceStats;
}

/// Requisito que falta en varias de las ofertas analizadas.
@freezed
abstract class SkillGap with _$SkillGap {
  const factory SkillGap({required String label, required int count}) =
      _SkillGap;
}

@freezed
abstract class SearchStats with _$SearchStats {
  const factory SearchStats({
    required Funnel funnel,

    /// Días medios entre postular y la primera respuesta; nulo sin datos.
    required double? averageResponseDays,
    required List<SourceStats> bySource,
    required List<SkillGap> gaps,

    /// Ofertas con compatibilidad calculada (base de las brechas).
    required int analyzedJobs,
  }) = _SearchStats;
}

/// Calcula las estadísticas a partir de procesos, su historial y las ofertas.
SearchStats computeStats({
  required List<ApplicationWithJob> applications,
  required Map<String, List<ApplicationEvent>> events,
  required List<SavedJob> jobs,
  int maxGaps = 8,
}) {
  var applied = 0;
  var responded = 0;
  var interviews = 0;
  var offers = 0;
  final responseDays = <double>[];
  final bySource = <String, (int, int)>{};

  for (final item in applications) {
    final application = item.application;
    final history = events[application.id] ?? const [];
    final reached = {
      application.status,
      for (final event in history) event.toStatus,
    };
    final didApply =
        application.appliedAt != null ||
        reached.contains(ApplicationStatus.applied);
    if (!didApply) continue;

    applied++;
    final didRespond = reached.any(_responses.contains);
    if (didRespond) responded++;
    if (reached.any(_interviews.contains)) interviews++;
    if (reached.any(_offers.contains)) offers++;

    final appliedAt =
        application.appliedAt ??
        history
            .firstWhereOrNull((e) => e.toStatus == ApplicationStatus.applied)
            ?.createdAt;
    final firstResponse = history.firstWhereOrNull(
      (e) =>
          _responses.contains(e.toStatus) &&
          (appliedAt == null || !e.createdAt.isBefore(appliedAt)),
    );
    if (appliedAt != null && firstResponse != null) {
      responseDays.add(
        firstResponse.createdAt.difference(appliedAt).inHours / 24,
      );
    }

    final source = switch (item.job.source) {
      'link' || 'manual' => 'manual',
      final other => other,
    };
    final (sourceApplied, sourceResponded) = bySource[source] ?? (0, 0);
    bySource[source] = (
      sourceApplied + 1,
      sourceResponded + (didRespond ? 1 : 0),
    );
  }

  // Brechas: lo que más se repite en «te falta» de las ofertas no descartadas.
  final analyzed = jobs.where((s) => !s.job.dismissed && s.match != null);
  final counts = <String, int>{};
  final labels = <String, String>{};
  for (final saved in analyzed) {
    final seenInJob = <String>{};
    for (final missing in saved.match!.missing) {
      final key = _gapKey(missing);
      if (key.isEmpty || !seenInJob.add(key)) continue;
      counts[key] = (counts[key] ?? 0) + 1;
      labels.putIfAbsent(key, () => missing.trim());
    }
  }
  final gaps = counts.entries
      .where((e) => e.value >= 2 || analyzed.length < 3)
      .sorted((a, b) => b.value.compareTo(a.value))
      .take(maxGaps)
      .map((e) => SkillGap(label: labels[e.key]!, count: e.value))
      .toList();

  return SearchStats(
    funnel: Funnel(
      saved: applications.length,
      applied: applied,
      responded: responded,
      interviews: interviews,
      offers: offers,
    ),
    averageResponseDays: responseDays.isEmpty
        ? null
        : responseDays.reduce((a, b) => a + b) / responseDays.length,
    bySource: [
      for (final entry in bySource.entries)
        SourceStats(
          source: entry.key,
          applied: entry.value.$1,
          responded: entry.value.$2,
        ),
    ]..sort((a, b) => b.applied.compareTo(a.applied)),
    gaps: gaps,
    analyzedJobs: analyzed.length,
  );
}

/// Agrupa variantes del mismo requisito: «Kotlin», «kotlin.», «Kotlin: …».
String _gapKey(String text) => text
    .toLowerCase()
    .split(RegExp(r'[:(]'))
    .first
    .replaceAll(RegExp(r'[^\p{L}\p{N}+#. ]', unicode: true), '')
    .replaceAll(RegExp(r'\s+'), ' ')
    .trim()
    .replaceAll(RegExp(r'\.$'), '');
