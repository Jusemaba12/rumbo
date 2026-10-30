import 'package:rumbo/features/auth/domain/repositories/auth_repository.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/infrastructure/helpers/guard.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthRepository implements AuthRepository {
  SupabaseAuthRepository(this._auth);

  static const String _tag = 'SupabaseAuthRepository';

  final GoTrueClient _auth;

  @override
  bool get isSignedIn => _auth.currentSession != null;

  @override
  Stream<bool> get signedInChanges =>
      _auth.onAuthStateChange.map((AuthState state) => state.session != null);

  @override
  Future<Result<void>> sendCode(String email) => guard(
    tag: _tag,
    run: () => _auth.signInWithOtp(email: email),
  );

  @override
  Future<Result<void>> verifyCode({
    required String email,
    required String code,
  }) => guard(
    tag: _tag,
    run: () => _auth.verifyOTP(email: email, token: code, type: OtpType.email),
  );

  @override
  Future<Result<void>> signOut() => guard(tag: _tag, run: _auth.signOut);
}
