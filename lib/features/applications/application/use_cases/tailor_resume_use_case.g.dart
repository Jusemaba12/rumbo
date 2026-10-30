// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tailor_resume_use_case.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(tailorResumeUseCase)
final tailorResumeUseCaseProvider = TailorResumeUseCaseProvider._();

final class TailorResumeUseCaseProvider
    extends
        $FunctionalProvider<
          TailorResumeUseCase,
          TailorResumeUseCase,
          TailorResumeUseCase
        >
    with $Provider<TailorResumeUseCase> {
  TailorResumeUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tailorResumeUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tailorResumeUseCaseHash();

  @$internal
  @override
  $ProviderElement<TailorResumeUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TailorResumeUseCase create(Ref ref) {
    return tailorResumeUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TailorResumeUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TailorResumeUseCase>(value),
    );
  }
}

String _$tailorResumeUseCaseHash() =>
    r'2eb46179a4c8eda9abf990b9f4bf8661defca51f';
