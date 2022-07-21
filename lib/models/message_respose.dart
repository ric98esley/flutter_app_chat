// To parse this JSON data, do
//
//     final mensageResponse = mensageResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MensageResponse mensageResponseFromJson(String str) =>
    MensageResponse.fromJson(json.decode(str));

String mensageResponseToJson(MensageResponse data) =>
    json.encode(data.toJson());

class MensageResponse {
  MensageResponse({
    required this.ok,
    required this.messages,
  });

  bool ok;
  List<Message> messages;

  factory MensageResponse.fromJson(Map<String, dynamic> json) =>
      MensageResponse(
        ok: json["ok"],
        messages: List<Message>.from(
            json["messages"].map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
      };
}

class Message {
  Message({
    required this.from,
    required this.to,
    required this.msg,
    required this.createdAt,
    required this.updatedAt,
  });

  String from;
  String to;
  String msg;
  DateTime createdAt;
  DateTime updatedAt;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        from: json["from"],
        to: json["to"],
        msg: json["msg"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
        "msg": msg,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
