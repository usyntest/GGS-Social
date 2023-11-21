import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Confession {
  String _body;

  Confession(this._body);

  String get body => _body;
}

class ConfessionsProvider extends ChangeNotifier {
  List<Confession> _confessions = [];
  String _apiErrorMessage = '';
  String _apiKey;

  ConfessionsProvider(this._apiKey) {
    get_confessions();
  }

  String get apiErrorMsg => _apiErrorMessage;

  List<Confession> getConfessions() {
    return _confessions;
  }

  void get_confessions() async {
    String url = 'https://usyntest.pythonanywhere.com/confession/get/';
    // 'http://10.0.2.2:5000/confession/get/';

    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': _apiKey,
        },
      );
      if (response.statusCode == 200) {
        _confessions = (jsonDecode(response.body)['confessions'] as List)
            .map((confession) => Confession(confession['body']))
            .toList();
      } else {
        _apiErrorMessage = jsonDecode(response.body)['error'];
      }
    } catch (error) {
      _apiErrorMessage = 'Error while loading confessions: $error';
      print(error);
    }
    notifyListeners();
  }
}
