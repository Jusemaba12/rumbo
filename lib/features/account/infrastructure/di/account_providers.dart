import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rumbo/features/account/domain/repositories/account_repository.dart';
import 'package:rumbo/features/account/infrastructure/repositories/local_account_repository.dart';
import 'package:rumbo/features/account/infrastructure/repositories/supabase_account_repository.dart';
import 'package:rumbo/shared/configurations/environment/env.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'account_providers.g.dart';

@Riverpod(keepAlive: true)
AccountRepository accountRepository(Ref ref) {
  if (!Env.hasBackend) return LocalAccountRepository();
  return SupabaseAccountRepository(Supabase.instance.client);
}
