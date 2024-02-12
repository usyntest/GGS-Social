import 'package:flutter/material.dart';
import 'package:app/home.dart';
import 'package:app/login.dart';
import 'package:provider/provider.dart';
import 'package:app/userModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GGS Social',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider(
        create: (context) => UserModel(),
        child: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(builder: (context, user, child) {
      if (user.isLoggedIn) {
        return Home();
      }
      return Login();
    });
  }
}
