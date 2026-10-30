import 'package:rumbo/features/company/domain/entities/company_brief.dart';
import 'package:rumbo/features/company/domain/repositories/company_brief_repository.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/infrastructure/helpers/guard.dart';
import 'package:rumbo/shared/infrastructure/services/ai_invoker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseCompanyBriefRepository implements CompanyBriefRepository {
  SupabaseCompanyBriefRepository(this._client);

  static const String _tag = 'SupabaseCompanyBriefRepository';

  final SupabaseClient _client;

  @override
  Future<Result<CompanyBrief?>> load(String jobId) => guard(
    tag: _tag,
    run: () async {
      final PostgrestMap? row = await _client
          .from('jobs')
          .select('company_brief')
          .eq('id', jobId)
          .maybeSingle();
      final Object? brief = row?['company_brief'];
      return brief is Map<String, dynamic>
          ? CompanyBrief.fromJson(brief)
          : null;
    },
  );

  @override
  Future<Result<CompanyBrief>> generate(String jobId) => guard(
    tag: _tag,
    run: () async => CompanyBrief.fromJson(
      await invokeAiJson(
        functions: _client.functions,
        name: 'company-brief',
        body: <String, String>{'job_id': jobId},
      ),
    ),
  );
}
