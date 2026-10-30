import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/interviews/domain/entities/interview.dart';
import 'package:rumbo/features/interviews/domain/repositories/interviews_repository.dart';
import 'package:rumbo/features/interviews/infrastructure/di/interviews_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'save_interview_use_case.g.dart';

/// Crea o actualiza una entrevista.
class SaveInterviewUseCase {
  const SaveInterviewUseCase({required this._repository});

  final InterviewsRepository _repository;

  Future<Result<void>> call(Interview interview) => _repository.save(interview);
}

@Riverpod(keepAlive: true)
SaveInterviewUseCase saveInterviewUseCase(Ref ref) =>
    SaveInterviewUseCase(repository: ref.watch(interviewsRepositoryProvider));
