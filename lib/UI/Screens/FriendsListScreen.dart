import 'package:flutter/material.dart';
import 'package:messaging_demo_flutter/Core/ChangeNotifiers/FriendsListNotifier.dart';
import 'package:messaging_demo_flutter/Core/Data/SharedPrefs.dart';
import 'package:messaging_demo_flutter/Core/Helpers/Enums.dart';
import 'package:messaging_demo_flutter/Core/Helpers/Utils.dart';
import 'package:messaging_demo_flutter/UI/Screens/LoginScreen.dart';
import 'package:messaging_demo_flutter/UI/Screens/ProfileScreen.dart';
import 'package:messaging_demo_flutter/UI/Widgets/AppDrawer.dart';
import 'package:messaging_demo_flutter/UI/Widgets/FriendTile.dart';
import 'package:provider/provider.dart';

class FriendsListScreen extends StatefulWidget {
  static const TAG = "FriendsListScreen";
  static const Route = "FriendsListScreenRoute";

  @override
  _FriendsListScreenState createState() => _FriendsListScreenState();
}

class _FriendsListScreenState extends State<FriendsListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FriendsListNotifier>(context, listen: false).fetchFriends();
    });
  }

  @override
  Widget build(BuildContext context) {
    final friendsListProvider = Provider.of<FriendsListNotifier>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("List"),
          actions: [
            if (friendsListProvider.dataFetchingStatus ==
                DataFetchingStatus.fetched)
              IconButton(
                  icon: Icon(Icons.person_rounded),
                  onPressed: () {
                    Utils.log(FriendsListScreen.TAG, "Navigator",
                        "Navigate to Profile Screen");
                    Navigator.of(context).pushNamed(ProfileScreen.Route);
                  })
          ],
        ),
        drawer: AppDrawer(),
        body: Builder(
          builder: (ctx) {
            if (friendsListProvider.dataFetchingStatus ==
                DataFetchingStatus.fetching) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (friendsListProvider.dataFetchingStatus ==
                DataFetchingStatus.error) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(friendsListProvider.errorString),
                    ),
                    if (friendsListProvider.errorString
                        .contains("Unauthorised:"))
                      FlatButton(
                        onPressed: () {
                          Utils.log(FriendsListScreen.TAG, "Need to ReLogin",
                              "Error : " + friendsListProvider.errorString);
                          SharedPrefs.saveAuthToken("");
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              LoginScreen.Route, (route) => false);
                        },
                        child: Text("Re Login"),
                      )
                  ],
                ),
              );
            } else if (friendsListProvider.friends.length == 0) {
              return Center(
                child: Text("No Recent Chats"),
              );
            } else
              return ListView.builder(
                itemCount: friendsListProvider.friends.length,
                itemBuilder: (context, index) {
                  return FriendTile(friend: friendsListProvider.friends[index]);
                },
              );
          },
        ));
  }
}
