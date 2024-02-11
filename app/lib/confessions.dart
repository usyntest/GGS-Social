import 'package:app/userModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

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
  String develURL = 'http://10.0.2.2:5000/';
  String deployURL = '';

  TextEditingController confessionController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    confessionController.dispose();
    super.dispose();
  }

  Future<http.Response> fetchConfessions() {
    String url = develURL + "/confessions";
    return http
        .get(Uri.parse(url), headers: {'email': "uday.224026@sggscc.ac.in"});
  }

  Future<http.Response> postConfession(
      String email, String password, int userID) {
    Map data = {
      "email": email,
      "password": password,
      "userID": userID,
      "body": confessionController.text
    };
    String url = develURL + "/confession";
    return http.post(Uri.parse(url),
        headers: {'content-type': "application/json"}, body: jsonEncode(data));
  }

  void post(String email, String password, int userID) async {
    http.Response res = await postConfession(email, password, userID);

    if (res.statusCode == 200) {
      setState(() {
        confessions.insert(
            0,
            ConfessionPost(
                userID: userID,
                body: confessionController.text,
                time: DateTime.now().toString()));
      });
    }
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
      return Consumer<UserModel>(
          builder: ((context, user, child) => Scaffold(
              appBar: AppBar(
                title: Text(
                  'Confessions',
                ),
                centerTitle: true,
              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add_comment),
                onPressed: () {
                  // adding some properties
                  showModalBottomSheet(
                    context: context,
                    //elevates modal bottom screen
                    elevation: 10,

                    // gives rounded corner to modal bottom screen
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    builder: (BuildContext context) {
                      // UDE : SizedBox instead of Container for whitespaces
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                            left: 20,
                            right: 20),
                        child: SizedBox(
                          height: 200,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Write your confession here!',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextField(
                                  controller: confessionController,
                                  keyboardType: TextInputType.multiline,
                                  minLines: 1,
                                  maxLines: 5,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        post(user.email, user.password,
                                            user.userID);
                                        Navigator.pop(context);
                                      },
                                      child: Text('Post Confession')),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              body: ListView.separated(
                itemCount: confessions.length,
                itemBuilder: (BuildContext context, int index) {
                  return Confession(
                      body: confessions[index].body,
                      time: confessions[index].time);
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ))));
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
