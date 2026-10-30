// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resolve_email_update_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(resolveEmailUpdateUseCase)
final resolveEmailUpdateUseCaseProvider = ResolveEmailUpdateUseCaseProvider._();

final class ResolveEmailUpdateUseCaseProvider
    extends
        $FunctionalProvider<
          ResolveEmailUpdateUseCase,
          ResolveEmailUpdateUseCase,
          ResolveEmailUpdateUseCase
        >
    with $Provider<ResolveEmailUpdateUseCase> {
  ResolveEmailUpdateUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resolveEmailUpdateUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resolveEmailUpdateUseCaseHash();

  @$internal
  @override
  $ProviderElement<ResolveEmailUpdateUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ResolveEmailUpdateUseCase create(Ref ref) {
    return resolveEmailUpdateUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ResolveEmailUpdateUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ResolveEmailUpdateUseCase>(value),
    );
  }
}

String _$resolveEmailUpdateUseCaseHash() =>
    r'e814b3f15c68b83c581349446964d3381922c106';
