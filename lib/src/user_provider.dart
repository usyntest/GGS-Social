import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserProvider extends ChangeNotifier {
  String _name;
  String _email;
  String _apiKey;
  bool _isLoggedIn;

  bool get isLoggedIn => _isLoggedIn;
  String get email => _email;
  String get name => _name;
  String get apiKey => _apiKey;

  UserProvider(this._name, this._email, this._isLoggedIn, this._apiKey);

  Future<String> checkDetails(email, password) async {
    String url = 'http://10.0.2.2:5000/auth/login/';
    Map<String, String> data = {"password": password, "email": email};
    Map<String, String> request_headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    String apiErrorMessage = '';

    try {
      // Make the POST request
      http.Response response = await http.post(Uri.parse(url),
          body: jsonEncode(data), headers: request_headers);

      if (response.statusCode == 200) {
        _name = jsonDecode(response.body)['name'];
        _email = jsonDecode(response.body)['email'];
        _isLoggedIn = true;
        _apiKey = jsonDecode(response.body)['apiKey'];
        return apiErrorMessage;
      }
      apiErrorMessage = 'Invalid Password or Email';
    } catch (error) {
      print('Error making the POST request: $error'); // remove in production
      apiErrorMessage = 'Couldn\'t make the request';
    }
    return apiErrorMessage;
  }

  void login() {
    notifyListeners();
  }
}