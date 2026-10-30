import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/jobs/domain/repositories/jobs_repository.dart';
import 'package:rumbo/features/jobs/infrastructure/di/jobs_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'manage_suggestion_use_case.g.dart';

/// Qué hacer con una oferta sugerida por la búsqueda.
enum SuggestionAction {
  /// Pasa a ofertas guardadas.
  keep,

  /// Se oculta sin borrarla, para que no vuelva a aparecer.
  dismiss,

  /// Vuelve a sugerencias tras haberla descartado.
  restore,
}

class ManageSuggestionUseCase {
  const ManageSuggestionUseCase({required this._repository});

  final JobsRepository _repository;

  Future<Result<void>> call({
    required String jobId,
    required SuggestionAction action,
  }) => switch (action) {
    SuggestionAction.keep => _repository.keepSuggestion(jobId),
    SuggestionAction.dismiss => _repository.dismissSuggestion(jobId),
    SuggestionAction.restore => _repository.restoreSuggestion(jobId),
  };
}

@Riverpod(keepAlive: true)
ManageSuggestionUseCase manageSuggestionUseCase(Ref ref) =>
    ManageSuggestionUseCase(repository: ref.watch(jobsRepositoryProvider));
