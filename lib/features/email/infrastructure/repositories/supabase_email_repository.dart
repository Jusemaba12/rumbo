import 'package:rumbo/features/email/domain/entities/email_update.dart';
import 'package:rumbo/features/email/domain/repositories/email_repository.dart';
import 'package:rumbo/features/email/domain/services/sync_key.dart';
import 'package:rumbo/features/email/infrastructure/mappers/email_update_mapper.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/infrastructure/helpers/guard.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseEmailRepository implements EmailRepository {
  SupabaseEmailRepository(this._client);

  static const String _tag = 'SupabaseEmailRepository';

  final SupabaseClient _client;

  @override
  Future<Result<EmailSyncStatus?>> status() => guard(
    tag: _tag,
    run: () async {
      final PostgrestMap? row = await _client
          .from('email_sync_keys')
          .select()
          .maybeSingle();
      if (row == null) return null;
      final String? lastUsed = row['last_used_at'] as String?;
      return EmailSyncStatus(
        createdAt: DateTime.parse(row['created_at'] as String).toLocal(),
        lastUsedAt: lastUsed == null
            ? null
            : DateTime.parse(lastUsed).toLocal(),
      );
    },
  );

  @override
  Future<Result<String>> createKey() => guard(
    tag: _tag,
    run: () async {
      final String key = generateSyncKey();
      await _client.from('email_sync_keys').upsert(<String, String?>{
        'user_id': _client.auth.currentUser!.id,
        'key_hash': hashSyncKey(key),
        'created_at': DateTime.now().toUtc().toIso8601String(),
        'last_used_at': null,
      });
      return key;
    },
  );

  @override
  Future<Result<void>> disconnect() => guard(
    tag: _tag,
    run: () => _client
        .from('email_sync_keys')
        .delete()
        .eq('user_id', _client.auth.currentUser!.id),
  );

  @override
  Future<Result<List<EmailUpdate>>> pendingUpdates() => guard(
    tag: _tag,
    run: () async {
      final PostgrestList rows = await _client
          .from('email_updates')
          .select()
          .eq('state', 'pending')
          .order('received_at', ascending: false);
      return rows.map(emailUpdateFromRow).toList();
    },
  );

  @override
  Future<Result<void>> resolve(String updateId, {required bool applied}) =>
      guard(
        tag: _tag,
        run: () => _client
            .from('email_updates')
            .update(<String, dynamic>{
              'state': applied ? 'applied' : 'dismissed',
            })
            .eq('id', updateId),
      );
}
