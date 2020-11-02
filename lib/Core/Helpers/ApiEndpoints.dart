import 'package:messaging_demo_flutter/Core/Helpers/Configuration.dart';

class ApiEndpoints {
  static const LocalBaseURL = "https://198:162.0.1:433";
  static const StagingBaseURL = "https://com.simple.chat:433";
  static const ProdBaseURL = "https://com.simple.chat:433";
  static const LoginEndPoint = "/login";
  static const SignUpEndPoint = "/create";
  static const FriendsListEndPoint = "/friends";
  static const MessagesEndPoint = "/messages";
  static const ProfileEndPoint = "/profile";

  static get BaseURL => Configuration.getBaseUrl();
}
