import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_brief.freezed.dart';

/// Ficha de la empresa de una oferta, generada con IA.
@Freezed(fromJson: false, toJson: false)
abstract class CompanyBrief with _$CompanyBrief {
  const factory CompanyBrief({
    required String summary,
    @Default([]) List<String> teamAndStack,
    @Default([]) List<String> culture,
    @Default([]) List<String> questionsToAsk,
    @Default([]) List<String> redFlags,
    @Default('') String generalKnowledge,
    DateTime? generatedAt,
  }) = _CompanyBrief;

  factory CompanyBrief.fromJson(Map<String, dynamic> json) {
    List<String> list(String key) => [
      ...(json[key] as List? ?? const []).whereType<String>(),
    ];
    final generated = json['generated_at'] as String?;
    return CompanyBrief(
      summary: json['summary'] as String? ?? '',
      teamAndStack: list('team_and_stack'),
      culture: list('culture'),
      questionsToAsk: list('questions_to_ask'),
      redFlags: list('red_flags'),
      generalKnowledge: json['general_knowledge'] as String? ?? '',
      generatedAt: generated == null
          ? null
          : DateTime.parse(generated).toLocal(),
    );
  }
}
