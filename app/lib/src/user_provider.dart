import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserProvider extends ChangeNotifier {
  String _name;
  String _email;
  String _course;
  String _apiKey;
  bool _isLoggedIn;

  final Map<String, String> courses = {
    "BSC": "B.Sc. (Hons) Computer Science",
    "BCH": "B.Com (Hons)",
    "BCP": "B.Com (Prog)",
    "BPA": "B.A. (Hons) Punjabi",
    "BAE": "B.A. (Hons) Economics",
    "BBE": "Bachelor of Business Economics",
    "BMS": "Bachelor of Management Studies"
  };

  bool get isLoggedIn => _isLoggedIn;
  String get email => _email;
  String get name => _name;
  String get apiKey => _apiKey;
  String get course => _course;

  UserProvider(
      this._name, this._email, this._course, this._isLoggedIn, this._apiKey);

  Future<String> checkDetailsLogin(email, password) async {
    String url = 'http://10.0.2.2:5000/auth/login/';
    Map<String, String> data = {"password": password, "email": email};
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    String apiErrorMessage = '';

    try {
      // Make the POST request
      http.Response response = await http.post(Uri.parse(url),
          body: jsonEncode(data), headers: requestHeaders);

      if (response.statusCode == 200) {
        _name = jsonDecode(response.body)['name'];
        _email = jsonDecode(response.body)['email'];
        _course = jsonDecode(response.body)['course'];
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

  Future<String> checkDetailsRegister(Map<String, String?> data) async {
    String url = 'http://10.0.2.2:5000/auth/register/';
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    String apiErrorMessage = '';

    try {
      // Make the POST request
      http.Response response = await http.post(Uri.parse(url),
          body: jsonEncode(data), headers: requestHeaders);

      if (response.statusCode == 200) {
        _name = jsonDecode(response.body)['name'];
        _email = jsonDecode(response.body)['email'];
        _course = jsonDecode(response.body)['course'];
        _isLoggedIn = true;
        _apiKey = jsonDecode(response.body)['apiKey'];
        return apiErrorMessage;
      }
      if (response.statusCode == 409) {
        apiErrorMessage = 'User Already Exists';
      }
      if (response.statusCode == 406) {
        apiErrorMessage = 'Should have sggscc.ac.in email';
      }
      apiErrorMessage = 'Invalid Request';
    } catch (error) {
      print('Error making the POST request: $error'); // remove in production
      apiErrorMessage = 'Couldn\'t make the request';
    }
    return apiErrorMessage;
  }

  void register() {
    notifyListeners();
  }

  void login() {
    notifyListeners();
  }
}
