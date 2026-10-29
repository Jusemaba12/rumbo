import 'package:freezed_annotation/freezed_annotation.dart';

import 'job.dart';

part 'job_filter.freezed.dart';

/// Filtros rápidos de la lista de ofertas. Sin filtros activos no quita nada.
@freezed
abstract class JobFilter with _$JobFilter {
  const JobFilter._();

  const factory JobFilter({
    @Default(false) bool remoteOnly,
    @Default(false) bool goodMatchOnly,
    @Default(false) bool recentOnly,

    /// Portal de origen (`job.source`); nulo para todos.
    String? source,
  }) = _JobFilter;

  /// Nota mínima del filtro «Nota ≥ 60».
  static const minScore = 60;

  /// Días del filtro «Últimos 7 días».
  static const recentDays = 7;

  bool get isActive =>
      remoteOnly || goodMatchOnly || recentOnly || source != null;

  bool matches(SavedJob saved, DateTime now) {
    final job = saved.job;
    if (remoteOnly && job.workMode != WorkMode.remote) return false;
    if (goodMatchOnly && (saved.match?.score ?? 0) < minScore) return false;
    if (recentOnly) {
      final created = job.createdAt;
      if (created == null ||
          now.difference(created) > const Duration(days: recentDays)) {
        return false;
      }
    }
    if (source != null && job.source != source) return false;
    return true;
  }

  List<SavedJob> apply(List<SavedJob> jobs, DateTime now) =>
      jobs.where((saved) => matches(saved, now)).toList();
}

/// Días que se muestran las sugerencias descartadas para poder recuperarlas.
const dismissedWindow = Duration(days: 30);

/// Sugerencias descartadas recientes, las más nuevas primero.
List<SavedJob> recentlyDismissed(List<SavedJob> jobs, DateTime now) => jobs
    .where(
      (saved) =>
          saved.job.discovered &&
          saved.job.dismissed &&
          (saved.job.createdAt == null ||
              now.difference(saved.job.createdAt!) <= dismissedWindow),
    )
    .toList();
