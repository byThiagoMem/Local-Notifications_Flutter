import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'pages/notification_page.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> list =
      <String, WidgetBuilder>{
    '/home': (_) => const HomePage(),
    '/notification': (_) => const NotificacaoPage(),
  };

  static String initial = '/home';

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}
