import 'dart:convert';

import 'package:messaging_demo_flutter/Core/Models/Friend.dart';

FriendsListResponse friendsListResponseFromJson(String str) => FriendsListResponse.fromJson(json.decode(str));

String friendsListResponseToJson(FriendsListResponse data) => json.encode(data.toJson());

class FriendsListResponse {
  FriendsListResponse({
    this.friends,
  });

  final List<Friend> friends;

  factory FriendsListResponse.fromJson(Map<String, dynamic> json) => FriendsListResponse(
    friends: List<Friend>.from(json["data"].map((x) => Friend.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "friends": List<dynamic>.from(friends.map((x) => x.toJson())),
  };
}

