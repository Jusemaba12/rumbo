import 'package:rumbo/features/applications/domain/entities/application_draft.dart';
import 'package:rumbo/shared/domain/result.dart';

/// Adapta la HV a una oferta guardada y escribe la carta, sin guardar nada.
abstract interface class ResumeTailor {
  /// Falla con `EmptyProfileFailure` si el perfil está vacío.
  Future<Result<ApplicationDraft>> tailor(String jobId);
}
