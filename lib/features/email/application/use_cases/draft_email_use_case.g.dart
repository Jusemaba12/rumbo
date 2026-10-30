// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'draft_email_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(draftEmailUseCase)
final draftEmailUseCaseProvider = DraftEmailUseCaseProvider._();

final class DraftEmailUseCaseProvider
    extends
        $FunctionalProvider<
          DraftEmailUseCase,
          DraftEmailUseCase,
          DraftEmailUseCase
        >
    with $Provider<DraftEmailUseCase> {
  DraftEmailUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'draftEmailUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$draftEmailUseCaseHash();

  @$internal
  @override
  $ProviderElement<DraftEmailUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DraftEmailUseCase create(Ref ref) {
    return draftEmailUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DraftEmailUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DraftEmailUseCase>(value),
    );
  }
}

String _$draftEmailUseCaseHash() => r'28ea96857b51261d4e370b0fe9e55b70b285a7e5';
