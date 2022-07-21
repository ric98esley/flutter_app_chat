import 'package:chat_app/models/users_response.dart';
import 'package:http/http.dart' as http;

import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/global/environment.dart';

import 'package:chat_app/models/user.dart';

class UsersServices {
  Future<List<User>> getUsers() async {
    try {
      final resp = await http.get((Uri.parse('${Environment.apiUrl}/users')),
          headers: {
            'Content-Type': 'application/json',
            'x-token': await AuthService.getToken()
          });
      final userListResponse = userListResponseFromJson(resp.body);
      return userListResponse.users;
    } catch (e) {
      return [];
    }
  }
}
