import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/profile/domain/repositories/profile_repository.dart';
import 'package:rumbo/features/profile/infrastructure/di/profile_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'delete_education_use_case.g.dart';

/// Borra un estudio.
class DeleteEducationUseCase {
  const DeleteEducationUseCase({required this._repository});

  final ProfileRepository _repository;

  Future<Result<void>> call(String id) => _repository.deleteEducation(id);
}

@Riverpod(keepAlive: true)
DeleteEducationUseCase deleteEducationUseCase(Ref ref) =>
    DeleteEducationUseCase(repository: ref.watch(profileRepositoryProvider));
