// To parse this JSON data, do
//
//     final userListResponse = userListResponseFromJson(jsonString);

import 'package:chat_app/models/user.dart';
import 'dart:convert';

UserListResponse userListResponseFromJson(String str) =>
    UserListResponse.fromJson(json.decode(str));

String userListResponseToJson(UserListResponse data) =>
    json.encode(data.toJson());

class UserListResponse {
  UserListResponse({
    required this.ok,
    required this.users,
  });

  bool ok;
  List<User> users;

  factory UserListResponse.fromJson(Map<String, dynamic> json) =>
      UserListResponse(
        ok: json["ok"],
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
      };
}
