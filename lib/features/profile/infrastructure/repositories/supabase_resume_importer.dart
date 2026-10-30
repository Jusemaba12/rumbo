import 'dart:convert';
import 'dart:typed_data';

import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/domain/failures/profile_failures.dart';
import 'package:rumbo/features/profile/domain/repositories/resume_importer.dart';
import 'package:rumbo/features/profile/infrastructure/mappers/imported_profile_mapper.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/infrastructure/helpers/guard.dart';
import 'package:rumbo/shared/infrastructure/services/ai_invoker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Función `import-resume`.
class SupabaseResumeImporter implements ResumeImporter {
  SupabaseResumeImporter(this._functions);

  static const String _tag = 'SupabaseResumeImporter';

  final FunctionsClient _functions;

  @override
  Future<Result<ProfileData>> extract(Uint8List pdf) => guard(
    tag: _tag,
    run: () async {
      if (pdf.lengthInBytes > maxResumeBytes) {
        throw const FileTooLargeFailure();
      }
      try {
        return importedProfileFromJson(
          await invokeAiJson(
            functions: _functions,
            name: 'import-resume',
            body: <String, String>{'pdf_base64': base64Encode(pdf)},
          ),
        );
      } on FunctionException catch (error) {
        throw switch (error.status) {
          413 => const FileTooLargeFailure(),
          422 => const UnreadableFileFailure(),
          _ => error,
        };
      }
    },
  );
}
