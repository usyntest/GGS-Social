import 'package:flutter/material.dart';
import 'package:ggs_social/src/user_provider.dart';
import 'package:provider/provider.dart';

class Confessions extends StatelessWidget {
  const Confessions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confessions'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: const ConfessionsList(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: () {},
      ),
    );
  }
}

class ConfessionsList extends StatelessWidget {
  const ConfessionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
        builder: (context, value, child) => ListView(
              children: <Widget>[
                Text(value.name),
                Text(value.email),
                Text(value.isLoggedIn.toString()),
                Text(value.apiKey),
                ConfessionPost(),
                ConfessionPost(),
                ConfessionPost(),
                ConfessionPost(),
                ConfessionPost(),
                ConfessionPost(),
                ConfessionPost(),
                ConfessionPost(),
                ConfessionPost(),
                ConfessionPost(),
                ConfessionPost(),
                ConfessionPost(),
                ConfessionPost(),
              ],
            ));
  }
}

class ConfessionPost extends StatelessWidget {
  const ConfessionPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ConfessionPostAvatar(), ConfessionPostBody()],
        ));
  }
}

class ConfessionPostAvatar extends StatelessWidget {
  const ConfessionPostAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const CircleAvatar(
        backgroundImage: AssetImage('assets/anonymous-profile.jpg'),
      ),
    );
  }
}

class ConfessionPostBody extends StatelessWidget {
  const ConfessionPostBody({super.key});

  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width * 0.8;

    return Container(
      width: cWidth,
      padding: const EdgeInsets.only(left: 10),
      child:
          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Anonymous',
          style: TextStyle(
              color: Colors.pink, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          'Hello, World I\'m Uday. This is dummy text. Hello how are you',
          style: TextStyle(fontSize: 16),
        ),
      ]),
    );
  }
}
