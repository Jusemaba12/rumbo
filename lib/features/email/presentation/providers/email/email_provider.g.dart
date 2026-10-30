// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(emailSyncStatus)
final emailSyncStatusProvider = EmailSyncStatusProvider._();

final class EmailSyncStatusProvider
    extends
        $FunctionalProvider<
          AsyncValue<EmailSyncStatus?>,
          EmailSyncStatus?,
          FutureOr<EmailSyncStatus?>
        >
    with $FutureModifier<EmailSyncStatus?>, $FutureProvider<EmailSyncStatus?> {
  EmailSyncStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'emailSyncStatusProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$emailSyncStatusHash();

  @$internal
  @override
  $FutureProviderElement<EmailSyncStatus?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<EmailSyncStatus?> create(Ref ref) {
    return emailSyncStatus(ref);
  }
}

String _$emailSyncStatusHash() => r'07a1c885be6fabe0250a88ad30651075d4b7a522';

@ProviderFor(EmailUpdatesController)
final emailUpdatesControllerProvider = EmailUpdatesControllerProvider._();

final class EmailUpdatesControllerProvider
    extends $AsyncNotifierProvider<EmailUpdatesController, List<EmailUpdate>> {
  EmailUpdatesControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'emailUpdatesControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$emailUpdatesControllerHash();

  @$internal
  @override
  EmailUpdatesController create() => EmailUpdatesController();
}

String _$emailUpdatesControllerHash() =>
    r'7520642d36ef1a66a791133f6f32450e45258eac';

abstract class _$EmailUpdatesController
    extends $AsyncNotifier<List<EmailUpdate>> {
  FutureOr<List<EmailUpdate>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<EmailUpdate>>, List<EmailUpdate>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<EmailUpdate>>, List<EmailUpdate>>,
              AsyncValue<List<EmailUpdate>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
