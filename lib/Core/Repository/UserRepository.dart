import 'dart:convert';

import 'package:messaging_demo_flutter/Core/Data/SharedPrefs.dart';
import 'package:messaging_demo_flutter/Core/Helpers/Constants.dart';
import 'package:messaging_demo_flutter/Core/Helpers/Utils.dart';
import 'package:messaging_demo_flutter/Core/Models/Message.dart';
import 'package:messaging_demo_flutter/Core/Models/Profile.dart';
import 'package:messaging_demo_flutter/Core/Networking/ApiProvider.dart';
import 'package:messaging_demo_flutter/Core/Networking/ChatRoomResponse.dart';
import 'package:messaging_demo_flutter/Core/Networking/FriendsListResponse.dart';
import 'package:messaging_demo_flutter/Core/Networking/LoginResponse.dart';
import 'package:messaging_demo_flutter/Core/Networking/ProfileDetailsResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  ///Singleton
  static final UserRepository _userRepository = UserRepository._internal();

  factory UserRepository() {
    return _userRepository;
  }

  UserRepository._internal();

  ApiProvider apiProvider = new ApiProvider();

  ///Added delay of 2 seconds, verifying token, if its in [SharedPreferences]
  Future<bool> checkUserAuthentication() async {
    return Future.delayed(Constants.DURATION_2,
        () async => await SharedPrefs.getSavedAuthToken() != "");
  }

  Future<LoginResponse> loginUserWithDetails(
      String email, String password) async {
    final response = await apiProvider.loginUserWithDetails(email, password);
    return loginResponseFromJson(response);
  }

  /// Using same [LoginResponse] for signUp as well as response is same in both case
  Future<LoginResponse> singUpUserWithDetails(
      String email, String password) async {
    final response = await apiProvider.signUpUserWithDetails(email, password);
    return loginResponseFromJson(response);
  }

  Future<FriendsListResponse> fetchFriends(int page) async {
    final response = await apiProvider.getFriendsList(page);
    Utils.log("FetchFriends API", "Fetched Response for page $page", response);
    return friendsListResponseFromJson(response);
  }

  Future<MessagesResponse> fetchMessages(int id) async {
    final response = await apiProvider.getMessages(id);
    Utils.log(
        "FetchMessages API", "Fetched Response for friendsID $id", response);
    return messagesResponseFromJson(response);
  }

  Future<MessagesResponse> sendMessage(Message message, int id) async {
    final response = await apiProvider.sendMessage(message, id);
    Utils.log("FetchMessages API", "Send Message to friendsID $id", response);
    return messagesResponseFromJson(response);
  }

  Future<ProfileDetailsResponse> fetchProfileDetails() async {
    final response = await apiProvider.fetchProfile();
    Utils.log("FetchProfile API", "Fetch Response", response);
    return profileDetailsResponseFromJson(response);
  }

  Future<ProfileDetailsResponse> updateProfileDetails(Profile profile) async {
    final response = await apiProvider.updateProfile(profile);
    Utils.log("FetchProfile API", "Fetch Response", response);
    return profileDetailsResponseFromJson(response);
  }

  Future<String> logoutUser() async {
    final response = await apiProvider.logoutUser();
    return json.decode(response)["response"];
  }
}
