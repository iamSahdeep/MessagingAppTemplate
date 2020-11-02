import 'package:flutter/material.dart';
import 'package:messaging_demo_flutter/Core/Helpers/Utils.dart';
import 'package:messaging_demo_flutter/Core/Models/Friend.dart';
import 'package:messaging_demo_flutter/UI/Screens/ChatRoomScreen.dart';
import 'package:messaging_demo_flutter/UI/Screens/FriendsListScreen.dart';

class FriendTile extends StatelessWidget {
  final Friend friend;

  const FriendTile({Key key, this.friend}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlatButton(
        onPressed: () {
          Utils.log(FriendsListScreen.TAG, "Navigating to ChatRoom",
              "FriendID : ${friend.friendId}");
          Navigator.of(context)
              .pushNamed(ChatRoomScreen.Route, arguments: friend);
        },
        color: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(friend.friendId.toString()),
              Text(friend.name),
              Text(friend.lastMessage),
            ],
          ),
        ),
      ),
    );
  }
}
