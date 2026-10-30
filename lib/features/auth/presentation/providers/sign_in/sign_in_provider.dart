import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/auth/application/use_cases/send_sign_in_code_use_case.dart';
import 'package:rumbo/features/auth/application/use_cases/verify_sign_in_code_use_case.dart';
import 'package:rumbo/features/auth/presentation/providers/sign_in/sign_in_result.dart';
import 'package:rumbo/features/auth/presentation/providers/sign_in/sign_in_state.dart';
import 'package:rumbo/shared/domain/result.dart';

part 'sign_in_provider.g.dart';

/// Acceso en dos pasos: pedir el código y escribirlo.
@riverpod
class SignInController extends _$SignInController {
  @override
  SignInState build() => const SignInState();

  /// Envía el código o, si ya se envió, lo comprueba.
  Future<SignInResult> submit({required String email, String code = ''}) async {
    state = state.copyWith(isLoading: true, hasFailed: false);
    final bool verifying = state.codeSent;
    final Result<void> result = verifying
        ? await ref.read(verifySignInCodeUseCaseProvider)(
            email: email,
            code: code,
          )
        : await ref.read(sendSignInCodeUseCaseProvider)(email);
    if (!ref.mounted) return const SignInFailed();
    if (!result.isOk) {
      state = state.copyWith(isLoading: false, hasFailed: true);
      return const SignInFailed();
    }
    state = state.copyWith(isLoading: false, codeSent: true);
    return verifying ? const SignInVerified() : const SignInCodeSent();
  }

  /// Vuelve al paso del correo (para corregirlo).
  void changeEmail() => state = const SignInState();
}
