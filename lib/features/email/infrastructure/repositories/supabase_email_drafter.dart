import 'package:rumbo/features/email/domain/entities/email_draft.dart';
import 'package:rumbo/features/email/domain/repositories/email_drafter.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/infrastructure/helpers/guard.dart';
import 'package:rumbo/shared/infrastructure/services/ai_invoker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseEmailDrafter implements EmailDrafter {
  SupabaseEmailDrafter(this._functions);

  static const String _tag = 'SupabaseEmailDrafter';

  final FunctionsClient _functions;

  @override
  Future<Result<EmailDraft>> draft({
    required String applicationId,
    required EmailDraftKind kind,
    String notes = '',
  }) => _invoke(<String, dynamic>{
    'application_id': applicationId,
    'kind': kind.wire,
    'notes': notes,
  });

  @override
  Future<Result<EmailDraft>> draftApplication(
    String jobId, {
    String notes = '',
  }) => _invoke(<String, dynamic>{
    'job_id': jobId,
    'kind': 'application',
    'notes': notes,
  });

  Future<Result<EmailDraft>> _invoke(Map<String, dynamic> body) => guard(
    tag: _tag,
    run: () async => EmailDraft.fromJson(
      await invokeAiJson(
        functions: _functions,
        name: 'email-draft',
        body: body,
      ),
    ),
  );
}
