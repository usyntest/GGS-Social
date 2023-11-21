import 'package:flutter/material.dart';
import 'package:app/src/user_provider.dart';
import 'package:app/src/confessions_provider.dart';
import 'package:provider/provider.dart';

class Confessions extends StatelessWidget {
  Confessions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
        builder: ((context, value, child) => Scaffold(
              appBar: AppBar(
                title: const Text('Confessions'),
                centerTitle: true,
                elevation: 0.0,
              ),
              body: ChangeNotifierProvider(
                create: ((context) => ConfessionsProvider(value.apiKey)),
                child: ConfessionsList(),
              ),
              floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.edit),
                onPressed: () {},
              ),
            )));
  }
}

class ConfessionsList extends StatelessWidget {
  const ConfessionsList({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ConfessionsProvider>(
      builder: (context, value, child) {
        List<Confession> confessions =
            value.getConfessions(); // Add a method to get confessions
        if (value.apiErrorMsg == "") {
          return ListView.builder(
            itemCount: confessions.length,
            itemBuilder: (context, index) {
              return ConfessionPost(body: confessions[index].body);
            },
          );
        } else if (value.getConfessions().isEmpty) {
          return Center(
            child: Text(
              'No confessions as of now',
              style: TextStyle(fontSize: 24, color: Colors.grey),
            ),
          );
        } else {
          return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Text(
                  'Error',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber),
                  textAlign: TextAlign.center,
                ),
                Text(
                  value.apiErrorMsg,
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                  textAlign: TextAlign.center,
                )
              ]));
        }
      },
    );
  }
}

class ConfessionPost extends StatelessWidget {
  final String body; // Use final instead of _
  ConfessionPost({Key? key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [ConfessionPostAvatar(), ConfessionPostBody(body: body)],
      ),
    );
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
  final String body;
  ConfessionPostBody({Key? key, required this.body});

  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width * 0.8;

    return Container(
      width: cWidth,
      padding: const EdgeInsets.only(left: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Anonymous',
          style: TextStyle(
              color: Colors.pink, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          body,
          style: TextStyle(fontSize: 16),
        ),
      ]),
    );
  }
}
