import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notifications/models/notification_model.dart';
import 'package:notifications/services/notification_service.dart';

import '../routes.dart';

class FirebaseMessagingService {
  final NotificationService _notificationService;

  FirebaseMessagingService(
    this._notificationService,
  );

  Future<void> initialize() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      badge: true,
      alert: true,
      sound: true,
    );
    getDeviceFirebaseToken();
    _onMessage();
    _onMessageOpeenedApp();
  }

  getDeviceFirebaseToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    debugPrint('=======================================');
    debugPrint('TOKEN => $token');
    debugPrint('=======================================');
  }

  // Capturar notificcação quando o app está aberto ou em background
  _onMessage() {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      /* AndroidNotification? android = message.notification?.android;
      AppleNotification? apple = message.notification?.apple; */

      if (notification != null) {
        _notificationService.show(
          NotificationModel(
            id: notification.hashCode,
            title: notification.title,
            body: notification.body,
            payload: message.data['route'] ?? '',
          ),
        );
      }
    });
  }

  // Capturar notificação quando o app está fechado
  // Mesma função do método [checkForNotifications] em [Notification Service]

  _onMessageOpeenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen(_goToPageAfterMesage);
  }

  _goToPageAfterMesage(message) {
    String route = message.data['route'] ?? '';
    if (route.isNotEmpty) {
      Routes.navigatorKey?.currentState?.pushNamed(route);
    }
  }
}
