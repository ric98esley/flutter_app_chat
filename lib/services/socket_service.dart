import 'package:chat_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:chat_app/global/environment.dart';

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  late ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;
  IO.Socket get socket => _socket;
  Function get emit => _socket.emit;

  void connect() async {
    final token = await AuthService.getToken();
    // Dart Client

    _socket = IO.io(
        Environment.socketUrl,
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .enableAutoConnect()
            .enableForceNew()
            .setExtraHeaders({'x-token': token}) // enable auto-connection
            .build());
    _socket.onConnect((_) {
      print('Got connected');
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });
    _socket.onDisconnect((_) {
      print('Got disconnect');
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    // _socket!.on('nuevo-mensaje', (payload) {
    //   print('nuevo-mensaje: ');
    //   print('nombre: ${payload['nombre']}');
    //   print('mensaje: ${payload['mensaje']} ');
    // });
  }

  void disconnect() {
    _socket.disconnect();
  }
}
