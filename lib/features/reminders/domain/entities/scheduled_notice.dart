import 'package:freezed_annotation/freezed_annotation.dart';

part 'scheduled_notice.freezed.dart';

/// Aviso ya con textos, listo para el sistema.
@freezed
abstract class ScheduledNotice with _$ScheduledNotice {
  const factory ScheduledNotice({
    required int id,
    required DateTime at,
    required String title,
    required String body,

    /// Pantalla que abre al tocarlo.
    String? route,
  }) = _ScheduledNotice;
}
