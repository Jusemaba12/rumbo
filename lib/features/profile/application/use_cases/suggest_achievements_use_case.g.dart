// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suggest_achievements_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(suggestAchievementsUseCase)
final suggestAchievementsUseCaseProvider =
    SuggestAchievementsUseCaseProvider._();

final class SuggestAchievementsUseCaseProvider
    extends
        $FunctionalProvider<
          SuggestAchievementsUseCase,
          SuggestAchievementsUseCase,
          SuggestAchievementsUseCase
        >
    with $Provider<SuggestAchievementsUseCase> {
  SuggestAchievementsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'suggestAchievementsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$suggestAchievementsUseCaseHash();

  @$internal
  @override
  $ProviderElement<SuggestAchievementsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SuggestAchievementsUseCase create(Ref ref) {
    return suggestAchievementsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SuggestAchievementsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SuggestAchievementsUseCase>(value),
    );
  }
}

String _$suggestAchievementsUseCaseHash() =>
    r'77c0e7b1e5fe4da11a6270262fc5859c6a56a183';
