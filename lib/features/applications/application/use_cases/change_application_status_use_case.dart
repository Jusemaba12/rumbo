import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/applications/domain/entities/application.dart';
import 'package:rumbo/features/applications/domain/entities/application_status.dart';
import 'package:rumbo/features/applications/domain/repositories/applications_repository.dart';
import 'package:rumbo/features/applications/domain/services/follow_up.dart';
import 'package:rumbo/features/applications/infrastructure/di/applications_providers.dart';
import 'package:rumbo/shared/application/services/clock.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'change_application_status_use_case.g.dart';

/// Cambia el estado de un proceso con sus efectos (fecha de postulación y
/// seguimiento; ver `applyStatusChange`).
class ChangeApplicationStatusUseCase {
  const ChangeApplicationStatusUseCase({
    required this._repository,
    required this._clock,
  });

  final ApplicationsRepository _repository;
  final DateTime Function() _clock;

  Future<Result<Application>> call({
    required Application application,
    required ApplicationStatus to,
  }) => _repository.save(
    applyStatusChange(application: application, to: to, now: _clock()),
  );
}

@Riverpod(keepAlive: true)
ChangeApplicationStatusUseCase changeApplicationStatusUseCase(Ref ref) =>
    ChangeApplicationStatusUseCase(
      repository: ref.watch(applicationsRepositoryProvider),
      clock: ref.watch(clockProvider),
    );
