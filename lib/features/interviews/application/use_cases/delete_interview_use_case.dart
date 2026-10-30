import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/interviews/domain/repositories/interviews_repository.dart';
import 'package:rumbo/features/interviews/infrastructure/di/interviews_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'delete_interview_use_case.g.dart';

/// Borra una entrevista.
class DeleteInterviewUseCase {
  const DeleteInterviewUseCase({required this._repository});

  final InterviewsRepository _repository;

  Future<Result<void>> call(String id) => _repository.delete(id);
}

@Riverpod(keepAlive: true)
DeleteInterviewUseCase deleteInterviewUseCase(Ref ref) =>
    DeleteInterviewUseCase(repository: ref.watch(interviewsRepositoryProvider));
