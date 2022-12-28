import 'package:flutter/material.dart';

class NotificacaoPage extends StatelessWidget {
  const NotificacaoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 162, 193, 234),
      appBar: AppBar(
        title: const Text('Novidades'),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.message_outlined,
              size: 48,
            ),
            Text(
              'Novidades após a Notificação Push! ',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
