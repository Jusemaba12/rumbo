import 'package:rumbo/features/interviews/domain/entities/interview.dart';
import 'package:rumbo/shared/domain/result.dart';

abstract interface class InterviewsRepository {
  /// Todas las entrevistas, por fecha.
  Future<Result<List<Interview>>> list();

  /// Crea la entrevista si no tiene id o la actualiza si lo tiene.
  Future<Result<void>> save(Interview interview);

  Future<Result<void>> delete(String id);
}
