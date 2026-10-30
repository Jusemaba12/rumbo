import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/auth/domain/repositories/auth_repository.dart';
import 'package:rumbo/features/auth/infrastructure/di/auth_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'verify_sign_in_code_use_case.g.dart';

/// Entra con el código recibido; el router redirige al detectar la sesión.
class VerifySignInCodeUseCase {
  const VerifySignInCodeUseCase({required this._repository});

  final AuthRepository _repository;

  Future<Result<void>> call({required String email, required String code}) =>
      _repository.verifyCode(email: email.trim(), code: code.trim());
}

@Riverpod(keepAlive: true)
VerifySignInCodeUseCase verifySignInCodeUseCase(Ref ref) =>
    VerifySignInCodeUseCase(repository: ref.watch(authRepositoryProvider));
