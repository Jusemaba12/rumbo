import 'package:rumbo/features/jobs/domain/entities/job.dart';
import 'package:rumbo/shared/domain/result.dart';

/// Ofertas guardadas y sugeridas del usuario.
abstract interface class JobsRepository {
  /// Ofertas guardadas, las más recientes primero.
  Future<Result<List<SavedJob>>> list();

  /// Guarda una oferta nueva con su compatibilidad. Falla con
  /// `DuplicateFailure` si ya hay una con la misma empresa, cargo y
  /// ubicación.
  Future<Result<void>> save(SavedJob saved);

  Future<Result<void>> delete(String jobId);

  /// Pasa una sugerencia a ofertas guardadas.
  Future<Result<void>> keepSuggestion(String jobId);

  /// Oculta una sugerencia sin borrarla, para que no vuelva a aparecer.
  Future<Result<void>> dismissSuggestion(String jobId);

  /// Devuelve a sugerencias una oferta descartada.
  Future<Result<void>> restoreSuggestion(String jobId);

  /// Guarda el contacto del reclutador y la forma de postular.
  Future<Result<void>> updateContact(Job job);

  /// Sustituye la descripción y lo que sale de ella (requisitos, salario,
  /// modalidad) y la compatibilidad de una oferta ya guardada.
  Future<Result<void>> complete(SavedJob saved);
}
