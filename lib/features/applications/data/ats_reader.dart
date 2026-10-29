import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/config/env.dart';

part 'ats_reader.g.dart';

/// Texto que un ATS extrae del PDF.
typedef AtsReading = ({String text, int pages});

/// Lee un PDF como lo haría un ATS (función `ats-read`, sin IA).
abstract interface class AtsReader {
  Future<AtsReading> read(Uint8List pdf);
}

class SupabaseAtsReader implements AtsReader {
  SupabaseAtsReader(this._functions);

  final FunctionsClient _functions;

  @override
  Future<AtsReading> read(Uint8List pdf) async {
    try {
      final response = await _functions.invoke(
        'ats-read',
        body: {'pdf_base64': base64Encode(pdf)},
      );
      final data = (response.data as Map).cast<String, dynamic>();
      return (
        text: data['text'] as String? ?? '',
        pages: data['pages'] as int? ?? 0,
      );
    } on FunctionException catch (error) {
      debugPrint('ats-read ${error.status}: ${error.details}');
      rethrow;
    }
  }
}

/// Nulo en modo local: necesita el servidor.
@Riverpod(keepAlive: true)
AtsReader? atsReader(Ref ref) {
  if (!Env.hasBackend) return null;
  return SupabaseAtsReader(Supabase.instance.client.functions);
}
