import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rumbo/features/company/domain/repositories/company_brief_repository.dart';
import 'package:rumbo/features/company/infrastructure/repositories/supabase_company_brief_repository.dart';
import 'package:rumbo/shared/configurations/environment/env.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'company_providers.g.dart';

/// Nulo en modo local: necesita el servidor.
@Riverpod(keepAlive: true)
CompanyBriefRepository? companyBriefRepository(Ref ref) {
  if (!Env.hasBackend) return null;
  return SupabaseCompanyBriefRepository(Supabase.instance.client);
}
