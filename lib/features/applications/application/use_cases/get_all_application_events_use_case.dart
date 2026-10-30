import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/applications/domain/entities/application.dart';
import 'package:rumbo/features/applications/domain/repositories/applications_repository.dart';
import 'package:rumbo/features/applications/infrastructure/di/applications_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'get_all_application_events_use_case.g.dart';

/// Historial de todos los procesos, agrupado por proceso (estadísticas).
class GetAllApplicationEventsUseCase {
  const GetAllApplicationEventsUseCase({required this._repository});

  final ApplicationsRepository _repository;

  Future<Result<Map<String, List<ApplicationEvent>>>> call() =>
      _repository.allEvents();
}

@Riverpod(keepAlive: true)
GetAllApplicationEventsUseCase getAllApplicationEventsUseCase(Ref ref) =>
    GetAllApplicationEventsUseCase(
      repository: ref.watch(applicationsRepositoryProvider),
    );
