import 'package:rumbo/features/offers/domain/entities/negotiation_draft.dart';
import 'package:rumbo/shared/domain/result.dart';

/// Redacta con IA la respuesta a una oferta (función `negotiation-draft`).
abstract interface class Negotiator {
  Future<Result<NegotiationDraft>> draft({
    required String applicationId,
    double? targetSalary,
    String priorities = '',
    String language = 'es',
  });
}
