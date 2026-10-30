import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/company/domain/entities/company_brief.dart';
import 'package:rumbo/features/company/domain/repositories/company_brief_repository.dart';
import 'package:rumbo/features/company/infrastructure/di/company_providers.dart';
import 'package:rumbo/shared/domain/failures/failure.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'generate_company_brief_use_case.g.dart';

/// Genera (o regenera) con IA la ficha de la empresa y la guarda.
class GenerateCompanyBriefUseCase {
  const GenerateCompanyBriefUseCase({required this._repository});

  final CompanyBriefRepository? _repository;

  /// Falso en modo local, donde no hay IA.
  bool get isAvailable => _repository != null;

  Future<Result<CompanyBrief>> call(String jobId) async =>
      await _repository?.generate(jobId) ??
      const Err<CompanyBrief>(BackendUnavailableFailure());
}

@Riverpod(keepAlive: true)
GenerateCompanyBriefUseCase generateCompanyBriefUseCase(Ref ref) =>
    GenerateCompanyBriefUseCase(
      repository: ref.watch(companyBriefRepositoryProvider),
    );
