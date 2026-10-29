import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/ai/ai_errors.dart';
import '../../../core/config/env.dart';
import '../domain/company_brief.dart';

part 'company_brief_repository.g.dart';

abstract interface class CompanyBriefRepository {
  /// La ficha guardada, o nula si aún no se generó.
  Future<CompanyBrief?> load(String jobId);

  /// Genera (o regenera) la ficha con IA y la guarda.
  Future<CompanyBrief> generate(String jobId);
}

class SupabaseCompanyBriefRepository implements CompanyBriefRepository {
  SupabaseCompanyBriefRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<CompanyBrief?> load(String jobId) async {
    final row = await _client
        .from('jobs')
        .select('company_brief')
        .eq('id', jobId)
        .maybeSingle();
    final brief = row?['company_brief'];
    return brief is Map<String, dynamic> ? CompanyBrief.fromJson(brief) : null;
  }

  @override
  Future<CompanyBrief> generate(String jobId) async {
    try {
      final response = await invokeAi(
        _client.functions,
        'company-brief',
        body: {'job_id': jobId},
      );
      return CompanyBrief.fromJson(
        (response.data as Map).cast<String, dynamic>(),
      );
    } on FunctionException catch (error) {
      debugPrint('company-brief ${error.status}: ${error.details}');
      rethrow;
    }
  }
}

/// Nulo en modo local: necesita el servidor.
@Riverpod(keepAlive: true)
CompanyBriefRepository? companyBriefRepository(Ref ref) {
  if (!Env.hasBackend) return null;
  return SupabaseCompanyBriefRepository(Supabase.instance.client);
}

@Riverpod(keepAlive: true)
Future<CompanyBrief?> companyBrief(Ref ref, String jobId) async =>
    ref.watch(companyBriefRepositoryProvider)?.load(jobId);
