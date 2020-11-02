import 'package:flutter/cupertino.dart';
import 'package:messaging_demo_flutter/Core/Helpers/Enums.dart';
import 'package:messaging_demo_flutter/Core/Helpers/Utils.dart';
import 'package:messaging_demo_flutter/Core/Models/Profile.dart';
import 'package:messaging_demo_flutter/Core/Repository/UserRepository.dart';
import 'package:messaging_demo_flutter/UI/Screens/ProfileScreen.dart';

class ProfileNotifier extends ChangeNotifier {
  UserRepository _userRepository = UserRepository();
  Profile user;
  String errorString, updateErrorString;
  DataFetchingStatus dataFetchingStatus = DataFetchingStatus.fetching;
  DataFetchingStatus updateStatus;

  Future<void> fetchUserDetails() async {
    try {
      final response = await _userRepository.fetchProfileDetails();
      if (response != null && response.profile != null) {
        user = response.profile;
        dataFetchingStatus = DataFetchingStatus.fetched;
        Utils.log(ProfileScreen.TAG, "Profile Api : Fetched profile",
            response.profile.email);
        notifyListeners();
      } else {
        throw Exception("Internal Data Error");
      }
      notifyListeners();
    } catch (e) {
      errorString = e.toString();
      Utils.log(
          ProfileScreen.TAG, "Profile Api : Something went wrong", errorString);
      dataFetchingStatus = DataFetchingStatus.error;
      notifyListeners();
    }
  }

  Future<void> updateProfile(String name, String email) async {
    updateStatus = DataFetchingStatus.fetching;
    notifyListeners();
    try {
      final response = await _userRepository
          .updateProfileDetails(Profile(name: name, email: email));
      if (response != null && response.profile != null) {
        user = response.profile;
        Utils.log(ProfileScreen.TAG, "Profile Update Api : updated",
            response.profile.name);
        updateStatus = DataFetchingStatus.fetched;
        notifyListeners();
      } else {
        throw Exception("Internal Data Error");
      }
      updateStatus = null;
      notifyListeners();
    } catch (e) {
      updateErrorString = e.toString();
      Utils.log(ProfileScreen.TAG, "Profile Update Api : Something went wrong",
          updateErrorString);
      updateStatus = DataFetchingStatus.error;
      notifyListeners();
    }
  }
}
