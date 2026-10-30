import 'package:rumbo/features/account/domain/entities/app_release.dart';
import 'package:rumbo/features/account/domain/repositories/account_repository.dart';
import 'package:rumbo/shared/domain/result.dart';

/// Modo local y tests: sin servidor no hay nada que aceptar ni publicar.
class LocalAccountRepository implements AccountRepository {
  LocalAccountRepository({this.accepted = true, this.release});

  bool accepted;
  final AppRelease? release;
  bool deleted = false;

  @override
  Future<Result<bool>> privacyAccepted() async => Ok<bool>(accepted);

  @override
  Future<Result<void>> acceptPrivacy() async {
    accepted = true;
    return ok;
  }

  @override
  Future<Result<AppRelease?>> latestAndroidRelease() async =>
      Ok<AppRelease?>(release);

  @override
  Future<Result<void>> deleteAccount() async {
    deleted = true;
    return ok;
  }
}
