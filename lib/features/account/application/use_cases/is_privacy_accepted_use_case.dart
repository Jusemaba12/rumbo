import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/account/domain/repositories/account_repository.dart';
import 'package:rumbo/features/account/infrastructure/di/account_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'is_privacy_accepted_use_case.g.dart';

/// Si la cuenta aceptó el aviso de privacidad.
class IsPrivacyAcceptedUseCase {
  const IsPrivacyAcceptedUseCase({required this._repository});

  final AccountRepository _repository;

  Future<Result<bool>> call() => _repository.privacyAccepted();
}

@Riverpod(keepAlive: true)
IsPrivacyAcceptedUseCase isPrivacyAcceptedUseCase(Ref ref) =>
    IsPrivacyAcceptedUseCase(repository: ref.watch(accountRepositoryProvider));
