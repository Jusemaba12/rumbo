import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/email/domain/repositories/email_repository.dart';
import 'package:rumbo/features/email/infrastructure/di/email_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'create_email_sync_key_use_case.g.dart';

/// Crea la clave del script de Gmail; invalida la anterior.
class CreateEmailSyncKeyUseCase {
  const CreateEmailSyncKeyUseCase({required this._repository});

  final EmailRepository _repository;

  Future<Result<String>> call() => _repository.createKey();
}

@Riverpod(keepAlive: true)
CreateEmailSyncKeyUseCase createEmailSyncKeyUseCase(Ref ref) =>
    CreateEmailSyncKeyUseCase(repository: ref.watch(emailRepositoryProvider));
