import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/auth/domain/repositories/auth_repository.dart';
import 'package:rumbo/features/auth/infrastructure/di/auth_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'send_sign_in_code_use_case.g.dart';

/// Envía al correo un código de acceso de un solo uso.
class SendSignInCodeUseCase {
  const SendSignInCodeUseCase({required this._repository});

  final AuthRepository _repository;

  Future<Result<void>> call(String email) => _repository.sendCode(email.trim());
}

@Riverpod(keepAlive: true)
SendSignInCodeUseCase sendSignInCodeUseCase(Ref ref) =>
    SendSignInCodeUseCase(repository: ref.watch(authRepositoryProvider));
