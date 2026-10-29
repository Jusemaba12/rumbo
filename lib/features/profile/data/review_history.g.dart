// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_history.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(reviewHistoryStore)
final reviewHistoryStoreProvider = ReviewHistoryStoreProvider._();

final class ReviewHistoryStoreProvider
    extends
        $FunctionalProvider<
          ReviewHistoryStore,
          ReviewHistoryStore,
          ReviewHistoryStore
        >
    with $Provider<ReviewHistoryStore> {
  ReviewHistoryStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reviewHistoryStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reviewHistoryStoreHash();

  @$internal
  @override
  $ProviderElement<ReviewHistoryStore> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReviewHistoryStore create(Ref ref) {
    return reviewHistoryStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReviewHistoryStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReviewHistoryStore>(value),
    );
  }
}

String _$reviewHistoryStoreHash() =>
    r'13c77006bb5b5b1e8f5d78f133b8127088980432';
