import 'package:flutter/material.dart';
import 'package:app/home.dart';
import 'package:app/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AuthenticationWrapper(),
    );
  }
}

class AuthenticationWrapper extends StatefulWidget {
  @override
  State<AuthenticationWrapper> createState() => AuthenticationWrapperState();
}

class AuthenticationWrapperState extends State<AuthenticationWrapper> {
  bool _isAuthenticated = false;

  @override
  Widget build(BuildContext context) {
    if (_isAuthenticated) {
      return Home();
    } else {
      return Login();
    }
  }
}
