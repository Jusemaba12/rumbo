import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rumbo/features/applications/domain/repositories/applications_repository.dart';
import 'package:rumbo/features/applications/domain/repositories/ats_reader.dart';
import 'package:rumbo/features/applications/domain/repositories/resume_tailor.dart';
import 'package:rumbo/features/applications/domain/repositories/resume_versions_repository.dart';
import 'package:rumbo/features/applications/infrastructure/repositories/in_memory_applications_repository.dart';
import 'package:rumbo/features/applications/infrastructure/repositories/in_memory_resume_versions_repository.dart';
import 'package:rumbo/features/applications/infrastructure/repositories/supabase_applications_repository.dart';
import 'package:rumbo/features/applications/infrastructure/repositories/supabase_ats_reader.dart';
import 'package:rumbo/features/applications/infrastructure/repositories/supabase_resume_tailor.dart';
import 'package:rumbo/features/applications/infrastructure/repositories/supabase_resume_versions_repository.dart';
import 'package:rumbo/features/jobs/infrastructure/di/jobs_providers.dart';
import 'package:rumbo/shared/configurations/environment/env.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'applications_providers.g.dart';

@Riverpod(keepAlive: true)
ApplicationsRepository applicationsRepository(Ref ref) {
  if (!Env.hasBackend) {
    return InMemoryApplicationsRepository(ref.watch(jobsRepositoryProvider));
  }
  return SupabaseApplicationsRepository(Supabase.instance.client);
}

@Riverpod(keepAlive: true)
ResumeVersionsRepository resumeVersionsRepository(Ref ref) {
  if (!Env.hasBackend) return InMemoryResumeVersionsRepository();
  return SupabaseResumeVersionsRepository(Supabase.instance.client);
}

/// Nulo en modo local: adaptar necesita el servidor.
@Riverpod(keepAlive: true)
ResumeTailor? resumeTailor(Ref ref) {
  if (!Env.hasBackend) return null;
  return SupabaseResumeTailor(Supabase.instance.client.functions);
}

/// Nulo en modo local: necesita el servidor.
@Riverpod(keepAlive: true)
AtsReader? atsReader(Ref ref) {
  if (!Env.hasBackend) return null;
  return SupabaseAtsReader(Supabase.instance.client.functions);
}
