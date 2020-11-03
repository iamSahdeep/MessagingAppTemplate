import 'package:messaging_demo_flutter/Core/Helpers/Configuration.dart';

class ApiEndpoints {
  static const LocalBaseURL = "https://198:162.0.1:433";
  static const StagingBaseURL = "https://com.simple.chat:433";
  static const ProdBaseURL = "https://com.simple.chat:433";
  //Changed for Test
  static const LoginEndPoint = "/login";
  static const SignUpEndPoint = "/create";
  //Changed for Test
  static const FriendsListEndPoint = "/users";
  //Changed for Test
  static const MessagesEndPoint = "/user";
  //Changed for Test
  static const ProfileEndPoint = "/users/1";

  //Changed for Test
  static get BaseURL => "https://reqres.in/api";
}
