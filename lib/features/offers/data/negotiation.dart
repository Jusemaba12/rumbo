import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/ai/ai_errors.dart';
import '../../../core/config/env.dart';

part 'negotiation.g.dart';
part 'negotiation.freezed.dart';

@Freezed(fromJson: false, toJson: false)
abstract class NegotiationDraft with _$NegotiationDraft {
  const factory NegotiationDraft({
    required String email,
    @Default([]) List<String> talkingPoints,
    @Default([]) List<String> risks,
  }) = _NegotiationDraft;

  factory NegotiationDraft.fromJson(Map<String, dynamic> json) {
    List<String> list(String key) => [
      ...(json[key] as List? ?? const []).whereType<String>(),
    ];
    return NegotiationDraft(
      email: json['email'] as String? ?? '',
      talkingPoints: list('talking_points'),
      risks: list('risks'),
    );
  }
}

abstract interface class Negotiator {
  Future<NegotiationDraft> draft({
    required String applicationId,
    double? targetSalary,
    String priorities = '',
    String language = 'es',
  });
}

class SupabaseNegotiator implements Negotiator {
  SupabaseNegotiator(this._functions);

  final FunctionsClient _functions;

  @override
  Future<NegotiationDraft> draft({
    required String applicationId,
    double? targetSalary,
    String priorities = '',
    String language = 'es',
  }) async {
    final response = await invokeAi(
      _functions,
      'negotiation-draft',
      body: {
        'application_id': applicationId,
        'target_salary': targetSalary,
        'priorities': priorities,
        'language': language,
      },
    );
    return NegotiationDraft.fromJson(
      (response.data as Map).cast<String, dynamic>(),
    );
  }
}

/// Nulo en modo local: necesita el servidor.
@Riverpod(keepAlive: true)
Negotiator? negotiator(Ref ref) {
  if (!Env.hasBackend) return null;
  return SupabaseNegotiator(Supabase.instance.client.functions);
}
