import 'package:flutter/painting.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:rumbo/features/reminders/domain/entities/scheduled_notice.dart';
import 'package:rumbo/features/reminders/domain/repositories/reminder_scheduler.dart';
import 'package:rumbo/shared/utils/log.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

class LocalReminderScheduler implements ReminderScheduler {
  static const String _tag = 'LocalReminderScheduler';

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  bool _ready = false;

  static const NotificationDetails _details = NotificationDetails(
    android: AndroidNotificationDetails(
      'reminders',
      'Recordatorios',
      channelDescription: 'Seguimientos, entrevistas y resumen diario',
      importance: Importance.high,
      priority: Priority.high,
      // Tiñe el icono pequeño con el verde de Rumbo.
      color: Color(0xFF0D6B5B),
    ),
    iOS: DarwinNotificationDetails(),
  );

  @override
  Future<void> init(void Function(String route) onOpen) async {
    try {
      tz_data.initializeTimeZones();
      try {
        final TimezoneInfo zone = await FlutterTimezone.getLocalTimezone();
        tz.setLocalLocation(tz.getLocation(zone.identifier));
      } catch (error) {
        // Los avisos puntuales siguen en su instante; solo el diario usa
        // la zona.
        Log.w(tag: _tag, message: 'Zona horaria no disponible: $error');
      }
      await _plugin.initialize(
        settings: const InitializationSettings(
          android: AndroidInitializationSettings(
            '@drawable/ic_launcher_monochrome',
          ),
          // El permiso se pide cuando hay algo que avisar, no al abrir.
          iOS: DarwinInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false,
          ),
        ),
        onDidReceiveNotificationResponse: (NotificationResponse response) {
          final String? route = response.payload;
          if (route != null && route.isNotEmpty) onOpen(route);
        },
      );
      _ready = true;
      final NotificationAppLaunchDetails? launch = await _plugin
          .getNotificationAppLaunchDetails();
      final String? route = launch?.notificationResponse?.payload;
      if ((launch?.didNotificationLaunchApp ?? false) &&
          route != null &&
          route.isNotEmpty) {
        onOpen(route);
      }
    } catch (error) {
      // Tests y plataformas sin notificaciones: la app sigue sin avisos.
      Log.w(tag: _tag, message: 'Notificaciones no disponibles: $error');
    }
  }

  @override
  Future<bool> requestPermission() async {
    if (!_ready) return false;
    final IOSFlutterLocalNotificationsPlugin? ios = _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();
    if (ios != null) {
      return await ios.requestPermissions(alert: true, sound: true) ?? false;
    }
    final AndroidFlutterLocalNotificationsPlugin? android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    return await android?.requestNotificationsPermission() ?? true;
  }

  @override
  Future<void> replaceAll(
    List<ScheduledNotice> notices, {
    ScheduledNotice? daily,
  }) async {
    if (!_ready) return;
    await _plugin.cancelAll();
    for (final ScheduledNotice notice in notices) {
      await _plugin.zonedSchedule(
        id: notice.id,
        scheduledDate: tz.TZDateTime.from(notice.at, tz.local),
        notificationDetails: _details,
        // Sin alarmas exactas: no exige permisos especiales y unos minutos
        // de margen no importan para un recordatorio.
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        title: notice.title,
        body: notice.body,
        payload: notice.route,
      );
    }
    if (daily != null) {
      await _plugin.zonedSchedule(
        id: daily.id,
        scheduledDate: tz.TZDateTime.from(daily.at, tz.local),
        notificationDetails: _details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        title: daily.title,
        body: daily.body,
        payload: daily.route,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  }

  @override
  Future<void> showNow(ScheduledNotice notice) async {
    if (!_ready) return;
    await _plugin.show(
      id: notice.id,
      title: notice.title,
      body: notice.body,
      notificationDetails: _details,
      payload: notice.route,
    );
  }
}
