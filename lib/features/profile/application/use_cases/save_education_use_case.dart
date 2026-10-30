import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/profile/domain/entities/profile.dart';
import 'package:rumbo/features/profile/domain/repositories/profile_repository.dart';
import 'package:rumbo/features/profile/infrastructure/di/profile_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'save_education_use_case.g.dart';

/// Crea o reemplaza un estudio.
class SaveEducationUseCase {
  const SaveEducationUseCase({required this._repository});

  final ProfileRepository _repository;

  Future<Result<void>> call(Education education) =>
      _repository.saveEducation(education);
}

@Riverpod(keepAlive: true)
SaveEducationUseCase saveEducationUseCase(Ref ref) =>
    SaveEducationUseCase(repository: ref.watch(profileRepositoryProvider));
