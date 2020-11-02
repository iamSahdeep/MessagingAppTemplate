import 'package:flutter/material.dart';
import 'package:messaging_demo_flutter/Core/ChangeNotifiers/LoginNotifier.dart';
import 'package:messaging_demo_flutter/Core/Helpers/Enums.dart';
import 'package:messaging_demo_flutter/Core/Helpers/Utils.dart';
import 'package:provider/provider.dart';

import 'FriendsListScreen.dart';

class LoginScreen extends StatelessWidget {
  static const TAG = "LoginScreen";
  static const Route = "LoginScreenRoute";
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginNotifier>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text("Login")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            FlatButton(
              onPressed: () async {
                await loginProvider.handleLoginClick();
                Utils.log(LoginScreen.TAG, "Auth Status after login",
                    loginProvider.authenticationStatus.toString());
                if (loginProvider.authenticationStatus ==
                    AuthenticationStatus.Authenticated) {
                  Utils.log(LoginScreen.TAG, "Logged In",
                      loginProvider.authenticationStatus.toString());
                  Navigator.of(context)
                      .pushReplacementNamed(FriendsListScreen.Route);
                } else {
                  Utils.log(LoginScreen.TAG, "Show Snackbar ",
                      loginProvider.errorString);
                  _scaffoldKey.currentState.showSnackBar(
                      SnackBar(content: Text(loginProvider.errorString)));
                }
              },
              child: Text(
                "Simulate Login",
                style: TextStyle(fontSize: 20),
              ),
            ),
            FlatButton(
              onPressed: () async {
                await loginProvider.handleSignUpClick();
                Utils.log(LoginScreen.TAG, "Auth Status after SignUp",
                    loginProvider.authenticationStatus.toString());
                if (loginProvider.authenticationStatus ==
                    AuthenticationStatus.Authenticated) {
                  Utils.log(LoginScreen.TAG, "Signed Up",
                      loginProvider.authenticationStatus.toString());
                  Navigator.of(context)
                      .pushReplacementNamed(FriendsListScreen.Route);
                } else {
                  Utils.log(LoginScreen.TAG, "Show Snackbar ",
                      loginProvider.errorString);
                  _scaffoldKey.currentState.showSnackBar(
                      SnackBar(content: Text(loginProvider.errorString)));
                }
              },
              child: Text(
                "Simulate SignUp",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
