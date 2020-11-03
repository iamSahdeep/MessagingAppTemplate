import 'package:flutter/material.dart';
import 'package:messaging_demo_flutter/Core/Data/SharedPrefs.dart';
import 'package:messaging_demo_flutter/Core/Helpers/Enums.dart';
import 'package:messaging_demo_flutter/Core/Helpers/Utils.dart';
import 'package:messaging_demo_flutter/Core/Repository/UserRepository.dart';
import 'package:messaging_demo_flutter/UI/Screens/LoginScreen.dart';

class LoginNotifier extends ChangeNotifier {
  UserRepository _userRepository = UserRepository();
  String errorString;
  AuthenticationStatus authenticationStatus = AuthenticationStatus.Unknown;

  ///Made them [Future] to wait and check response on Button click and show snackBar accordingly
  Future<void> handleLoginClick() async {
    try {
      final loginResponse = await _userRepository.loginUserWithDetails(
          "eve.holt@reqres.in", "cityslicka");
      if (loginResponse != null && loginResponse.token != null) {
        Utils.log(LoginScreen.TAG, "Login Saving Token", loginResponse.token);
        SharedPrefs.saveAuthToken(loginResponse.token);
        authenticationStatus = AuthenticationStatus.Authenticated;
      } else {
        Utils.log(LoginScreen.TAG, "Could not fetch token",
            "token = " + loginResponse.token);
        authenticationStatus = AuthenticationStatus.UnAuthenticated;
      }
      notifyListeners();
    } catch (e) {
      errorString = e.toString();
      Utils.log(
          LoginScreen.TAG, "Login Api : Something went wrong", errorString);
      notifyListeners();
    }
  }

  Future<void> handleSignUpClick() async {
    try {
      final signUpResponse = await _userRepository.singUpUserWithDetails(
          "sahdeepsingh98@gmail.com", "password");
      if (signUpResponse != null && signUpResponse.token != null) {
        Utils.log(LoginScreen.TAG, "SignUp Saving Token", signUpResponse.token);
        SharedPrefs.saveAuthToken(signUpResponse.token);
        authenticationStatus = AuthenticationStatus.Authenticated;
      } else {
        Utils.log(LoginScreen.TAG, "Could not fetch token",
            "token = " + signUpResponse.token);
        authenticationStatus = AuthenticationStatus.UnAuthenticated;
      }
      notifyListeners();
    } catch (e) {
      errorString = e.toString();
      Utils.log(
          LoginScreen.TAG, "SignUp Api : Something went wrong", errorString);
      notifyListeners();
    }
  }
}
