import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/applications/domain/repositories/applications_repository.dart';
import 'package:rumbo/features/applications/infrastructure/di/applications_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'delete_application_use_case.g.dart';

/// Borra un proceso y su historial.
class DeleteApplicationUseCase {
  const DeleteApplicationUseCase({required this._repository});

  final ApplicationsRepository _repository;

  Future<Result<void>> call(String id) => _repository.delete(id);
}

@Riverpod(keepAlive: true)
DeleteApplicationUseCase deleteApplicationUseCase(Ref ref) =>
    DeleteApplicationUseCase(
      repository: ref.watch(applicationsRepositoryProvider),
    );
