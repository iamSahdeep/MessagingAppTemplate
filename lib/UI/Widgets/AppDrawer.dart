import 'package:flutter/material.dart';
import 'package:messaging_demo_flutter/Core/ChangeNotifiers/AuthenticationNotifier.dart';
import 'package:messaging_demo_flutter/Core/ChangeNotifiers/ThemeNotifier.dart';
import 'package:messaging_demo_flutter/Core/Data/SharedPrefs.dart';
import 'package:messaging_demo_flutter/UI/Screens/LoginScreen.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final authProvider = Provider.of<AuthenticationNotifier>(context);
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text("Dark Mode"),
                Switch(
                    value: themeNotifier.isDarkMode(),
                    onChanged: themeNotifier.onSwitchChanged),
              ],
            ),
            FlatButton(
              onPressed: () async {
                String response = await authProvider.logOutUser();
                if (response.toLowerCase().contains("success")) {
                  SharedPrefs.saveAuthToken("");
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      LoginScreen.Route, (route) => false);
                } else {
                  ///Adding intentionally
                  SharedPrefs.saveAuthToken("");
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      LoginScreen.Route, (route) => false);
                }
              },
              child: Text("LogOut"),
            )
          ],
        ),
      ),
    );
  }
}
