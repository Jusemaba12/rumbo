import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/offers/domain/entities/negotiation_draft.dart';
import 'package:rumbo/features/offers/domain/repositories/negotiator.dart';
import 'package:rumbo/features/offers/infrastructure/di/offers_providers.dart';
import 'package:rumbo/shared/domain/failures/failure.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'draft_negotiation_use_case.g.dart';

/// Prepara la respuesta a una oferta con contraoferta. No envía nada.
class DraftNegotiationUseCase {
  const DraftNegotiationUseCase({required this._negotiator});

  final Negotiator? _negotiator;

  /// Falso en modo local, donde no hay IA.
  bool get isAvailable => _negotiator != null;

  Future<Result<NegotiationDraft>> call({
    required String applicationId,
    double? targetSalary,
    String priorities = '',
    String language = 'es',
  }) async {
    final Negotiator? negotiator = _negotiator;
    if (negotiator == null) {
      return const Err<NegotiationDraft>(BackendUnavailableFailure());
    }
    return negotiator.draft(
      applicationId: applicationId,
      targetSalary: targetSalary,
      priorities: priorities,
      language: language,
    );
  }
}

@Riverpod(keepAlive: true)
DraftNegotiationUseCase draftNegotiationUseCase(Ref ref) =>
    DraftNegotiationUseCase(negotiator: ref.watch(negotiatorProvider));
