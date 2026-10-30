import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/applications/application/use_cases/get_all_application_events_use_case.dart';
import 'package:rumbo/features/applications/domain/entities/application.dart';
import 'package:rumbo/features/applications/presentation/providers/applications/applications_provider.dart';
import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/features/jobs/presentation/providers/jobs/jobs_provider.dart';
import 'package:rumbo/features/stats/domain/services/search_stats.dart';

part 'search_stats_provider.g.dart';

/// Embudo, tiempos de respuesta y brechas de la búsqueda.
@Riverpod(keepAlive: true)
Future<SearchStats> searchStats(Ref ref) async {
  final List<ApplicationWithJob> applications = await ref.watch(
    applicationsControllerProvider.future,
  );
  final List<SavedJob> jobs = await ref.watch(jobsControllerProvider.future);
  final Map<String, List<ApplicationEvent>> events = (await ref.watch(
    getAllApplicationEventsUseCaseProvider,
  )()).getOrThrow();
  return computeStats(applications: applications, events: events, jobs: jobs);
}
