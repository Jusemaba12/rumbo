// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apply_email_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(mailWithAttachment)
final mailWithAttachmentProvider = MailWithAttachmentProvider._();

final class MailWithAttachmentProvider
    extends
        $FunctionalProvider<
          MailWithAttachment,
          MailWithAttachment,
          MailWithAttachment
        >
    with $Provider<MailWithAttachment> {
  MailWithAttachmentProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mailWithAttachmentProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mailWithAttachmentHash();

  @$internal
  @override
  $ProviderElement<MailWithAttachment> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MailWithAttachment create(Ref ref) {
    return mailWithAttachment(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MailWithAttachment value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MailWithAttachment>(value),
    );
  }
}

String _$mailWithAttachmentHash() =>
    r'9324ffcb1721cf2de9f7170194e94dd14f1a0b74';
