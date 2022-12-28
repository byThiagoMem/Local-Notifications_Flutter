import 'package:flutter/material.dart';
import 'package:notifications/models/notification_model.dart';
import 'package:notifications/services/notification_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool valor = false;

  showNotification() {
    setState(() {
      valor = !valor;
      if (valor) {
        Provider.of<NotificationService>(context, listen: false)
            .show(NotificationModel(
          id: 1,
          title: 'Teste',
          body: 'Acesse o app',
          payload: '/notification',
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 162, 193, 234),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              child: ListTile(
                title: const Text('Lembrar-me mais tarde'),
                trailing: valor
                    ? Icon(Icons.check_box, color: Colors.amber.shade600)
                    : const Icon(Icons.check_box_outline_blank),
                onTap: showNotification,
              ),
            ),
          ),
          TextButton(
            onPressed: () =>
                Provider.of<NotificationService>(context, listen: false)
                    .cancelNotifications(),
            child: const Text(
              'Cancelar',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
