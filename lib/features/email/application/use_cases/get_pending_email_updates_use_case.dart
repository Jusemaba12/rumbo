import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/email/domain/entities/email_update.dart';
import 'package:rumbo/features/email/domain/repositories/email_repository.dart';
import 'package:rumbo/features/email/infrastructure/di/email_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'get_pending_email_updates_use_case.g.dart';

/// Propuestas de los correos pendientes de revisar.
class GetPendingEmailUpdatesUseCase {
  const GetPendingEmailUpdatesUseCase({required this._repository});

  final EmailRepository _repository;

  Future<Result<List<EmailUpdate>>> call() => _repository.pendingUpdates();
}

@Riverpod(keepAlive: true)
GetPendingEmailUpdatesUseCase getPendingEmailUpdatesUseCase(Ref ref) =>
    GetPendingEmailUpdatesUseCase(
      repository: ref.watch(emailRepositoryProvider),
    );
