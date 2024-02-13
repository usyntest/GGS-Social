import 'package:flutter/material.dart';

List townHallPosts = [
  {
    "body":
        "lorem ipsum, dolor sit met consectetur adipiscing elit. Amet totam ipsam iusto quod omnis nulla, maiores voluptate molestias cumque similique?",
    "time": "12-01-2024 3:58:12",
    "likes": 20,
    "imageURL":
        "https://images.pexels.com/photos/258447/pexels-photo-258447.jpeg"
  },
  {
    "body":
        "lorem ipsum, dolor sit met consectetur adipiscing elit. Amet totam ipsam iusto quod omnis nulla, maiores voluptate molestias cumque similique?",
    "time": "12-01-2024 3:58:12",
    "likes": 20,
    "imageURL":
        "https://images.pexels.com/photos/258447/pexels-photo-258447.jpeg"
  },
  {
    "body":
        "lorem ipsum, dolor sit met consectetur adipiscing elit. Amet totam ipsam iusto quod omnis nulla, maiores voluptate molestias cumque similique?",
    "time": "12-01-2024 3:58:12",
    "likes": 20,
  },
  {
    "body":
        "lorem ipsum, dolor sit met consectetur adipiscing elit. Amet totam ipsam iusto quod omnis nulla, maiores voluptate molestias cumque similique?",
    "time": "12-01-2024 3:58:12",
    "likes": 20,
    "imageURL":
        "https://images.pexels.com/photos/258447/pexels-photo-258447.jpeg"
  }
];

class TownHall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Town Hall'),
        ),
        body: ListView.separated(
          itemCount: townHallPosts.length,
          itemBuilder: (BuildContext context, int index) {
            return TownHallPost(
              body: townHallPosts[index]["body"],
              time: townHallPosts[index]["time"],
              likes: townHallPosts[index]["likes"],
              imageURL: (townHallPosts[index]["imageURL"] ?? ""),
              name: "Uday Sharma",
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ));
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
