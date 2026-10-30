// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_applications_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getApplicationsUseCase)
final getApplicationsUseCaseProvider = GetApplicationsUseCaseProvider._();

final class GetApplicationsUseCaseProvider
    extends
        $FunctionalProvider<
          GetApplicationsUseCase,
          GetApplicationsUseCase,
          GetApplicationsUseCase
        >
    with $Provider<GetApplicationsUseCase> {
  GetApplicationsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getApplicationsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getApplicationsUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetApplicationsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetApplicationsUseCase create(Ref ref) {
    return getApplicationsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetApplicationsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetApplicationsUseCase>(value),
    );
  }
}

String _$getApplicationsUseCaseHash() =>
    r'7c35f93ec26bfe6573af528668e08509211e8a67';
