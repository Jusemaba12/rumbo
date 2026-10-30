import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/company/domain/entities/company_brief.dart';
import 'package:rumbo/features/company/domain/repositories/company_brief_repository.dart';
import 'package:rumbo/features/company/infrastructure/di/company_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'get_company_brief_use_case.g.dart';

/// Ficha guardada de la empresa de una oferta; nula si no hay (o en modo
/// local).
class GetCompanyBriefUseCase {
  const GetCompanyBriefUseCase({required this._repository});

  final CompanyBriefRepository? _repository;

  Future<Result<CompanyBrief?>> call(String jobId) async =>
      await _repository?.load(jobId) ?? const Ok<CompanyBrief?>(null);
}

@Riverpod(keepAlive: true)
GetCompanyBriefUseCase getCompanyBriefUseCase(Ref ref) =>
    GetCompanyBriefUseCase(
      repository: ref.watch(companyBriefRepositoryProvider),
    );
