import 'package:flutter/material.dart';
import 'package:messaging_demo_flutter/Core/ChangeNotifiers/AuthenticationNotifier.dart';
import 'package:messaging_demo_flutter/Core/Helpers/Enums.dart';
import 'package:messaging_demo_flutter/Core/Helpers/Utils.dart';
import 'package:provider/provider.dart';

import 'FriendsListScreen.dart';
import 'LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  static const TAG = "MainScreen";
  static const Route = "MainScreenRoute";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Splash",
            style: TextStyle(fontSize: 30),
          ),
          CircularProgressIndicator(),
        ],
      ),
    ));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final userProvider = Provider.of<AuthenticationNotifier>(context);
    Utils.log(SplashScreen.TAG, "User Auth Status before",
        userProvider.authenticationStatus.toString());
    if (userProvider.authenticationStatus ==
        AuthenticationStatus.Authenticated) {
      Utils.log(SplashScreen.TAG, "User Auth Status after",
          userProvider.authenticationStatus.toString());
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed(FriendsListScreen.Route);
      });
    } else if (userProvider.authenticationStatus ==
        AuthenticationStatus.UnAuthenticated) {
      Utils.log(SplashScreen.TAG, "User Auth Status after",
          userProvider.authenticationStatus.toString());
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed(LoginScreen.Route);
      });
    }
  }
}
