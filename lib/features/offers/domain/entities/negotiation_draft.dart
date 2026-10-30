import 'package:freezed_annotation/freezed_annotation.dart';

part 'negotiation_draft.freezed.dart';

/// Respuesta a una oferta: correo con la contraoferta, argumentos y riesgos.
@Freezed(fromJson: false, toJson: false)
abstract class NegotiationDraft with _$NegotiationDraft {
  const factory NegotiationDraft({
    required String email,
    @Default(<String>[]) List<String> talkingPoints,
    @Default(<String>[]) List<String> risks,
  }) = _NegotiationDraft;

  factory NegotiationDraft.fromJson(Map<String, dynamic> json) {
    List<String> list(String key) => <String>[
      ...(json[key] as List<dynamic>? ?? const <dynamic>[]).whereType<String>(),
    ];
    return NegotiationDraft(
      email: json['email'] as String? ?? '',
      talkingPoints: list('talking_points'),
      risks: list('risks'),
    );
  }
}
