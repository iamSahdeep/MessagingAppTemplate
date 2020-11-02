import 'package:flutter/cupertino.dart';
import 'package:messaging_demo_flutter/Core/Helpers/Enums.dart';
import 'package:messaging_demo_flutter/Core/Helpers/Utils.dart';
import 'package:messaging_demo_flutter/Core/Models/Friend.dart';
import 'package:messaging_demo_flutter/Core/Repository/UserRepository.dart';
import 'package:messaging_demo_flutter/UI/Screens/FriendsListScreen.dart';

class FriendsListNotifier extends ChangeNotifier {
  UserRepository userRepository = UserRepository();
  List<Friend> friends;
  String errorString;

  DataFetchingStatus dataFetchingStatus = DataFetchingStatus.fetching;

  Future<void> fetchFriends() async {
    try {
      final response = await userRepository.fetchFriends(1);
      Utils.log(FriendsListScreen.TAG, "Fetched Friends",
          "Count" + response.friends.length.toString());
      if (response != null && response.friends != null) {
        friends = response.friends;
        dataFetchingStatus = DataFetchingStatus.fetched;
        Utils.log(FriendsListScreen.TAG, "Fetched Friends Status",
            dataFetchingStatus.toString());
        notifyListeners();
      } else {
        throw Exception("Internal Data Error");
      }
      notifyListeners();
    } catch (e) {
      errorString = e.toString();
      Utils.log(FriendsListScreen.TAG,
          "Friends List Api : Something went wrong", errorString);
      dataFetchingStatus = DataFetchingStatus.error;
      notifyListeners();
    }
  }
}
