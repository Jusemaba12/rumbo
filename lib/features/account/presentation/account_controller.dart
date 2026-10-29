import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../auth/data/auth_repository.dart';
import '../data/account_repository.dart';
import '../domain/app_release.dart';

part 'account_controller.g.dart';

/// Usos de IA por persona y día; igual que AI_DAILY_LIMIT en el servidor.
const aiDailyLimit = 40;

/// Si la cuenta aceptó el aviso de privacidad. Sin conexión no se bloquea:
/// un error cuenta como aceptado.
@Riverpod(keepAlive: true)
class PrivacyAccepted extends _$PrivacyAccepted {
  @override
  Future<bool> build() async {
    ref.watch(sessionChangesProvider);
    if (!ref.watch(authRepositoryProvider).isSignedIn) return true;
    try {
      return await ref.watch(accountRepositoryProvider).privacyAccepted();
    } catch (error) {
      debugPrint('privacy: $error');
      return true;
    }
  }

  Future<void> accept() async {
    await ref.read(accountRepositoryProvider).acceptPrivacy();
    state = const AsyncData(true);
  }
}

/// Número de compilación instalado, o nulo si no se puede leer.
@Riverpod(keepAlive: true)
Future<int?> installedBuild(Ref ref) async {
  try {
    return int.tryParse((await PackageInfo.fromPlatform()).buildNumber);
  } catch (_) {
    return null;
  }
}

/// Versión nueva del APK para avisar en Inicio. Solo Android: en iPhone la
/// app se reinstala desde el Mac.
@Riverpod(keepAlive: true)
Future<AppRelease?> availableUpdate(Ref ref) async {
  if (defaultTargetPlatform != TargetPlatform.android) return null;
  final installed = await ref.watch(installedBuildProvider.future);
  if (installed == null) return null;
  try {
    final release = await ref
        .watch(accountRepositoryProvider)
        .latestAndroidRelease();
    return release != null && release.isNewerThan(installed) ? release : null;
  } catch (error) {
    debugPrint('app_releases: $error');
    return null;
  }
}
