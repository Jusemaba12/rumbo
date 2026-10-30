/// Cómo terminó un paso del acceso.
sealed class SignInResult {
  const SignInResult();
}

/// Se envió el código al correo.
final class SignInCodeSent extends SignInResult {
  const SignInCodeSent();
}

/// El código era válido; el router lleva al inicio.
final class SignInVerified extends SignInResult {
  const SignInVerified();
}

final class SignInFailed extends SignInResult {
  const SignInFailed();
}
