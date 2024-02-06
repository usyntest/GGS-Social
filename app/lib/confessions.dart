import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ConfessionPost {
  final int userID;
  final String body;
  final String time;

  ConfessionPost(
      {required this.userID, required this.body, required this.time});
}

class Confessions extends StatefulWidget {
  @override
  State<Confessions> createState() => ConfessionsState();
}

class ConfessionsState extends State<Confessions> {
  bool empty = true;
  List<ConfessionPost> confessions = [];
  String develURL = 'http://10.0.2.2:5000/confessions';
  String deployURL = '';

  Future<http.Response> fetchConfessions() {
    return http.get(Uri.parse(develURL),
        headers: {'email': "uday.224026@sggscc.ac.in"});
  }

  void fetch() async {
    http.Response res = await fetchConfessions();
    // Handle the response, update the confessions list or perform other actions.
    if (res.statusCode == 200) {
      List<dynamic> data = json.decode(res.body)["confessions"];

      setState(() {
        empty = false;
        for (int i = 0; i < data.length; i++) {
          confessions.add(ConfessionPost(
              userID: data[i][1], body: data[i][2], time: data[i][3]));
        }
      });
    } else {
      print("Error");
    }
  }

  @override
  void initState() {
    super.initState();
    // Call the fetch method when the widget is inserted into the tree.
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    if (empty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Confessions'),
        ),
        body: Text('Confessions Page'),
      );
    } else {
      return Scaffold(
          appBar: AppBar(
            title: Text(
              'Confessions',
            ),
            centerTitle: true,
          ),
          body: ListView.separated(
            itemCount: confessions.length,
            itemBuilder: (BuildContext context, int index) {
              return Confession(
                  body: confessions[index].body, time: confessions[index].time);
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ));
    }
  }
}

class Confession extends StatelessWidget {
  String body;
  String time;

  Confession({super.key, required this.body, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('images/anonymous.jpeg'),
              radius: 15,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Anonymous',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            body,
            textAlign: TextAlign.left,
          ),
        )
      ]),
    );
  }
}
