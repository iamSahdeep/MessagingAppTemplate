import 'dart:convert';

import 'package:messaging_demo_flutter/Core/Models/Profile.dart';

ProfileDetailsResponse profileDetailsResponseFromJson(String str) => ProfileDetailsResponse.fromJson(json.decode(str));

String profileDetailsResponseToJson(ProfileDetailsResponse data) => json.encode(data.toJson());

class ProfileDetailsResponse {
  ProfileDetailsResponse({
    this.profile,
  });

  final Profile profile;

  //Changed for Test
  factory ProfileDetailsResponse.fromJson(Map<String, dynamic> json) => ProfileDetailsResponse(
    profile: Profile.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "profile": profile.toJson(),
  };
}