import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/config/env.dart';
import '../domain/app_release.dart';

part 'account_repository.g.dart';

/// Datos de la cuenta que no son del perfil: aviso de privacidad, versiones
/// publicadas y borrado de la cuenta.
abstract interface class AccountRepository {
  Future<bool> privacyAccepted();
  Future<void> acceptPrivacy();

  /// La versión más reciente publicada para Android, si hay.
  Future<AppRelease?> latestAndroidRelease();

  /// Borra la cuenta y todos sus datos. No se puede deshacer.
  Future<void> deleteAccount();
}

class SupabaseAccountRepository implements AccountRepository {
  SupabaseAccountRepository(this._client);

  final SupabaseClient _client;

  String get _userId => _client.auth.currentUser!.id;

  @override
  Future<bool> privacyAccepted() async {
    final row = await _client
        .from('profiles')
        .select('privacy_accepted_at')
        .eq('user_id', _userId)
        .maybeSingle();
    return row?['privacy_accepted_at'] != null;
  }

  @override
  Future<void> acceptPrivacy() => _client.from('profiles').upsert({
    'user_id': _userId,
    'privacy_accepted_at': DateTime.now().toUtc().toIso8601String(),
  });

  @override
  Future<AppRelease?> latestAndroidRelease() async {
    final row = await _client
        .from('app_releases')
        .select()
        .eq('platform', 'android')
        .order('version_code', ascending: false)
        .limit(1)
        .maybeSingle();
    return row == null ? null : AppRelease.fromRow(row);
  }

  @override
  Future<void> deleteAccount() async {
    try {
      await _client.functions.invoke('delete-account');
    } on FunctionException catch (error) {
      debugPrint('delete-account ${error.status}: ${error.details}');
      rethrow;
    }
    await _client.auth.signOut();
  }
}

/// Modo local y tests: sin servidor no hay nada que aceptar ni publicar.
class LocalAccountRepository implements AccountRepository {
  LocalAccountRepository({this.accepted = true, this.release});

  bool accepted;
  final AppRelease? release;
  bool deleted = false;

  @override
  Future<bool> privacyAccepted() async => accepted;

  @override
  Future<void> acceptPrivacy() async => accepted = true;

  @override
  Future<AppRelease?> latestAndroidRelease() async => release;

  @override
  Future<void> deleteAccount() async => deleted = true;
}

@Riverpod(keepAlive: true)
AccountRepository accountRepository(Ref ref) {
  if (!Env.hasBackend) return LocalAccountRepository();
  return SupabaseAccountRepository(Supabase.instance.client);
}
