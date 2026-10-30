import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_answer.freezed.dart';

/// Respuesta preparada para una pregunta habitual de entrevista.
@freezed
abstract class SavedAnswer with _$SavedAnswer {
  const factory SavedAnswer({
    @Default('') String id,
    required String question,
    @Default('') String answer,
    DateTime? updatedAt,
  }) = _SavedAnswer;
}
