import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/config/env.dart';

part 'auth_repository.g.dart';

/// Acceso por correo con código de un solo uso.
abstract interface class AuthRepository {
  bool get isSignedIn;

  /// Emite cada vez que cambia el estado de la sesión.
  Stream<bool> get signedInChanges;

  Future<void> sendCode(String email);
  Future<void> verifyCode({required String email, required String code});
  Future<void> signOut();
}

class SupabaseAuthRepository implements AuthRepository {
  SupabaseAuthRepository(this._auth);

  final GoTrueClient _auth;

  @override
  bool get isSignedIn => _auth.currentSession != null;

  @override
  Stream<bool> get signedInChanges =>
      _auth.onAuthStateChange.map((state) => state.session != null);

  @override
  Future<void> sendCode(String email) => _auth.signInWithOtp(email: email);

  @override
  Future<void> verifyCode({required String email, required String code}) =>
      _auth.verifyOTP(email: email, token: code, type: OtpType.email);

  @override
  Future<void> signOut() => _auth.signOut();
}

/// Usado cuando la app se compila sin servidor: siempre hay sesión.
class LocalAuthRepository implements AuthRepository {
  const LocalAuthRepository();

  @override
  bool get isSignedIn => true;

  @override
  Stream<bool> get signedInChanges => const Stream.empty();

  @override
  Future<void> sendCode(String email) async {}

  @override
  Future<void> verifyCode({
    required String email,
    required String code,
  }) async {}

  @override
  Future<void> signOut() async {}
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  if (!Env.hasBackend) return const LocalAuthRepository();
  return SupabaseAuthRepository(Supabase.instance.client.auth);
}

/// Emite cada vez que se entra o se sale.
@Riverpod(keepAlive: true)
Stream<bool> sessionChanges(Ref ref) =>
    ref.watch(authRepositoryProvider).signedInChanges;
