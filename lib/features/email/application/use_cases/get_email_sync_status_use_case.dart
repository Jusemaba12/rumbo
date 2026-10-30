import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/email/domain/entities/email_update.dart';
import 'package:rumbo/features/email/domain/repositories/email_repository.dart';
import 'package:rumbo/features/email/infrastructure/di/email_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'get_email_sync_status_use_case.g.dart';

/// Estado de la conexión con Gmail; nulo si no está conectado.
class GetEmailSyncStatusUseCase {
  const GetEmailSyncStatusUseCase({required this._repository});

  final EmailRepository _repository;

  Future<Result<EmailSyncStatus?>> call() => _repository.status();
}

@Riverpod(keepAlive: true)
GetEmailSyncStatusUseCase getEmailSyncStatusUseCase(Ref ref) =>
    GetEmailSyncStatusUseCase(repository: ref.watch(emailRepositoryProvider));
