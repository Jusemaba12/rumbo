import 'package:rumbo/features/account/domain/entities/app_release.dart';
import 'package:rumbo/shared/domain/result.dart';

/// Datos de la cuenta que no son del perfil: aviso de privacidad, versiones
/// publicadas y borrado de la cuenta.
abstract interface class AccountRepository {
  Future<Result<bool>> privacyAccepted();

  Future<Result<void>> acceptPrivacy();

  /// La versión más reciente publicada para Android, si hay.
  Future<Result<AppRelease?>> latestAndroidRelease();

  /// Borra la cuenta y todos sus datos. No se puede deshacer.
  Future<Result<void>> deleteAccount();
}
