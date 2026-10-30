import 'package:rumbo/features/offers/domain/entities/negotiation_draft.dart';
import 'package:rumbo/features/offers/domain/repositories/negotiator.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/infrastructure/helpers/guard.dart';
import 'package:rumbo/shared/infrastructure/services/ai_invoker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseNegotiator implements Negotiator {
  SupabaseNegotiator(this._functions);

  static const String _tag = 'SupabaseNegotiator';

  final FunctionsClient _functions;

  @override
  Future<Result<NegotiationDraft>> draft({
    required String applicationId,
    double? targetSalary,
    String priorities = '',
    String language = 'es',
  }) => guard(
    tag: _tag,
    run: () async => NegotiationDraft.fromJson(
      await invokeAiJson(
        functions: _functions,
        name: 'negotiation-draft',
        body: <String, Object?>{
          'application_id': applicationId,
          'target_salary': targetSalary,
          'priorities': priorities,
          'language': language,
        },
      ),
    ),
  );
}
