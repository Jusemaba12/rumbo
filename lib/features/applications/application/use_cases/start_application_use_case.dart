import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/applications/domain/entities/application.dart';
import 'package:rumbo/features/applications/domain/entities/application_status.dart';
import 'package:rumbo/features/applications/domain/repositories/applications_repository.dart';
import 'package:rumbo/features/applications/domain/services/follow_up.dart';
import 'package:rumbo/features/applications/infrastructure/di/applications_providers.dart';
import 'package:rumbo/shared/application/services/clock.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'start_application_use_case.g.dart';

/// Crea el proceso de una oferta, o actualiza el que ya tenga.
///
/// Con [resumeVersionId] (HV preparada) pasa a «Preparando».
class StartApplicationUseCase {
  const StartApplicationUseCase({
    required this._repository,
    required this._clock,
  });

  final ApplicationsRepository _repository;
  final DateTime Function() _clock;

  Future<Result<Application>> call({
    required String jobId,
    Application? existing,
    String? resumeVersionId,
    String? coverLetter,
  }) {
    Application application =
        existing ?? Application(jobId: jobId, status: ApplicationStatus.saved);
    if (resumeVersionId != null) {
      application = application.copyWith(
        resumeVersionId: resumeVersionId,
        coverLetter: coverLetter,
      );
      if (application.status.canMoveTo(ApplicationStatus.preparing)) {
        application = applyStatusChange(
          application: application,
          to: ApplicationStatus.preparing,
          now: _clock(),
        );
      }
    }
    return _repository.save(application);
  }
}

@Riverpod(keepAlive: true)
StartApplicationUseCase startApplicationUseCase(Ref ref) =>
    StartApplicationUseCase(
      repository: ref.watch(applicationsRepositoryProvider),
      clock: ref.watch(clockProvider),
    );
