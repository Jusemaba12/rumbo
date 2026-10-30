import 'package:rumbo/features/answers/domain/entities/saved_answer.dart';
import 'package:rumbo/shared/domain/result.dart';

/// Banco de respuestas a preguntas habituales de entrevista.
abstract interface class AnswersRepository {
  /// Las editadas más recientemente primero.
  Future<Result<List<SavedAnswer>>> list();

  /// Crea la respuesta si no tiene id o la actualiza si lo tiene.
  Future<Result<void>> save(SavedAnswer answer);

  Future<Result<void>> delete(String id);
}
