import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:rumbo/features/reminders/domain/entities/scheduled_notice.dart';
import 'package:rumbo/features/reminders/domain/repositories/reminder_scheduler.dart';
import 'package:rumbo/features/reminders/domain/repositories/reminder_settings_store.dart';
import 'package:rumbo/features/reminders/domain/services/reminder_plan.dart';
import 'package:rumbo/features/reminders/infrastructure/di/reminders_providers.dart';
import 'package:rumbo/features/reminders/presentation/providers/reminders/reminders_provider.dart';
import 'package:rumbo/features/reminders/presentation/providers/reminders/reminders_state.dart';
import 'package:rumbo/shared/application/services/clock.dart';
import 'package:rumbo/shared/configurations/language/app_localizations.dart';
import 'package:rumbo/shared/presentation/navigation/routes.dart';

/// Textos de un aviso en el idioma del usuario.
ScheduledNotice noticeFor(
  AppLocalizations l10n,
  String locale,
  PlannedReminder reminder,
) {
  final String time = reminder.interviewAt == null
      ? ''
      : DateFormat.Hm(locale).format(reminder.interviewAt!);
  final String route = reminder.applicationId == null
      ? const HomeRoute().location
      : ApplicationDetailRoute(id: reminder.applicationId!).location;
  final (String title, String body) = switch (reminder.kind) {
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
  ReminderSync({
    required this._ref,
    required this._context,
    required this._open,
  });

  final WidgetRef _ref;
  final BuildContext _context;
  final void Function(String route) _open;
  Timer? _debounce;
  final List<ProviderSubscription<Object?>> _subscriptions =
      <ProviderSubscription<Object?>>[];

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
    for (final ProviderSubscription<Object?> subscription in _subscriptions) {
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
    final RemindersState? state = _ref.read(remindersControllerProvider).value;
    if (state == null) return;
    final ReminderSettings settings = state.settings;
    final List<PlannedReminder> plan = _ref.read(plannedRemindersProvider);
    final ReminderSettingsStore store = _ref.read(
      reminderSettingsStoreProvider,
    );
    final ReminderScheduler scheduler = _ref.read(reminderSchedulerProvider);
    // El permiso se pide la primera vez que hay algo que avisar.
    if ((plan.isNotEmpty || settings.daily) && !await store.permissionAsked()) {
      await scheduler.requestPermission();
      await store.markPermissionAsked();
    }
    if (!_context.mounted) return;
    final AppLocalizations l10n = AppLocalizations.of(_context);
    final String locale = Localizations.localeOf(_context).toLanguageTag();
    final DateTime now = _ref.read(clockProvider)();
    DateTime nextDaily = DateTime(now.year, now.month, now.day, dailyHour);
    if (!nextDaily.isAfter(now)) {
      nextDaily = nextDaily.add(const Duration(days: 1));
    }
    await scheduler.replaceAll(
      <ScheduledNotice>[
        for (final PlannedReminder reminder in plan)
          noticeFor(l10n, locale, reminder),
      ],
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
