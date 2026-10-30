import 'package:rumbo/features/applications/domain/entities/application_draft.dart';
import 'package:rumbo/shared/domain/result.dart';

/// Versiones de la HV adaptadas a cada oferta.
abstract interface class ResumeVersionsRepository {
  /// Guarda la versión y devuelve su id.
  Future<Result<String>> save(ApplicationDraft draft);

  /// Última HV adaptada guardada para la oferta; nula si no hay.
  Future<Result<ApplicationDraft?>> latestForJob(String jobId);
}
