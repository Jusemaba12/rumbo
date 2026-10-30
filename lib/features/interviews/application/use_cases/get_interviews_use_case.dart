import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/interviews/domain/entities/interview.dart';
import 'package:rumbo/features/interviews/domain/repositories/interviews_repository.dart';
import 'package:rumbo/features/interviews/infrastructure/di/interviews_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'get_interviews_use_case.g.dart';

/// Todas las entrevistas, por fecha.
class GetInterviewsUseCase {
  const GetInterviewsUseCase({required this._repository});

  final InterviewsRepository _repository;

  Future<Result<List<Interview>>> call() => _repository.list();
}

@Riverpod(keepAlive: true)
GetInterviewsUseCase getInterviewsUseCase(Ref ref) =>
    GetInterviewsUseCase(repository: ref.watch(interviewsRepositoryProvider));
