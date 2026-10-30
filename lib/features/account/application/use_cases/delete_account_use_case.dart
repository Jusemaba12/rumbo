import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/account/domain/repositories/account_repository.dart';
import 'package:rumbo/features/account/infrastructure/di/account_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'delete_account_use_case.g.dart';

/// Borra la cuenta y todos sus datos. No se puede deshacer.
class DeleteAccountUseCase {
  const DeleteAccountUseCase({required this._repository});

  final AccountRepository _repository;

  Future<Result<void>> call() => _repository.deleteAccount();
}

@Riverpod(keepAlive: true)
DeleteAccountUseCase deleteAccountUseCase(Ref ref) =>
    DeleteAccountUseCase(repository: ref.watch(accountRepositoryProvider));
