import 'package:app/userModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(
        builder: ((context, user, child) => Scaffold(
              appBar: AppBar(title: Text('Profile')),
              body: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('images/anonymous.jpeg'),
                      radius: 50,
                    ),
                  ),
                  Container(
                    padding: EdgeInsetsDirectional.symmetric(vertical: 5),
                    child: Text(
                      user.name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.school_outlined),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        user.course,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.email_outlined),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        user.email,
                      ),
                    ],
                  )
                ],
              ),
            )));
  }
}
