import 'dart:convert';
import 'dart:typed_data';

import 'package:rumbo/features/applications/domain/repositories/ats_reader.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/infrastructure/helpers/guard.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Función `ats-read` (pdf.js, sin IA).
class SupabaseAtsReader implements AtsReader {
  SupabaseAtsReader(this._functions);

  static const String _tag = 'SupabaseAtsReader';

  final FunctionsClient _functions;

  @override
  Future<Result<AtsReading>> read(Uint8List pdf) => guard(
    tag: _tag,
    run: () async {
      final FunctionResponse response = await _functions.invoke(
        'ats-read',
        body: <String, String>{'pdf_base64': base64Encode(pdf)},
      );
      final Map<String, dynamic> data = (response.data as Map<dynamic, dynamic>)
          .cast<String, dynamic>();
      return (
        text: data['text'] as String? ?? '',
        pages: data['pages'] as int? ?? 0,
      );
    },
  );
}
