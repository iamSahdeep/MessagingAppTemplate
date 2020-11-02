import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:messaging_demo_flutter/Core/Data/SharedPrefs.dart';
import 'package:messaging_demo_flutter/Core/Helpers/ApiEndpoints.dart';
import 'package:messaging_demo_flutter/Core/Helpers/ExceptionHelper.dart';
import 'package:messaging_demo_flutter/Core/Models/Message.dart';
import 'package:messaging_demo_flutter/Core/Models/Profile.dart';

class ApiProvider {
  Map<String, String> _defaultHeaders = {"Content-type": "application/json"};

  Future<Map<String, String>> _authHeaders() async => {
        "Content-type": "application/json",
        "Authorization": "Bearer ${await SharedPrefs.getSavedAuthToken()}"
      };

  Future<dynamic> loginUserWithDetails(String email, String password) async {
    var responseJson;
    try {
      final response = await http.post(
          ApiEndpoints.BaseURL + ApiEndpoints.LoginEndPoint,
          headers: _defaultHeaders,
          body: jsonEncode({"email": email, "password": password}));
      responseJson = _handleResponse(response);
    } on SocketException {
      throw FetchDataException(
          'No Internet connection / Could not reach the host');
    }
    return responseJson;
  }

  Future<dynamic> signUpUserWithDetails(String email, String password) async {
    var responseJson;
    try {
      final response = await http.post(
          ApiEndpoints.BaseURL + ApiEndpoints.SignUpEndPoint,
          headers: _defaultHeaders,
          body: jsonEncode({"email": email, "password": password}));
      responseJson = _handleResponse(response);
    } on SocketException {
      throw FetchDataException(
          'No Internet connection / Could not reach the host');
    }
    return responseJson;
  }

  Future<dynamic> getFriendsList(int page) async {
    var responseJson;
    try {
      final response = await http.get(
          ApiEndpoints.BaseURL +
              ApiEndpoints.FriendsListEndPoint +
              "/" +
              page.toString(),
          headers: await _authHeaders());
      responseJson = _handleResponse(response);
    } on SocketException {
      throw FetchDataException(
          'No Internet connection / Could not reach the host');
    }
    return responseJson;
  }

  Future<dynamic> getMessages(int id) async {
    var responseJson;
    try {
      final response = await http.get(
          ApiEndpoints.BaseURL +
              ApiEndpoints.MessagesEndPoint +
              "/" +
              id.toString(),
          headers: await _authHeaders());
      responseJson = _handleResponse(response);
    } on SocketException {
      throw FetchDataException(
          'No Internet connection / Could not reach the host');
    }
    return responseJson;
  }

  Future<dynamic> sendMessage(Message message, int id) async {
    var responseJson;
    try {
      final response = await http.post(
          ApiEndpoints.BaseURL +
              ApiEndpoints.MessagesEndPoint +
              "/" +
              id.toString(),
          body: jsonEncode(message.toJson()),
          headers: await _authHeaders());
      responseJson = _handleResponse(response);
    } on SocketException {
      throw FetchDataException(
          'No Internet connection / Could not reach the host');
    }
    return responseJson;
  }

  Future<dynamic> fetchProfile() async {
    var responseJson;
    try {
      final response = await http.get(
          ApiEndpoints.BaseURL + ApiEndpoints.ProfileEndPoint,
          headers: await _authHeaders());
      responseJson = _handleResponse(response);
    } on SocketException {
      throw FetchDataException(
          'No Internet connection / Could not reach the host');
    }
    return responseJson;
  }

  Future<dynamic> updateProfile(Profile profile) async {
    var responseJson;
    try {
      final response = await http.patch(
          ApiEndpoints.BaseURL + ApiEndpoints.ProfileEndPoint,
          body: jsonEncode(profile.toJson()));
      responseJson = _handleResponse(response);
    } on SocketException {
      throw FetchDataException(
          'No Internet connection / Could not reach the host');
    }
    return responseJson;
  }

  Future<dynamic> logoutUser() async {
    var responseJson;
    try {
      final response = await http.delete(
          ApiEndpoints.BaseURL + ApiEndpoints.LoginEndPoint,
          headers: await _authHeaders());
      responseJson = _handleResponse(response);
    } on SocketException {
      throw FetchDataException(
          'No Internet connection / Could not reach the host');
    }
    return responseJson;
  }

  dynamic _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response.body;
      case 400:
        throw BadRequestException(response.body);
      case 401:
      case 403:
        throw UnauthorisedException(response.body);
      case 404:
        throw FetchDataException('Requested Endpoint not found');
      case 500:
        throw FetchDataException(response.body);
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
