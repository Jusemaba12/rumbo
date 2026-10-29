import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/ai/ai_errors.dart';
import '../../../core/config/env.dart';

part 'email_drafter.g.dart';
part 'email_drafter.freezed.dart';

/// Correos que se pueden redactar para un proceso.
enum EmailDraftKind {
  followUp('follow_up'),
  thankYou('thank_you'),
  rejectionReply('rejection_reply');

  const EmailDraftKind(this.wire);

  final String wire;
}

/// Borrador listo para revisar; [to] vacío si no se conoce el destinatario.
@Freezed(fromJson: false, toJson: false)
abstract class EmailDraft with _$EmailDraft {
  const factory EmailDraft({
    required String subject,
    required String body,
    @Default('') String to,
  }) = _EmailDraft;

  factory EmailDraft.fromJson(Map<String, dynamic> json) => EmailDraft(
    subject: json['subject'] as String? ?? '',
    body: json['body'] as String? ?? '',
    to: json['to'] as String? ?? '',
  );
}

enum EmailDraftFailure { dailyLimit, rateLimited, busy, other }

class EmailDraftException implements Exception {
  const EmailDraftException(this.reason);

  final EmailDraftFailure reason;
}

abstract interface class EmailDrafter {
  Future<EmailDraft> draft(
    String applicationId,
    EmailDraftKind kind, {
    String notes = '',
  });

  /// Correo para postular a una oferta: asunto que pide la publicación,
  /// presentación y expectativa salarial si la piden.
  Future<EmailDraft> draftApplication(String jobId, {String notes = ''});
}

class SupabaseEmailDrafter implements EmailDrafter {
  SupabaseEmailDrafter(this._functions);

  final FunctionsClient _functions;

  @override
  Future<EmailDraft> draft(
    String applicationId,
    EmailDraftKind kind, {
    String notes = '',
  }) => _invoke({
    'application_id': applicationId,
    'kind': kind.wire,
    'notes': notes,
  });

  @override
  Future<EmailDraft> draftApplication(String jobId, {String notes = ''}) =>
      _invoke({'job_id': jobId, 'kind': 'application', 'notes': notes});

  Future<EmailDraft> _invoke(Map<String, dynamic> body) async {
    try {
      final response = await invokeAi(_functions, 'email-draft', body: body);
      return EmailDraft.fromJson(
        (response.data as Map).cast<String, dynamic>(),
      );
    } on FunctionException catch (error) {
      debugPrint('email-draft ${error.status}: ${error.details}');
      if (isDailyLimit(error)) {
        throw const EmailDraftException(EmailDraftFailure.dailyLimit);
      }
      throw EmailDraftException(switch (error.status) {
        429 => EmailDraftFailure.rateLimited,
        503 => EmailDraftFailure.busy,
        _ => EmailDraftFailure.other,
      });
    }
  }
}

/// Nulo en modo local: necesita el servidor.
@Riverpod(keepAlive: true)
EmailDrafter? emailDrafter(Ref ref) {
  if (!Env.hasBackend) return null;
  return SupabaseEmailDrafter(Supabase.instance.client.functions);
}

/// Enlace mailto: abre la app de correo con el borrador puesto.
Uri mailtoUri({
  required String to,
  required String subject,
  required String body,
}) => Uri(
  scheme: 'mailto',
  path: to,
  // Uri codifica los espacios como «+»; algunos clientes no lo entienden.
  query: [
    'subject=${Uri.encodeComponent(subject)}',
    'body=${Uri.encodeComponent(body)}',
  ].join('&'),
);
