import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:rumbo/features/applications/domain/entities/application.dart';
import 'package:rumbo/features/applications/domain/entities/application_status.dart';
import 'package:rumbo/features/jobs/domain/entities/job.dart';

part 'search_stats.freezed.dart';

/// Estados que cuentan como «la empresa respondió».
const Set<ApplicationStatus> _responses = <ApplicationStatus>{
  ApplicationStatus.inReview,
  ApplicationStatus.technicalTest,
  ApplicationStatus.interview,
  ApplicationStatus.offer,
  ApplicationStatus.accepted,
  ApplicationStatus.declined,
  ApplicationStatus.rejected,
};

const Set<ApplicationStatus> _interviews = <ApplicationStatus>{
  ApplicationStatus.technicalTest,
  ApplicationStatus.interview,
  ApplicationStatus.offer,
  ApplicationStatus.accepted,
  ApplicationStatus.declined,
};

const Set<ApplicationStatus> _offers = <ApplicationStatus>{
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
  int applied = 0;
  int responded = 0;
  int interviews = 0;
  int offers = 0;
  final List<double> responseDays = <double>[];
  final Map<String, (int, int)> bySource = <String, (int, int)>{};

  for (final ApplicationWithJob item in applications) {
    final Application application = item.application;
    final List<ApplicationEvent> history =
        events[application.id] ?? const <ApplicationEvent>[];
    final Set<ApplicationStatus> reached = <ApplicationStatus>{
      application.status,
      for (final ApplicationEvent event in history) event.toStatus,
    };
    final bool didApply =
        application.appliedAt != null ||
        reached.contains(ApplicationStatus.applied);
    if (!didApply) continue;

    applied++;
    final bool didRespond = reached.any(_responses.contains);
    if (didRespond) responded++;
    if (reached.any(_interviews.contains)) interviews++;
    if (reached.any(_offers.contains)) offers++;

    final DateTime? appliedAt =
        application.appliedAt ??
        history
            .firstWhereOrNull(
              (ApplicationEvent e) => e.toStatus == ApplicationStatus.applied,
            )
            ?.createdAt;
    final ApplicationEvent? firstResponse = history.firstWhereOrNull(
      (ApplicationEvent e) =>
          _responses.contains(e.toStatus) &&
          (appliedAt == null || !e.createdAt.isBefore(appliedAt)),
    );
    if (appliedAt != null && firstResponse != null) {
      responseDays.add(
        firstResponse.createdAt.difference(appliedAt).inHours / 24,
      );
    }

    final String source = switch (item.job.source) {
      'link' || 'manual' => 'manual',
      final String other => other,
    };
    final (int sourceApplied, int sourceResponded) = bySource[source] ?? (0, 0);
    bySource[source] = (
      sourceApplied + 1,
      sourceResponded + (didRespond ? 1 : 0),
    );
  }

  // Brechas: lo que más se repite en «te falta» de las ofertas no descartadas.
  final Iterable<SavedJob> analyzed = jobs.where(
    (SavedJob s) => !s.job.dismissed && s.match != null,
  );
  final Map<String, int> counts = <String, int>{};
  final Map<String, String> labels = <String, String>{};
  for (final SavedJob saved in analyzed) {
    final Set<String> seenInJob = <String>{};
    for (final String missing in saved.match!.missing) {
      final String key = _gapKey(missing);
      if (key.isEmpty || !seenInJob.add(key)) continue;
      counts[key] = (counts[key] ?? 0) + 1;
      labels.putIfAbsent(key, () => missing.trim());
    }
  }
  final List<SkillGap> gaps = counts.entries
      .where((MapEntry<String, int> e) => e.value >= 2 || analyzed.length < 3)
      .sorted(
        (MapEntry<String, int> a, MapEntry<String, int> b) =>
            b.value.compareTo(a.value),
      )
      .take(maxGaps)
      .map(
        (MapEntry<String, int> e) =>
            SkillGap(label: labels[e.key]!, count: e.value),
      )
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
        : responseDays.reduce((double a, double b) => a + b) /
              responseDays.length,
    bySource: <SourceStats>[
      for (final MapEntry<String, (int, int)> entry in bySource.entries)
        SourceStats(
          source: entry.key,
          applied: entry.value.$1,
          responded: entry.value.$2,
        ),
    ]..sort((SourceStats a, SourceStats b) => b.applied.compareTo(a.applied)),
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
