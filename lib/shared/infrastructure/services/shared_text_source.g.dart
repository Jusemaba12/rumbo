// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_text_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(sharedTextSource)
final sharedTextSourceProvider = SharedTextSourceProvider._();

final class SharedTextSourceProvider
    extends
        $FunctionalProvider<
          SharedTextSource,
          SharedTextSource,
          SharedTextSource
        >
    with $Provider<SharedTextSource> {
  SharedTextSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharedTextSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharedTextSourceHash();

  @$internal
  @override
  $ProviderElement<SharedTextSource> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SharedTextSource create(Ref ref) {
    return sharedTextSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SharedTextSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SharedTextSource>(value),
    );
  }
}

String _$sharedTextSourceHash() => r'8c37624198294d684b8c38636113fc08ea76a435';
