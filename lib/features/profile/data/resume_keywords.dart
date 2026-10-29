import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/ai/ai_errors.dart';
import '../../../core/config/env.dart';

part 'resume_keywords.g.dart';
part 'resume_keywords.freezed.dart';

/// Palabra clave que los ATS buscan para los cargos objetivo.
@Freezed(fromJson: false, toJson: false)
abstract class ResumeKeyword with _$ResumeKeyword {
  const factory ResumeKeyword({
    required String keyword,
    required bool important,
    @Default('') String reason,

    /// Otras formas en que aparece (RESTful, APIs REST…), según la IA.
    @Default([]) List<String> aliases,
  }) = _ResumeKeyword;

  factory ResumeKeyword.fromJson(Map<String, dynamic> json) => ResumeKeyword(
    keyword: json['keyword'] as String,
    important: json['importance'] == 'high',
    reason: json['reason'] as String? ?? '',
    aliases: [
      for (final alias in json['aliases'] as List? ?? const []) '$alias',
    ],
  );
}

/// Palabras clave con la fecha en que se pidieron a la IA.
@freezed
abstract class KeywordsResult with _$KeywordsResult {
  const factory KeywordsResult({
    required List<ResumeKeyword> keywords,
    DateTime? updatedAt,
  }) = _KeywordsResult;
}

List<ResumeKeyword> _keywordsFrom(Object? list) => [
  for (final item in list as List? ?? const [])
    ResumeKeyword.fromJson((item as Map).cast<String, dynamic>()),
];

enum KeywordsFailure { noRoles, rateLimited, dailyLimit, busy, other }

class KeywordsException implements Exception {
  const KeywordsException(this.reason);

  final KeywordsFailure reason;
}

abstract interface class ResumeKeywordsSource {
  /// Las palabras clave guardadas, sin gastar IA; nulo si no hay.
  Future<KeywordsResult?> cached();

  /// Pide las palabras clave de los cargos de las preferencias. Sin [force]
  /// el servidor devuelve las guardadas si siguen valiendo.
  Future<KeywordsResult> fetch({bool force = false});
}

class SupabaseResumeKeywordsSource implements ResumeKeywordsSource {
  SupabaseResumeKeywordsSource(this._functions);

  final FunctionsClient _functions;

  @override
  Future<KeywordsResult?> cached() async {
    try {
      final row = await Supabase.instance.client
          .from('resume_keywords')
          .select('keywords, created_at')
          .maybeSingle();
      if (row == null) return null;
      return KeywordsResult(
        keywords: _keywordsFrom(row['keywords']),
        updatedAt: DateTime.tryParse(row['created_at'] as String? ?? ''),
      );
    } catch (error) {
      // Sin la tabla (migración pendiente) o sin red: se piden al pulsar.
      debugPrint('resume_keywords cache: $error');
      return null;
    }
  }

  @override
  Future<KeywordsResult> fetch({bool force = false}) async {
    try {
      final response = await invokeAi(
        _functions,
        'resume-keywords',
        body: {'force': force},
      );
      final data = (response.data as Map).cast<String, dynamic>();
      return KeywordsResult(
        keywords: _keywordsFrom(data['keywords']),
        updatedAt: DateTime.tryParse(data['created_at'] as String? ?? ''),
      );
    } on FunctionException catch (error) {
      debugPrint('resume-keywords ${error.status}: ${error.details}');
      if (isDailyLimit(error)) {
        throw const KeywordsException(KeywordsFailure.dailyLimit);
      }
      final code = error.details is Map
          ? (error.details as Map)['error']
          : null;
      throw KeywordsException(switch ((error.status, code)) {
        (422, 'no_roles') => KeywordsFailure.noRoles,
        (429, _) => KeywordsFailure.rateLimited,
        (503, _) => KeywordsFailure.busy,
        _ => KeywordsFailure.other,
      });
    }
  }
}

/// Nulo en modo local: necesita el servidor.
@Riverpod(keepAlive: true)
ResumeKeywordsSource? resumeKeywordsSource(Ref ref) {
  if (!Env.hasBackend) return null;
  return SupabaseResumeKeywordsSource(Supabase.instance.client.functions);
}

/// Palabras clave de los cargos: al abrir se leen las guardadas (sin gastar
/// IA); el botón las pide o las vuelve a generar.
@Riverpod(keepAlive: true)
class ResumeKeywords extends _$ResumeKeywords {
  @override
  Future<KeywordsResult?> build() async =>
      ref.watch(resumeKeywordsSourceProvider)?.cached();

  Future<void> load({bool force = false}) async {
    final source = ref.read(resumeKeywordsSourceProvider);
    if (source == null) return;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => source.fetch(force: force));
  }
}
