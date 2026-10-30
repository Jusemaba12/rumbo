import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/applications/domain/entities/application_draft.dart';
import 'package:rumbo/features/applications/domain/repositories/resume_tailor.dart';
import 'package:rumbo/features/applications/infrastructure/di/applications_providers.dart';
import 'package:rumbo/shared/domain/failures/failure.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'tailor_resume_use_case.g.dart';

/// Adapta la HV a una oferta y escribe la carta con IA. No guarda nada: el
/// usuario revisa y confirma.
class TailorResumeUseCase {
  const TailorResumeUseCase({required this._tailor});

  final ResumeTailor? _tailor;

  /// Falso en modo local, donde no hay IA.
  bool get isAvailable => _tailor != null;

  Future<Result<ApplicationDraft>> call(String jobId) async =>
      await _tailor?.tailor(jobId) ??
      const Err<ApplicationDraft>(BackendUnavailableFailure());
}

@Riverpod(keepAlive: true)
TailorResumeUseCase tailorResumeUseCase(Ref ref) =>
    TailorResumeUseCase(tailor: ref.watch(resumeTailorProvider));
