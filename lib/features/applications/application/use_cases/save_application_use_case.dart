import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/applications/domain/entities/application.dart';
import 'package:rumbo/features/applications/domain/repositories/applications_repository.dart';
import 'package:rumbo/features/applications/infrastructure/di/applications_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'save_application_use_case.g.dart';

/// Crea o actualiza un proceso (notas, seguimiento, HV) tal cual.
class SaveApplicationUseCase {
  const SaveApplicationUseCase({required this._repository});

  final ApplicationsRepository _repository;

  Future<Result<Application>> call(Application application) =>
      _repository.save(application);
}

@Riverpod(keepAlive: true)
SaveApplicationUseCase saveApplicationUseCase(Ref ref) =>
    SaveApplicationUseCase(
      repository: ref.watch(applicationsRepositoryProvider),
    );
