import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rumbo/features/email/domain/repositories/email_drafter.dart';
import 'package:rumbo/features/email/domain/repositories/email_repository.dart';
import 'package:rumbo/features/email/infrastructure/repositories/in_memory_email_repository.dart';
import 'package:rumbo/features/email/infrastructure/repositories/supabase_email_drafter.dart';
import 'package:rumbo/features/email/infrastructure/repositories/supabase_email_repository.dart';
import 'package:rumbo/shared/configurations/environment/env.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'email_providers.g.dart';

@Riverpod(keepAlive: true)
EmailRepository emailRepository(Ref ref) {
  if (!Env.hasBackend) return InMemoryEmailRepository();
  return SupabaseEmailRepository(Supabase.instance.client);
}

/// Nulo en modo local: necesita el servidor.
@Riverpod(keepAlive: true)
EmailDrafter? emailDrafter(Ref ref) {
  if (!Env.hasBackend) return null;
  return SupabaseEmailDrafter(Supabase.instance.client.functions);
}
