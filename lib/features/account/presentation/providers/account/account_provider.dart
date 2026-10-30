import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:rumbo/features/account/application/use_cases/accept_privacy_use_case.dart';
import 'package:rumbo/features/account/application/use_cases/get_latest_android_release_use_case.dart';
import 'package:rumbo/features/account/application/use_cases/is_privacy_accepted_use_case.dart';
import 'package:rumbo/features/account/domain/entities/app_release.dart';
import 'package:rumbo/features/auth/infrastructure/di/auth_providers.dart';
import 'package:rumbo/shared/domain/result.dart';
import 'package:rumbo/shared/utils/log.dart';

part 'account_provider.g.dart';

/// Usos de IA por persona y día; igual que AI_DAILY_LIMIT en el servidor.
const int aiDailyLimit = 40;

/// Si la cuenta aceptó el aviso de privacidad. Sin conexión no se bloquea:
/// un error cuenta como aceptado.
@Riverpod(keepAlive: true)
class PrivacyAccepted extends _$PrivacyAccepted {
  @override
  Future<bool> build() async {
    ref.watch(sessionChangesProvider);
    if (!ref.watch(authRepositoryProvider).isSignedIn) return true;
    return (await ref.watch(isPrivacyAcceptedUseCaseProvider)()).valueOrNull ??
        true;
  }

  Future<Result<void>> accept() async {
    final Result<void> result = await ref.read(acceptPrivacyUseCaseProvider)();
    if (result.isOk) state = const AsyncData<bool>(true);
    return result;
  }
}

/// Número de compilación instalado, o nulo si no se puede leer.
@Riverpod(keepAlive: true)
Future<int?> installedBuild(Ref ref) async {
  try {
    return int.tryParse((await PackageInfo.fromPlatform()).buildNumber);
  } catch (error) {
    Log.w(tag: 'InstalledBuild', message: 'No se pudo leer: $error');
    return null;
  }
}

/// Versión nueva del APK para avisar en Inicio. Solo Android: en iPhone la
/// app se reinstala desde el Mac.
@Riverpod(keepAlive: true)
Future<AppRelease?> availableUpdate(Ref ref) async {
  if (defaultTargetPlatform != TargetPlatform.android) return null;
  final int? installed = await ref.watch(installedBuildProvider.future);
  if (installed == null) return null;
  final AppRelease? release = (await ref.watch(
    getLatestAndroidReleaseUseCaseProvider,
  )()).valueOrNull;
  return release != null && release.isNewerThan(installed) ? release : null;
}
