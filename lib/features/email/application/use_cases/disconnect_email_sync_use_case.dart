import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/email/domain/repositories/email_repository.dart';
import 'package:rumbo/features/email/infrastructure/di/email_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'disconnect_email_sync_use_case.g.dart';

/// Desconecta Gmail borrando la clave.
class DisconnectEmailSyncUseCase {
  const DisconnectEmailSyncUseCase({required this._repository});

  final EmailRepository _repository;

  Future<Result<void>> call() => _repository.disconnect();
}

@Riverpod(keepAlive: true)
DisconnectEmailSyncUseCase disconnectEmailSyncUseCase(Ref ref) =>
    DisconnectEmailSyncUseCase(repository: ref.watch(emailRepositoryProvider));
