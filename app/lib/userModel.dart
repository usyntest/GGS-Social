import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserModel extends ChangeNotifier {
  bool isLoggedIn = false;
  late String name;
  late String course;
  late String email;
  late String password;
  late int userID;

  void login(String email, String password) async {
    bool validDetails = await getUser(email, password);
    if (!validDetails) {
      return;
    }
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
      Map<String, dynamic> body = json.decode(res.body);
      // this.name = body["name"];
      // this.email = body["email"];
      // this.course = body["course"];
      // this.password = body["password"];
      // this.userID = body["userID"];
      this.name = body["user"]?["name"];
      this.email = body["user"]?["email"];
      this.course = body["user"]?["course"];
      this.password = body["user"]?["password"];
      this.userID = body["user"]?["userID"];
      return true;
    }
    return false;
  }
}
