import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:rumbo/features/reminders/domain/services/reminder_plan.dart';

part 'reminders_state.freezed.dart';

/// Preferencias de recordatorios y si el sistema denegó el permiso.
@freezed
abstract class RemindersState with _$RemindersState {
  const factory RemindersState({
    required ReminderSettings settings,
    @Default(false) bool denied,
  }) = _RemindersState;
}
