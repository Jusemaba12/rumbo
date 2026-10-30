import 'package:freezed_annotation/freezed_annotation.dart';

part 'resume_keyword.freezed.dart';

/// Palabra clave que los ATS buscan para los cargos objetivo.
@Freezed(fromJson: false, toJson: false)
abstract class ResumeKeyword with _$ResumeKeyword {
  const factory ResumeKeyword({
    required String keyword,
    required bool important,
    @Default('') String reason,

    /// Otras formas en que aparece (RESTful, APIs REST…), según la IA.
    @Default(<String>[]) List<String> aliases,
  }) = _ResumeKeyword;

  factory ResumeKeyword.fromJson(Map<String, dynamic> json) => ResumeKeyword(
    keyword: json['keyword'] as String,
    important: json['importance'] == 'high',
    reason: json['reason'] as String? ?? '',
    aliases: <String>[
      for (final dynamic alias
          in json['aliases'] as List<dynamic>? ?? const <dynamic>[])
        '$alias',
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
