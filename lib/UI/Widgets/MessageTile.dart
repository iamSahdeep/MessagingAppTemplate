import 'dart:io';

import 'package:flutter/material.dart';
import 'package:messaging_demo_flutter/Core/Helpers/Utils.dart';
import 'package:messaging_demo_flutter/Core/Models/Message.dart';

class MessageTile extends StatelessWidget {
  final Message message;

  const MessageTile({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(message.name + " :"),
              if (Utils.isValidURL(message.text))
                Container(
                  width: 200,
                  height: 200,
                  child: Image.network(message.text),
                )
              else if (message.text.startsWith("localFile"))
                Container(
                  width: 200,
                  height: 200,
                  child:
                      Image.file(File(message.text.replaceFirst("localFile", ""))),
                )
              else
                Text(message.text),
            ],
          ),
        ),
      ),
    );
  }
}
