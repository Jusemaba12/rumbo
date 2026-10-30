import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/auth/domain/repositories/auth_repository.dart';
import 'package:rumbo/features/auth/infrastructure/di/auth_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'sign_out_use_case.g.dart';

/// Cierra la sesión; el router vuelve a la pantalla de acceso.
class SignOutUseCase {
  const SignOutUseCase({required this._repository});

  final AuthRepository _repository;

  Future<Result<void>> call() => _repository.signOut();
}

@Riverpod(keepAlive: true)
SignOutUseCase signOutUseCase(Ref ref) =>
    SignOutUseCase(repository: ref.watch(authRepositoryProvider));
