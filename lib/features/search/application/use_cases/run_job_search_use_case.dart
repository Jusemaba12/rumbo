import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/search/domain/entities/search_summary.dart';
import 'package:rumbo/features/search/domain/repositories/search_repository.dart';
import 'package:rumbo/features/search/infrastructure/di/search_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'run_job_search_use_case.g.dart';

/// Busca en los portales y guarda las sugerencias nuevas.
class RunJobSearchUseCase {
  const RunJobSearchUseCase({required this._repository});

  final SearchRepository _repository;

  Future<Result<SearchSummary>> call() => _repository.search();
}

@Riverpod(keepAlive: true)
RunJobSearchUseCase runJobSearchUseCase(Ref ref) =>
    RunJobSearchUseCase(repository: ref.watch(searchRepositoryProvider));
