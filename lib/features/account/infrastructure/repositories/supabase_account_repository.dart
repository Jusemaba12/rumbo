import 'package:rumbo/features/account/domain/entities/app_release.dart';
import 'package:rumbo/features/account/domain/repositories/account_repository.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/infrastructure/helpers/guard.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAccountRepository implements AccountRepository {
  SupabaseAccountRepository(this._client);

  static const String _tag = 'SupabaseAccountRepository';

  final SupabaseClient _client;

  String get _userId => _client.auth.currentUser!.id;

  @override
  Future<Result<bool>> privacyAccepted() => guard(
    tag: _tag,
    run: () async {
      final PostgrestMap? row = await _client
          .from('profiles')
          .select('privacy_accepted_at')
          .eq('user_id', _userId)
          .maybeSingle();
      return row?['privacy_accepted_at'] != null;
    },
  );

  @override
  Future<Result<void>> acceptPrivacy() => guard(
    tag: _tag,
    run: () => _client.from('profiles').upsert(<String, String>{
      'user_id': _userId,
      'privacy_accepted_at': DateTime.now().toUtc().toIso8601String(),
    }),
  );

  @override
  Future<Result<AppRelease?>> latestAndroidRelease() => guard(
    tag: _tag,
    run: () async {
      final PostgrestMap? row = await _client
          .from('app_releases')
          .select()
          .eq('platform', 'android')
          .order('version_code', ascending: false)
          .limit(1)
          .maybeSingle();
      return row == null ? null : AppRelease.fromRow(row);
    },
  );

  @override
  Future<Result<void>> deleteAccount() => guard(
    tag: _tag,
    run: () async {
      await _client.functions.invoke('delete-account');
      await _client.auth.signOut();
    },
  );
}
