import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/applications/domain/entities/application.dart';
import 'package:rumbo/features/applications/domain/repositories/applications_repository.dart';
import 'package:rumbo/features/applications/domain/services/follow_up.dart';
import 'package:rumbo/features/applications/infrastructure/di/applications_providers.dart';
import 'package:rumbo/shared/application/services/clock.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'get_applications_use_case.g.dart';

/// Procesos con su oferta, en el orden del tablero (seguimientos vencidos
/// primero; ver `compareForBoard`).
class GetApplicationsUseCase {
  const GetApplicationsUseCase({
    required this._repository,
    required this._clock,
  });

  final ApplicationsRepository _repository;
  final DateTime Function() _clock;

  Future<Result<List<ApplicationWithJob>>> call() async {
    final DateTime now = _clock();
    return (await _repository.list()).map(
      (List<ApplicationWithJob> items) => items
        ..sort(
          (ApplicationWithJob a, ApplicationWithJob b) =>
              compareForBoard(a: a.application, b: b.application, now: now),
        ),
    );
  }
}

@Riverpod(keepAlive: true)
GetApplicationsUseCase getApplicationsUseCase(Ref ref) =>
    GetApplicationsUseCase(
      repository: ref.watch(applicationsRepositoryProvider),
      clock: ref.watch(clockProvider),
    );
