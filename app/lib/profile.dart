import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Profile')),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: CircleAvatar(
                  backgroundImage: AssetImage('images/anonymous.jpeg'),
                  radius: 50,
                ),
              ),
              Container(
                padding: EdgeInsetsDirectional.symmetric(vertical: 5),
                child: Text(
                  'Uday Sharma',
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
              ),
              Text(
                'uday.224026@sggscc.ac.in',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'B.Sc. (Hons.) Computer Science',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ));
  }
}
