import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/account/domain/repositories/account_repository.dart';
import 'package:rumbo/features/account/infrastructure/di/account_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'accept_privacy_use_case.g.dart';

/// Registra que la cuenta aceptó el aviso de privacidad.
class AcceptPrivacyUseCase {
  const AcceptPrivacyUseCase({required this._repository});

  final AccountRepository _repository;

  Future<Result<void>> call() => _repository.acceptPrivacy();
}

@Riverpod(keepAlive: true)
AcceptPrivacyUseCase acceptPrivacyUseCase(Ref ref) =>
    AcceptPrivacyUseCase(repository: ref.watch(accountRepositoryProvider));
