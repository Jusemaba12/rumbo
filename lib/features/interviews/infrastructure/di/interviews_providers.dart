import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rumbo/features/interviews/domain/repositories/interviews_repository.dart';
import 'package:rumbo/features/interviews/infrastructure/repositories/in_memory_interviews_repository.dart';
import 'package:rumbo/features/interviews/infrastructure/repositories/supabase_interviews_repository.dart';
import 'package:rumbo/shared/configurations/environment/env.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'interviews_providers.g.dart';

@Riverpod(keepAlive: true)
InterviewsRepository interviewsRepository(Ref ref) {
  if (!Env.hasBackend) return InMemoryInterviewsRepository();
  return SupabaseInterviewsRepository(Supabase.instance.client);
}
