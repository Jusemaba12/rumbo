import 'package:rumbo/shared/domain/result.dart';

/// Acceso por correo con código de un solo uso.
abstract interface class AuthRepository {
  bool get isSignedIn;

  /// Emite cada vez que cambia el estado de la sesión.
  Stream<bool> get signedInChanges;

  Future<Result<void>> sendCode(String email);

  Future<Result<void>> verifyCode({
    required String email,
    required String code,
  });

  Future<Result<void>> signOut();
}
