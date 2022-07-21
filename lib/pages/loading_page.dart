import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/services/auth_services.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return Center(
            child: const Text('Cargando...'),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context);

    final authenting = await authService.isLoggedIn();

    if (authenting) {
      // TODO conectar al socket server
      socketService.connect();
      Navigator.pushReplacementNamed(context, 'users');
    } else {
      Navigator.pushReplacementNamed(context, 'login');
    }
  }
}
