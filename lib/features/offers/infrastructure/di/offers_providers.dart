import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rumbo/features/offers/domain/repositories/negotiator.dart';
import 'package:rumbo/features/offers/domain/repositories/offers_repository.dart';
import 'package:rumbo/features/offers/infrastructure/repositories/in_memory_offers_repository.dart';
import 'package:rumbo/features/offers/infrastructure/repositories/supabase_negotiator.dart';
import 'package:rumbo/features/offers/infrastructure/repositories/supabase_offers_repository.dart';
import 'package:rumbo/shared/configurations/environment/env.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'offers_providers.g.dart';

@Riverpod(keepAlive: true)
OffersRepository offersRepository(Ref ref) {
  if (!Env.hasBackend) return InMemoryOffersRepository();
  return SupabaseOffersRepository(Supabase.instance.client);
}

/// Nulo en modo local: necesita el servidor.
@Riverpod(keepAlive: true)
Negotiator? negotiator(Ref ref) {
  if (!Env.hasBackend) return null;
  return SupabaseNegotiator(Supabase.instance.client.functions);
}
