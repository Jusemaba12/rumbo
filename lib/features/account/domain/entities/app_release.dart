import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_release.freezed.dart';

/// Versión publicada de la app (APK de Android) en `app_releases`.
@freezed
abstract class AppRelease with _$AppRelease {
  const AppRelease._();

  const factory AppRelease({
    required String versionName,

    /// El número tras el «+» de `version` en pubspec.yaml.
    required int versionCode,
    required String downloadUrl,
    @Default('') String notes,
  }) = _AppRelease;

  factory AppRelease.fromRow(Map<String, dynamic> row) => AppRelease(
    versionName: row['version_name'] as String,
    versionCode: row['version_code'] as int,
    downloadUrl: row['download_url'] as String,
    notes: row['notes'] as String? ?? '',
  );

  /// Si es más nueva que la instalada. Los APK por arquitectura suman
  /// 1000, 2000… al número de compilación: se compara solo el resto.
  bool isNewerThan(int installedBuild) => versionCode > installedBuild % 1000;
}
