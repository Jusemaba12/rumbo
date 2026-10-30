import 'package:rumbo/features/email/domain/entities/email_update.dart';
import 'package:rumbo/features/email/domain/repositories/email_repository.dart';
import 'package:rumbo/features/email/domain/services/sync_key.dart';
import 'package:rumbo/shared/domain/result.dart';

class InMemoryEmailRepository implements EmailRepository {
  InMemoryEmailRepository({List<EmailUpdate> updates = const <EmailUpdate>[]})
    : pending = <EmailUpdate>[...updates];

  EmailSyncStatus? connection;
  String? keyHash;
  final List<EmailUpdate> pending;
  final Map<String, bool> resolved = <String, bool>{};

  @override
  Future<Result<EmailSyncStatus?>> status() async =>
      Ok<EmailSyncStatus?>(connection);

  @override
  Future<Result<String>> createKey() async {
    final String key = generateSyncKey();
    keyHash = hashSyncKey(key);
    connection = EmailSyncStatus(createdAt: DateTime.now());
    return Ok<String>(key);
  }

  @override
  Future<Result<void>> disconnect() async {
    connection = null;
    keyHash = null;
    return ok;
  }

  @override
  Future<Result<List<EmailUpdate>>> pendingUpdates() async =>
      Ok<List<EmailUpdate>>(<EmailUpdate>[...pending]);

  @override
  Future<Result<void>> resolve(String updateId, {required bool applied}) async {
    pending.removeWhere((EmailUpdate u) => u.id == updateId);
    resolved[updateId] = applied;
    return ok;
  }
}
