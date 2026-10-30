import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rumbo/features/answers/domain/repositories/answers_repository.dart';
import 'package:rumbo/features/answers/infrastructure/repositories/in_memory_answers_repository.dart';
import 'package:rumbo/features/answers/infrastructure/repositories/supabase_answers_repository.dart';
import 'package:rumbo/shared/configurations/environment/env.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'answers_providers.g.dart';

@Riverpod(keepAlive: true)
AnswersRepository answersRepository(Ref ref) {
  if (!Env.hasBackend) return InMemoryAnswersRepository();
  return SupabaseAnswersRepository(Supabase.instance.client);
}
