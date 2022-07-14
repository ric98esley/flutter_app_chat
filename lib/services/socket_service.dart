import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'package:chat_app/global/environment.dart';

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  late ServerStatus _serverStatus = ServerStatus.Connecting;
  Socket? _socket;

  ServerStatus get serverStatus => _serverStatus;
  Socket get socket => _socket!;

  void connect() {
    // Dart Client

    _socket = io(
        Environment.socketUrl,
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .enableAutoConnect()
            .enableForceNew() // enable auto-connection
            .build());
    _socket!.onConnect((_) {
      print('Got connected');
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });
    _socket!.onDisconnect((_) {
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
    _socket!.disconnect();
  }
}
