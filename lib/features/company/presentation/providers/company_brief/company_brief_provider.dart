import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/company/application/use_cases/generate_company_brief_use_case.dart';
import 'package:rumbo/features/company/application/use_cases/get_company_brief_use_case.dart';
import 'package:rumbo/features/company/domain/entities/company_brief.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'company_brief_provider.g.dart';

/// Ficha de la empresa de la oferta [jobId].
@Riverpod(keepAlive: true)
class CompanyBriefController extends _$CompanyBriefController {
  @override
  Future<CompanyBrief?> build(String jobId) async =>
      (await ref.watch(getCompanyBriefUseCaseProvider)(jobId)).getOrThrow();

  /// Genera la ficha con IA y la muestra.
  Future<Result<CompanyBrief>> generate() async {
    final Result<CompanyBrief> result = await ref.read(
      generateCompanyBriefUseCaseProvider,
    )(jobId);
    if (result case Ok<CompanyBrief>(:final CompanyBrief value)) {
      state = AsyncData<CompanyBrief?>(value);
    }
    return result;
  }
}
