import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messaging_demo_flutter/Core/ChangeNotifiers/ChatRoomNotifier.dart';
import 'package:messaging_demo_flutter/Core/Data/SharedPrefs.dart';
import 'package:messaging_demo_flutter/Core/Helpers/Enums.dart';
import 'package:messaging_demo_flutter/Core/Helpers/Utils.dart';
import 'package:messaging_demo_flutter/Core/Models/Friend.dart';
import 'package:messaging_demo_flutter/UI/Widgets/MessageTile.dart';
import 'package:provider/provider.dart';

import 'LoginScreen.dart';

class ChatRoomScreen extends StatefulWidget {
  static const TAG = "ChatRoomScreen";
  static const Route = "ChatRoomScreenRoute";

  final Friend friend;

  const ChatRoomScreen({Key key, this.friend}) : super(key: key);

  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ChatRoomNotifier>(context, listen: false)
          .fetchMessages(widget.friend.friendId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatRoomNotifier>(context);
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(widget.friend.name),
        ),
        body: RefreshIndicator(
          onRefresh: () {
            Utils.log(ChatRoomScreen.TAG, "Reloading Messaging Screen",
                "Error : " + chatProvider.errorString);
            return chatProvider.fetchMessages(widget.friend.friendId);
          },
          child: Builder(
            builder: (ctx) {
              if (chatProvider.dataFetchingStatus ==
                  DataFetchingStatus.fetching) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (chatProvider.dataFetchingStatus ==
                  DataFetchingStatus.error) {
                return Center(
                  child: Text(chatProvider.errorString),
                );
              } else if (chatProvider.messages.length == 0) {
                return Center(
                  child: Column(
                    children: [
                      Text(chatProvider.errorString),
                      if (chatProvider.errorString.contains("Unauthorised:"))
                        FlatButton(
                          onPressed: () {
                            Utils.log(ChatRoomScreen.TAG, "Need to ReLogin",
                                "Error : " + chatProvider.errorString);
                            SharedPrefs.saveAuthToken("");
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                LoginScreen.Route, (route) => false);
                          },
                          child: Text("Re Login"),
                        )
                    ],
                  ),
                );
              } else {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: chatProvider.messages.length,
                        itemBuilder: (context, index) {
                          return MessageTile(
                              message: chatProvider.messages[index]);
                        },
                      ),
                    ),
                    Card(
                      elevation: 10,
                      child: Row(
                        children: [
                          IconButton(
                              icon: Icon(Icons.add_circle_sharp),
                              onPressed: () {
                                chatProvider.pickImageFromGallery();
                              }),
                          IconButton(
                              icon: Icon(Icons.camera_alt),
                              onPressed: () {
                                chatProvider.pickImageFromCamera();
                              }),
                          Expanded(
                            child: TextField(
                              controller: chatProvider.textController,
                              focusNode: FocusNode(),
                              decoration:
                                  InputDecoration(hintText: "Your message..."),
                              textCapitalization: TextCapitalization.sentences,
                            ),
                          ),
                          IconButton(
                              icon: Icon(Icons.send),
                              onPressed: () {
                                chatProvider.sendText();
                              }),
                        ],
                      ),
                    )
                  ],
                );
              }
            },
          ),
        ));
  }
}
