import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rumbo/features/practice/domain/repositories/interview_coach.dart';
import 'package:rumbo/features/practice/infrastructure/repositories/supabase_interview_coach.dart';
import 'package:rumbo/shared/configurations/environment/env.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'practice_providers.g.dart';

/// Nulo en modo local: practicar necesita el servidor.
@Riverpod(keepAlive: true)
InterviewCoach? interviewCoach(Ref ref) {
  if (!Env.hasBackend) return null;
  return SupabaseInterviewCoach(Supabase.instance.client.functions);
}
