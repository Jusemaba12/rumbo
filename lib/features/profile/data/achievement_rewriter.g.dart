// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_rewriter.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Nulo en modo local: necesita el servidor.

@ProviderFor(achievementRewriter)
final achievementRewriterProvider = AchievementRewriterProvider._();

/// Nulo en modo local: necesita el servidor.

final class AchievementRewriterProvider
    extends
        $FunctionalProvider<
          AchievementRewriter?,
          AchievementRewriter?,
          AchievementRewriter?
        >
    with $Provider<AchievementRewriter?> {
  /// Nulo en modo local: necesita el servidor.
  AchievementRewriterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'achievementRewriterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$achievementRewriterHash();

  @$internal
  @override
  $ProviderElement<AchievementRewriter?> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AchievementRewriter? create(Ref ref) {
    return achievementRewriter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AchievementRewriter? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AchievementRewriter?>(value),
    );
  }
}

String _$achievementRewriterHash() =>
    r'7685eab41cb3161e916eb569223e04bab1e1d7ec';
