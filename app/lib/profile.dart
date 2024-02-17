import 'package:app/townHall.dart';
import 'package:app/userModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/confessions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Uday Sharma'),
      ),
      body: ProfileBody(),
    );
  }
}

class ProfileBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: EdgeInsets.all(10),
        child: UpperProfileBody(),
      ),
      Expanded(child: LowerProfileBody()),
    ]);
  }
}

class UpperProfileBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage('images/anonymous.jpeg'),
          radius: 40,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Icon(
                    Icons.school_outlined,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'B.Sc. (Hons.) Computer Science',
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Icon(
                    Icons.email_outlined,
                    // size: 30,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'uday.224026@sggscc.ac.in',
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}

class LowerProfileBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: 'Town Hall'),
                Tab(text: 'Confessions'),
              ],
            ),
            Expanded(
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Consumer<UserModel>(
                    builder: ((context, user, child) => TabBarView(
                          children: [
                            TownHallPosts(
                              userID: user.userID,
                            ),
                            // Content for the 'Confessions' tab
                            ProfileConfessionPosts(userID: user.userID),

                            // Content for the 'Town Hall' tab
                          ],
                        )),
                  )),
            )
          ],
        ));
  }
}

class ProfileConfessionPosts extends StatefulWidget {
  int userID;

  ProfileConfessionPosts({Key? key, required this.userID}) : super(key: key);

  @override
  State<ProfileConfessionPosts> createState() =>
      _ProfileConfessionPostsState(userID: userID);
}

class _ProfileConfessionPostsState extends State<ProfileConfessionPosts> {
  List<dynamic> confessions = [];
  int userID;

  _ProfileConfessionPostsState({Key? key, required this.userID});

  void fetch_data(String url) async {
    http.Response res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      List<dynamic> data = json.decode(res.body)["data"];
      setState(() {
        confessions = data;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Call the fetch method when the widget is inserted into the tree.
    fetch_data("http://10.0.2.2:5000/confessions/$userID");
  }

  @override
  Widget build(BuildContext context) {
    if (confessions.isEmpty) {
      return Center(child: Text('No Confessions yet'));
    }
    return ListView.separated(
      itemCount: confessions.length,
      itemBuilder: (BuildContext context, int index) {
        return Confession(
            body: confessions[index]["body"], time: confessions[index]["time"]);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
