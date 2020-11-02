import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messaging_demo_flutter/Core/Helpers/Enums.dart';
import 'package:messaging_demo_flutter/Core/Helpers/Utils.dart';
import 'package:messaging_demo_flutter/Core/Models/Message.dart';
import 'package:messaging_demo_flutter/Core/Repository/UserRepository.dart';
import 'package:messaging_demo_flutter/UI/Screens/ChatRoomScreen.dart';

class ChatRoomNotifier extends ChangeNotifier {
  UserRepository userRepository = UserRepository();
  List<Message> messages;
  String errorString;
  DataFetchingStatus dataFetchingStatus = DataFetchingStatus.fetching;

  TextEditingController textController = TextEditingController();

  Future<void> fetchMessages(int id) async {
    try {
      final response = await userRepository.fetchMessages(id);
      Utils.log(ChatRoomScreen.TAG, "Fetching Messages",
          " current Status $dataFetchingStatus");
      if (response != null && response.messages != null) {
        messages = response.messages;
        Utils.log(ChatRoomScreen.TAG, "Fetching messages successful",
            "Messages Count :  ${messages.length}");
        dataFetchingStatus = DataFetchingStatus.fetched;
        notifyListeners();
      } else {
        throw Exception("Internal Data Error");
      }
      notifyListeners();
    } catch (e) {
      errorString = e.toString();
      Utils.log(ChatRoomScreen.TAG, "Chat Messages Api : Something went wrong",
          errorString);
      dataFetchingStatus = DataFetchingStatus.error;
      notifyListeners();
    }
  }

  void sendText() {
    if (textController.text.isNotEmpty) {
      messages.add(Message(name: "me", text: textController.text));
      textController.text = "";
      notifyListeners();
    }
  }

  void pickImageFromGallery() async {
    File target =
        File((await ImagePicker().getImage(source: ImageSource.gallery)).path);
    if (target != null) {
      messages.add(Message(name: "me", text: "localFile" + target.path));
      notifyListeners();
    }
  }

  void pickImageFromCamera() async {
    File target =
        File((await ImagePicker().getImage(source: ImageSource.camera)).path);
    if (target != null) {
      messages.add(Message(name: "me", text: "localFile" + target.path));
      notifyListeners();
    }
  }
}
