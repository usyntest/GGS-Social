import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserModel extends ChangeNotifier {
  bool isLoggedIn = false;
  late String name;
  late String course;
  late String email;
  late String password;

  void login(String email, String password) async {
    bool validDetails = await getUser(email, password);
    if (!validDetails) {
      return;
    }
    this.name = 'Uday Sharma';
    this.course = 'B.Sc. (Hons.) Computer Science';
    this.email = email;
    this.password = password;
    isLoggedIn = true;
    notifyListeners();
  }

  Future<bool> getUser(String email, String password) async {
    String develURL = 'http://10.0.2.2:5000/login';
    String deployURL = '';

    Map data = {"email": email, "password": password};

    http.Response res = await http.post(Uri.parse(develURL),
        body: jsonEncode(data), headers: {'content-type': "application/json"});

    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }
}
