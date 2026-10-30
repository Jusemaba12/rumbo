import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_draft.freezed.dart';

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
