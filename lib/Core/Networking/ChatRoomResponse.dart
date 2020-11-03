import 'dart:convert';

import 'package:messaging_demo_flutter/Core/Models/Message.dart';

MessagesResponse messagesResponseFromJson(String str) =>
    MessagesResponse.fromJson(json.decode(str));

String messagesResponseToJson(MessagesResponse data) =>
    json.encode(data.toJson());

class MessagesResponse {
  MessagesResponse({
    this.messages,
  });

  final List<Message> messages;

  //Changed for Test
  factory MessagesResponse.fromJson(Map<String, dynamic> json) =>
      MessagesResponse(
        messages: List<Message>.from(
            json["data"].map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
      };
}
