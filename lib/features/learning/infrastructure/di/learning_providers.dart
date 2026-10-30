import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rumbo/features/learning/domain/repositories/learning_planner.dart';
import 'package:rumbo/features/learning/domain/repositories/learning_repository.dart';
import 'package:rumbo/features/learning/infrastructure/repositories/in_memory_learning_repository.dart';
import 'package:rumbo/features/learning/infrastructure/repositories/supabase_learning_planner.dart';
import 'package:rumbo/features/learning/infrastructure/repositories/supabase_learning_repository.dart';
import 'package:rumbo/shared/configurations/environment/env.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'learning_providers.g.dart';

@Riverpod(keepAlive: true)
LearningRepository learningRepository(Ref ref) {
  if (!Env.hasBackend) return InMemoryLearningRepository();
  return SupabaseLearningRepository(Supabase.instance.client);
}

/// Nulo en modo local: necesita el servidor.
@Riverpod(keepAlive: true)
LearningPlanner? learningPlanner(Ref ref) {
  if (!Env.hasBackend) return null;
  return SupabaseLearningPlanner(Supabase.instance.client.functions);
}
