import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rumbo/features/auth/domain/repositories/auth_repository.dart';
import 'package:rumbo/features/auth/infrastructure/repositories/local_auth_repository.dart';
import 'package:rumbo/features/auth/infrastructure/repositories/supabase_auth_repository.dart';
import 'package:rumbo/shared/configurations/environment/env.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_providers.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  if (!Env.hasBackend) return const LocalAuthRepository();
  return SupabaseAuthRepository(Supabase.instance.client.auth);
}

/// Emite cada vez que se entra o se sale. Los providers con datos del
/// usuario lo observan para volver a leer al cambiar de cuenta.
@Riverpod(keepAlive: true)
Stream<bool> sessionChanges(Ref ref) =>
    ref.watch(authRepositoryProvider).signedInChanges;
