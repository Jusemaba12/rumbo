import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/config/env.dart';
import '../../applications/domain/application_status.dart';
import '../domain/email_update.dart';

part 'email_repository.g.dart';

abstract interface class EmailRepository {
  Future<EmailSyncStatus?> status();

  /// Crea una clave nueva (invalida la anterior) y la devuelve en claro.
  /// Solo se muestra una vez: en la base de datos se guarda su hash.
  Future<String> createKey();

  Future<void> disconnect();

  Future<List<EmailUpdate>> pendingUpdates();

  /// Marca la propuesta como aplicada o ignorada.
  Future<void> resolve(String updateId, {required bool applied});
}

/// 32 bytes aleatorios en hexadecimal.
String generateSyncKey([Random? random]) {
  final source = random ?? Random.secure();
  return [
    for (var i = 0; i < 32; i++)
      source.nextInt(256).toRadixString(16).padLeft(2, '0'),
  ].join();
}

String hashSyncKey(String key) => sha256.convert(utf8.encode(key)).toString();

class SupabaseEmailRepository implements EmailRepository {
  SupabaseEmailRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<EmailSyncStatus?> status() async {
    final row = await _client.from('email_sync_keys').select().maybeSingle();
    if (row == null) return null;
    final lastUsed = row['last_used_at'] as String?;
    return EmailSyncStatus(
      createdAt: DateTime.parse(row['created_at'] as String).toLocal(),
      lastUsedAt: lastUsed == null ? null : DateTime.parse(lastUsed).toLocal(),
    );
  }

  @override
  Future<String> createKey() async {
    final key = generateSyncKey();
    await _client.from('email_sync_keys').upsert({
      'user_id': _client.auth.currentUser!.id,
      'key_hash': hashSyncKey(key),
      'created_at': DateTime.now().toUtc().toIso8601String(),
      'last_used_at': null,
    });
    return key;
  }

  @override
  Future<void> disconnect() => _client
      .from('email_sync_keys')
      .delete()
      .eq('user_id', _client.auth.currentUser!.id);

  @override
  Future<List<EmailUpdate>> pendingUpdates() async {
    final rows = await _client
        .from('email_updates')
        .select()
        .eq('state', 'pending')
        .order('received_at', ascending: false);
    return rows.map(emailUpdateFromRow).toList();
  }

  @override
  Future<void> resolve(String updateId, {required bool applied}) => _client
      .from('email_updates')
      .update({'state': applied ? 'applied' : 'dismissed'})
      .eq('id', updateId);
}

class InMemoryEmailRepository implements EmailRepository {
  InMemoryEmailRepository({List<EmailUpdate> updates = const []})
    : pending = [...updates];

  EmailSyncStatus? connection;
  String? keyHash;
  final List<EmailUpdate> pending;
  final resolved = <String, bool>{};

  @override
  Future<EmailSyncStatus?> status() async => connection;

  @override
  Future<String> createKey() async {
    final key = generateSyncKey();
    keyHash = hashSyncKey(key);
    connection = EmailSyncStatus(createdAt: DateTime.now());
    return key;
  }

  @override
  Future<void> disconnect() async {
    connection = null;
    keyHash = null;
  }

  @override
  Future<List<EmailUpdate>> pendingUpdates() async => [...pending];

  @override
  Future<void> resolve(String updateId, {required bool applied}) async {
    pending.removeWhere((u) => u.id == updateId);
    resolved[updateId] = applied;
  }
}

EmailUpdate emailUpdateFromRow(Map<String, dynamic> row) {
  DateTime? date(String key) =>
      row[key] == null ? null : DateTime.parse(row[key] as String).toLocal();
  final status = row['suggested_status'] as String?;
  return EmailUpdate(
    id: row['id'] as String,
    applicationId: row['application_id'] as String,
    sender: row['sender'] as String? ?? '',
    subject: row['subject'] as String? ?? '',
    summary: row['summary'] as String? ?? '',
    suggestedStatus: status == null ? null : ApplicationStatus.fromDb(status),
    interviewAt: date('interview_at'),
    receivedAt: date('received_at'),
  );
}

@Riverpod(keepAlive: true)
EmailRepository emailRepository(Ref ref) {
  if (!Env.hasBackend) return InMemoryEmailRepository();
  return SupabaseEmailRepository(Supabase.instance.client);
}

/// URL de la función que recibe los correos del script.
String emailSyncUrl() => '${Env.supabaseUrl}/functions/v1/email-sync';
