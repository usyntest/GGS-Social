import 'package:flutter/material.dart';

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
          padding: EdgeInsets.only(top: 10, bottom: 15),
          child: Text(
            body,
            textAlign: TextAlign.left,
          ),
        ),
        if (imageURL.isNotEmpty)
          Container(
              // margin: EdgeInsets.symmetric(vertical: 5),
              child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              imageURL,
            ),
          )),
        Container(
          margin: EdgeInsets.only(top: 10),
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
