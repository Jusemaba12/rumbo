import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rumbo/features/profile/domain/repositories/achievement_rewriter.dart';
import 'package:rumbo/features/profile/domain/repositories/profile_repository.dart';
import 'package:rumbo/features/profile/domain/repositories/resume_importer.dart';
import 'package:rumbo/features/profile/domain/repositories/resume_keywords_source.dart';
import 'package:rumbo/features/profile/domain/repositories/review_history_store.dart';
import 'package:rumbo/features/profile/infrastructure/repositories/in_memory_profile_repository.dart';
import 'package:rumbo/features/profile/infrastructure/repositories/supabase_achievement_rewriter.dart';
import 'package:rumbo/features/profile/infrastructure/repositories/supabase_profile_repository.dart';
import 'package:rumbo/features/profile/infrastructure/repositories/supabase_resume_importer.dart';
import 'package:rumbo/features/profile/infrastructure/repositories/supabase_resume_keywords_source.dart';
import 'package:rumbo/features/profile/infrastructure/services/prefs_review_history_store.dart';
import 'package:rumbo/shared/configurations/environment/env.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'profile_providers.g.dart';

@Riverpod(keepAlive: true)
ProfileRepository profileRepository(Ref ref) {
  if (!Env.hasBackend) return InMemoryProfileRepository();
  return SupabaseProfileRepository(Supabase.instance.client);
}

/// Nulo en modo local: importar necesita el servidor.
@Riverpod(keepAlive: true)
ResumeImporter? resumeImporter(Ref ref) {
  if (!Env.hasBackend) return null;
  return SupabaseResumeImporter(Supabase.instance.client.functions);
}

/// Nulo en modo local: necesita el servidor.
@Riverpod(keepAlive: true)
AchievementRewriter? achievementRewriter(Ref ref) {
  if (!Env.hasBackend) return null;
  return SupabaseAchievementRewriter(Supabase.instance.client.functions);
}

/// Nulo en modo local: necesita el servidor.
@Riverpod(keepAlive: true)
ResumeKeywordsSource? resumeKeywordsSource(Ref ref) {
  if (!Env.hasBackend) return null;
  return SupabaseResumeKeywordsSource(Supabase.instance.client);
}

@Riverpod(keepAlive: true)
ReviewHistoryStore reviewHistoryStore(Ref ref) => PrefsReviewHistoryStore();
