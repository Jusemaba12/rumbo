import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/email/domain/repositories/email_repository.dart';
import 'package:rumbo/features/email/infrastructure/di/email_providers.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'resolve_email_update_use_case.g.dart';

/// Marca una propuesta como aplicada o ignorada.
class ResolveEmailUpdateUseCase {
  const ResolveEmailUpdateUseCase({required this._repository});

  final EmailRepository _repository;

  Future<Result<void>> call(String updateId, {required bool applied}) =>
      _repository.resolve(updateId, applied: applied);
}

@Riverpod(keepAlive: true)
ResolveEmailUpdateUseCase resolveEmailUpdateUseCase(Ref ref) =>
    ResolveEmailUpdateUseCase(repository: ref.watch(emailRepositoryProvider));
