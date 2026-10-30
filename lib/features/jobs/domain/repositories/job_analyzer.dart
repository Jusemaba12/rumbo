import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/shared/domain/result.dart';

/// Analiza una oferta con IA y la compara con el perfil, sin guardar nada.
abstract interface class JobAnalyzer {
  /// Falla con `NoDescriptionFailure` si no hay texto que analizar.
  Future<Result<SavedJob>> analyze({String? url, String? text});
}
