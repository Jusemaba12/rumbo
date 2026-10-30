import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rumbo/features/search/domain/repositories/search_repository.dart';
import 'package:rumbo/features/search/infrastructure/repositories/in_memory_search_repository.dart';
import 'package:rumbo/features/search/infrastructure/repositories/supabase_search_repository.dart';
import 'package:rumbo/shared/configurations/environment/env.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'search_providers.g.dart';

@Riverpod(keepAlive: true)
SearchRepository searchRepository(Ref ref) {
  if (!Env.hasBackend) return InMemorySearchRepository();
  return SupabaseSearchRepository(Supabase.instance.client);
}
