// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_controller.dart';

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

String _$emailSyncStatusHash() => r'095a7c1b2dca2617d2407234a93a4cb3aa6f6834';

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
    r'2ab326e28f44e82d398bf1e0bf76ccfdddc46f72';

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
