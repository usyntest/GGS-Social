import 'package:app/townHall.dart';
import 'package:app/userModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/confessions.dart';

List confessions = [
  {
    "body":
        "lorem ipsum, dolor sit met consectetur adipiscing elit. Amet totam ipsam iusto quod omnis nulla, maiores voluptate molestias cumque similique?",
    "time": "12-01-2024 3:58:12"
  },
  {
    "body":
        "lorem ipsum, dolor sit met consectetur adipiscing elit. Amet totam ipsam iusto quod omnis nulla, maiores voluptate molestias cumque similique?",
    "time": "12-01-2024 3:58:12"
  },
  {
    "body":
        "lorem ipsum, dolor sit met consectetur adipiscing elit. Amet totam ipsam iusto quod omnis nulla, maiores voluptate molestias cumque similique?",
    "time": "12-01-2024 3:58:12"
  },
  {
    "body":
        "lorem ipsum, dolor sit met consectetur adipiscing elit. Amet totam ipsam iusto quod omnis nulla, maiores voluptate molestias cumque similique?",
    "time": "12-01-2024 3:58:12"
  },
];

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
            child: TabBarView(
              children: [
                // Content for the 'Town Hall' tab
                ProfileTownHallPosts(),
                // Content for the 'Confessions' tab
                ProfileConfessionPosts(),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class ProfileTownHallPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
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
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}

class ProfileConfessionPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
