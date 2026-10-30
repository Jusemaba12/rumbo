import 'package:rumbo/features/company/domain/entities/company_brief.dart';
import 'package:rumbo/shared/domain/result.dart';

/// Ficha de la empresa de una oferta, guardada en `jobs.company_brief`.
abstract interface class CompanyBriefRepository {
  /// La ficha guardada, o nula si aún no se generó.
  Future<Result<CompanyBrief?>> load(String jobId);

  /// Genera (o regenera) la ficha con IA y la guarda.
  Future<Result<CompanyBrief>> generate(String jobId);
}
