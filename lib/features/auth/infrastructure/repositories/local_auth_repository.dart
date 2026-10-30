import 'package:rumbo/features/auth/domain/repositories/auth_repository.dart';
import 'package:rumbo/shared/domain/result.dart';

/// Usado cuando la app se compila sin servidor: siempre hay sesión.
class LocalAuthRepository implements AuthRepository {
  const LocalAuthRepository();

  @override
  bool get isSignedIn => true;

  @override
  Stream<bool> get signedInChanges => const Stream<bool>.empty();

  @override
  Future<Result<void>> sendCode(String email) async => ok;

  @override
  Future<Result<void>> verifyCode({
    required String email,
    required String code,
  }) async => ok;

  @override
  Future<Result<void>> signOut() async => ok;
}
