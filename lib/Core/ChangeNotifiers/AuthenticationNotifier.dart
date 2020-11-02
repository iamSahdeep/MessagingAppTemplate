import 'package:flutter/cupertino.dart';
import 'package:messaging_demo_flutter/Core/Helpers/Enums.dart';
import 'package:messaging_demo_flutter/Core/Helpers/Utils.dart';
import 'package:messaging_demo_flutter/Core/Repository/UserRepository.dart';
import 'package:messaging_demo_flutter/UI/Screens/SplashScreen.dart';

class AuthenticationNotifier extends ChangeNotifier {
  UserRepository _userRepository = UserRepository();
  AuthenticationStatus authenticationStatus = AuthenticationStatus.Unknown;

  AuthenticationNotifier() {
    checkToken();
  }

  void checkToken() async {
    Utils.log(SplashScreen.TAG, "Token", "Checking");
    final isAuthenticated = await _userRepository.checkUserAuthentication();
    if (isAuthenticated) {
      authenticationStatus = AuthenticationStatus.Authenticated;
    } else {
      authenticationStatus = AuthenticationStatus.UnAuthenticated;
    }
    notifyListeners();
  }

  Future<String> logOutUser() async {
    try {
      return await _userRepository.logoutUser();
    } catch (e) {
      return "nope";
    }
  }
}
