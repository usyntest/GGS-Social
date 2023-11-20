import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/src/user_provider.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Center(child: ProfileView()),
    );
  }
}

class ProfileView extends StatelessWidget {
  TextStyle keyStyle =
      TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 18);

  TextStyle valueStyle = TextStyle(color: Colors.pink, fontSize: 20);

  @override
  Widget build(BuildContext build) {
    return Consumer<UserProvider>(
        builder: ((context, value, child) => Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/anonymous-profile.jpg'),
                  radius: 60,
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'NAME',
                  style: keyStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  value.name,
                  style: valueStyle,
                ),
                SizedBox(
                  height: 20,
                ),
                Text('COURSE', style: keyStyle),
                SizedBox(
                  height: 10,
                ),
                Text(value.courses[value.course] ?? '', style: valueStyle),
                SizedBox(
                  height: 20,
                ),
                Text('EMAIL', style: keyStyle),
                SizedBox(
                  height: 10,
                ),
                Text(value.email, style: valueStyle)
              ],
            )));
  }
}
