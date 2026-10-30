import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rumbo/features/jobs/domain/repositories/job_analyzer.dart';
import 'package:rumbo/features/jobs/domain/repositories/jobs_repository.dart';
import 'package:rumbo/features/jobs/infrastructure/repositories/in_memory_jobs_repository.dart';
import 'package:rumbo/features/jobs/infrastructure/repositories/supabase_job_analyzer.dart';
import 'package:rumbo/features/jobs/infrastructure/repositories/supabase_jobs_repository.dart';
import 'package:rumbo/shared/configurations/environment/env.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'jobs_providers.g.dart';

@Riverpod(keepAlive: true)
JobsRepository jobsRepository(Ref ref) {
  if (!Env.hasBackend) return InMemoryJobsRepository();
  return SupabaseJobsRepository(Supabase.instance.client);
}

/// Nulo en modo local: analizar necesita el servidor.
@Riverpod(keepAlive: true)
JobAnalyzer? jobAnalyzer(Ref ref) {
  if (!Env.hasBackend) return null;
  return SupabaseJobAnalyzer(Supabase.instance.client.functions);
}
