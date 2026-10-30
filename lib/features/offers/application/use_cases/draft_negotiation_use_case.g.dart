// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'draft_negotiation_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(draftNegotiationUseCase)
final draftNegotiationUseCaseProvider = DraftNegotiationUseCaseProvider._();

final class DraftNegotiationUseCaseProvider
    extends
        $FunctionalProvider<
          DraftNegotiationUseCase,
          DraftNegotiationUseCase,
          DraftNegotiationUseCase
        >
    with $Provider<DraftNegotiationUseCase> {
  DraftNegotiationUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'draftNegotiationUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$draftNegotiationUseCaseHash();

  @$internal
  @override
  $ProviderElement<DraftNegotiationUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DraftNegotiationUseCase create(Ref ref) {
    return draftNegotiationUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DraftNegotiationUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DraftNegotiationUseCase>(value),
    );
  }
}

String _$draftNegotiationUseCaseHash() =>
    r'a3c8b304acf59107570928d47f13e7687f161765';
