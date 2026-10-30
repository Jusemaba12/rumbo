import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/applications/domain/entities/application.dart';
import 'package:rumbo/features/applications/domain/repositories/applications_repository.dart';
import 'package:rumbo/features/applications/infrastructure/di/applications_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'get_application_events_use_case.g.dart';

/// Historial de estados de un proceso, del más antiguo al más reciente.
class GetApplicationEventsUseCase {
  const GetApplicationEventsUseCase({required this._repository});

  final ApplicationsRepository _repository;

  Future<Result<List<ApplicationEvent>>> call(String applicationId) =>
      _repository.events(applicationId);
}

@Riverpod(keepAlive: true)
GetApplicationEventsUseCase getApplicationEventsUseCase(Ref ref) =>
    GetApplicationEventsUseCase(
      repository: ref.watch(applicationsRepositoryProvider),
    );
