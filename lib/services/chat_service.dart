import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chat_app/services/auth_services.dart';

import 'package:chat_app/global/environment.dart';

import 'package:chat_app/models/message_respose.dart';
import 'package:chat_app/models/user.dart';

class ChatService with ChangeNotifier {
  User? userFrom;

  Future<List<Message>> getChat(String userID) async {
    final resp = await http
        .get(Uri.parse('${Environment.apiUrl}/messages/${userID}'), headers: {
      'Content-Type': 'application/json',
      'x-token': await AuthService.getToken()
    });
    final messageRes = mensageResponseFromJson(resp.body);
    return messageRes.messages;
  }
}
