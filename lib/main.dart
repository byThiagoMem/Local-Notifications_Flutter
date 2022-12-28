import 'package:flutter/material.dart';
import 'package:notifications/services/notification_service.dart';
import 'package:provider/provider.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        Provider<NotificationService>(
          create: (context) => NotificationService(),
        )
      ],
      child: const App(),
    ),
  );
}
