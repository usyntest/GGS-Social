import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:app/userModel.dart';

class TownHall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(
        builder: ((context, user, chiild) => Scaffold(
            appBar: AppBar(
              title: Text('Town Hall'),
            ),
            body: TownHallPosts(
              userID: user.userID,
            ))));
  }
}

class TownHallPosts extends StatefulWidget {
  int userID;

  TownHallPosts({Key? key, required this.userID}) : super(key: key);

  @override
  State<TownHallPosts> createState() => _TownHallPostsState(userID: userID);
}

class _TownHallPostsState extends State<TownHallPosts> {
  List<dynamic> townHallPosts = [];
  int userID;

  _TownHallPostsState({Key? key, required this.userID});

  void fetch_data(String url) async {
    http.Response res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      List<dynamic> data = json.decode(res.body)["data"];
      setState(() {
        townHallPosts = data;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Call the fetch method when the widget is inserted into the tree.
    fetch_data("http://10.0.2.2:5000/posts/$userID");
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: townHallPosts.length,
      itemBuilder: (BuildContext context, int index) {
        return TownHallPost(
          body: townHallPosts[index]["body"],
          time: townHallPosts[index]["createdAt"],
          likes: townHallPosts[index]["likes"],
          imageURL: (townHallPosts[index]["imageURL"] ?? ""),
          name: (townHallPosts[index]["name"]),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}

class TownHallPost extends StatelessWidget {
  String body;
  String time;
  String name;
  int likes;
  String imageURL;

  TownHallPost(
      {super.key,
      required this.body,
      required this.time,
      required this.name,
      required this.likes,
      this.imageURL = ""});

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
              name,
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
        ),
        if (imageURL.isNotEmpty)
          Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  imageURL,
                ),
              )),
        Container(
          margin: EdgeInsets.only(top: 5),
          child: Row(
            children: [
              Icon(
                Icons.favorite_border,
                // size: 25,
              ),
              SizedBox(width: 5),
              Text(
                likes.toString(),
                style: TextStyle(fontSize: 16),
              )
            ],
          ),
        )
      ]),
    );
  }
}
