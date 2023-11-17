import 'package:flutter/material.dart';
import 'package:ggs_social/src/login.dart';
import 'package:ggs_social/src/register.dart';

class Authentication extends StatelessWidget {
  const Authentication({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/logo.png'),
            radius: 75,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Welcome to GGS Social',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'GGS\'s very own Social Media Platform',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          AuthenticationButtonGroup()
        ],
      ),
    );
  }
}

class AuthenticationButtonGroup extends StatelessWidget {
  const AuthenticationButtonGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 140, // <-- Your width
          height: 50,
          child: FilledButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const Login()));
            },
            child: const Text(
              'Login',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        SizedBox(
          width: 140, // <-- Your width
          height: 50,
          child: FilledButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const Register()));
            },
            child: const Text(
              'Register',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
