import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/router/app_router.dart';
import '../../../core/time/clock.dart';
import '../../../l10n/app_localizations.dart';
import '../../applications/presentation/applications_controller.dart';
import '../../interviews/presentation/interviews_controller.dart';
import '../data/reminder_scheduler.dart';
import '../data/reminder_settings_store.dart';
import '../domain/reminder_plan.dart';

part 'reminders_controller.g.dart';
part 'reminders_controller.freezed.dart';

/// Preferencias de recordatorios y si el sistema denegó el permiso.
@freezed
abstract class RemindersState with _$RemindersState {
  const factory RemindersState({
    required ReminderSettings settings,
    @Default(false) bool denied,
  }) = _RemindersState;
}

@Riverpod(keepAlive: true)
class RemindersController extends _$RemindersController {
  ReminderSettingsStore get _store => ref.read(reminderSettingsStoreProvider);

  @override
  Future<RemindersState> build() async =>
      RemindersState(settings: await _store.load());

  Future<void> change(ReminderSettings settings) async {
    var denied = false;
    final enabling =
        (settings.processes && !(state.value?.settings.processes ?? false)) ||
        (settings.daily && !(state.value?.settings.daily ?? false));
    if (enabling) {
      denied = !await ref.read(reminderSchedulerProvider).requestPermission();
      await _store.markPermissionAsked();
    }
    await _store.save(settings);
    state = AsyncData(RemindersState(settings: settings, denied: denied));
  }
}

/// Avisos que tocan ahora según los procesos y entrevistas.
@Riverpod(keepAlive: true)
List<PlannedReminder> plannedReminders(Ref ref) {
  final settings = ref.watch(remindersControllerProvider).value?.settings;
  if (settings == null || !settings.processes) return const [];
  return planReminders(
    applications: ref.watch(applicationsControllerProvider).value ?? const [],
    interviews: ref.watch(interviewsControllerProvider).value ?? const [],
    now: ref.watch(clockProvider)(),
  );
}

/// Textos de un aviso en el idioma del usuario.
ScheduledNotice noticeFor(
  AppLocalizations l10n,
  String locale,
  PlannedReminder reminder,
) {
  final time = reminder.interviewAt == null
      ? ''
      : DateFormat.Hm(locale).format(reminder.interviewAt!);
  final route = reminder.applicationId == null
      ? const HomeRoute().location
      : ApplicationDetailRoute(id: reminder.applicationId!).location;
  final (title, body) = switch (reminder.kind) {
    ReminderKind.followUp => (
      l10n.reminderFollowUpTitle,
      l10n.reminderFollowUpBody(reminder.role, reminder.company),
    ),
    ReminderKind.interviewEve => (
      l10n.reminderEveTitle,
      l10n.reminderEveBody(reminder.company, time),
    ),
    ReminderKind.interviewSoon => (
      l10n.reminderSoonTitle,
      l10n.reminderSoonBody(reminder.company, time),
    ),
    ReminderKind.daily => (l10n.reminderDailyTitle, l10n.reminderDailyBody),
  };
  return ScheduledNotice(
    id: reminder.id,
    at: reminder.at,
    title: title,
    body: body,
    route: route,
  );
}

/// Mantiene programados en el teléfono los avisos de [plannedRemindersProvider]
/// y abre la pantalla de un aviso al tocarlo. Vive en la barra de pestañas.
class ReminderSync {
  ReminderSync(this._ref, this._context, this._open);

  final WidgetRef _ref;
  final BuildContext _context;
  final void Function(String route) _open;
  Timer? _debounce;
  final _subscriptions = <ProviderSubscription<Object?>>[];

  Future<void> start() async {
    await _ref.read(reminderSchedulerProvider).init(_open);
    _subscriptions
      ..add(_ref.listenManual(plannedRemindersProvider, (_, _) => _schedule()))
      ..add(
        _ref.listenManual(remindersControllerProvider, (_, _) => _schedule()),
      );
    _schedule();
  }

  void dispose() {
    _debounce?.cancel();
    for (final subscription in _subscriptions) {
      subscription.close();
    }
  }

  /// Espera a que se calmen los cambios (p. ej. al cargar) antes de
  /// reprogramar.
  void _schedule() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 800), _sync);
  }

  Future<void> _sync() async {
    if (!_context.mounted) return;
    final state = _ref.read(remindersControllerProvider).value;
    if (state == null) return;
    final settings = state.settings;
    final plan = _ref.read(plannedRemindersProvider);
    final store = _ref.read(reminderSettingsStoreProvider);
    final scheduler = _ref.read(reminderSchedulerProvider);
    // El permiso se pide la primera vez que hay algo que avisar.
    if ((plan.isNotEmpty || settings.daily) && !await store.permissionAsked()) {
      await scheduler.requestPermission();
      await store.markPermissionAsked();
    }
    if (!_context.mounted) return;
    final l10n = AppLocalizations.of(_context);
    final locale = Localizations.localeOf(_context).toLanguageTag();
    final now = _ref.read(clockProvider)();
    var nextDaily = DateTime(now.year, now.month, now.day, dailyHour);
    if (!nextDaily.isAfter(now)) {
      nextDaily = nextDaily.add(const Duration(days: 1));
    }
    await scheduler.replaceAll(
      [for (final reminder in plan) noticeFor(l10n, locale, reminder)],
      daily: settings.daily
          ? noticeFor(
              l10n,
              locale,
              PlannedReminder(kind: ReminderKind.daily, at: nextDaily),
            )
          : null,
    );
  }
}
