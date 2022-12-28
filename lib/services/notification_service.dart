import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:notifications/models/notification_model.dart';
import 'package:notifications/routes.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  late FlutterLocalNotificationsPlugin localNotificationsPlugin;
  late AndroidNotificationDetails androidDetails;
  late DarwinNotificationDetails iosDetails;

  NotificationService() {
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _setupNotifications();
  }

  _setupNotifications() async {
    await _setupTimezone();
    await _initializeNotifiations();
  }

  _setupTimezone() async {
    tz.initializeTimeZones();
    String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  _initializeNotifiations() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    await localNotificationsPlugin.initialize(
      const InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      ),
      onDidReceiveNotificationResponse: (details) =>
          _onSelectedNotification(details.payload),
    );
  }

  _onSelectedNotification(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      Navigator.of(Routes.navigatorKey!.currentContext!).pushNamed(payload);
    }
  }

  show(NotificationModel notification) {
    androidDetails = const AndroidNotificationDetails(
      'lembrete_notifications_x',
      'Lembretes',
      channelDescription: 'Notifications Poc',
      importance: Importance.max,
      priority: Priority.max,
    );

    iosDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    localNotificationsPlugin.show(
      notification.id,
      notification.title,
      notification.body,
      NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      ),
      payload: notification.payload,
    );
  }

  schedule(NotificationModel notification) {
    var date = DateTime.now().add(const Duration(seconds: 5));

    androidDetails = const AndroidNotificationDetails(
      'schedule_notifications',
      'Notificação agendada',
      channelDescription: 'Notifications agendada Poc',
      importance: Importance.max,
      priority: Priority.max,
    );

    iosDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    localNotificationsPlugin.zonedSchedule(
      notification.id,
      notification.title,
      notification.body,
      tz.TZDateTime.from(date, tz.local),
      NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      ),
      payload: notification.payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  checkForNotifications() async {
    var details =
        await localNotificationsPlugin.getNotificationAppLaunchDetails();

    String? payload = details?.notificationResponse?.payload;

    if (payload != null &&
        payload.isNotEmpty &&
        details!.didNotificationLaunchApp) {
      _onSelectedNotification(payload);
    }
  }

  cancelNotifications() async {
    await localNotificationsPlugin.cancelAll();
  }
}
