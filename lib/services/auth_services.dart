import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chat_app/models/user.dart';
import 'package:chat_app/models/login_response.dart';
import 'package:chat_app/global/environment.dart';

class AuthService with ChangeNotifier {
  late User _user;
  bool _autenticando = false;
  final _storage = FlutterSecureStorage();
  bool get auntenticando => _autenticando;
  set autenticando(bool valor) {
    _autenticando = valor;
    notifyListeners();
  }

  get user => _user;
  // Getters del token statics
  static Future<String?> getToken() async {
    final _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<String?> deleteToken() async {
    final _storage = FlutterSecureStorage();
    final token = await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    autenticando = true;
    final data = {'email': email, 'password': password};

    final resp = await http.post(Uri.parse('${Environment.apiUrl}/login'),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      _user = loginResponse.user;
      // guardar en un lugar seguro
      await _saveToken(loginResponse.token);
      autenticando = false;

      return true;
    } else {
      autenticando = false;
      return false;
    }
  }

  Future register(String name, String email, String password) async {
    autenticando = true;
    final data = {'name': name, 'email': email, 'password': password};

    final resp = await http.post(Uri.parse('${Environment.apiUrl}/login/new'),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      _user = loginResponse.user;
      // guardar en un lugar seguro
      await _saveToken(loginResponse.token);
      autenticando = false;
      return true;
    } else {
      final resBody = jsonDecode(resp.body);
      autenticando = false;
      return resBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token');

    final resp = await http.get(Uri.parse('${Environment.apiUrl}/login/renew'),
        headers: {
          'Content-Type': 'application/json',
          'x-token': token.toString()
        });

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      _user = loginResponse.user;
      // guardar en un lugar seguro
      await _saveToken(loginResponse.token);
      autenticando = false;
      return true;
    } else {
      logout();
      return false;
    }
  }

  Future _saveToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }
}
