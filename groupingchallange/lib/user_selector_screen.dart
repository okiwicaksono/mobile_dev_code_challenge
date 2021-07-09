import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groupingchallange/chat_screen.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Sender"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(),
          ElevatedButton(
            onPressed: () {
              print("go A");
              Get.to(() => ChatScreen(
                    user: "A",
                  ));
            },
            child: Text("A"),
          ),
          ElevatedButton(
            onPressed: () {
              Get.to(() => ChatScreen(
                    user: "B",
                  ));
            },
            child: Text("B"),
          ),
        ],
      ),
    );
  }
}
