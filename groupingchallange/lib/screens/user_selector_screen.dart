import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groupingchallange/screens/chat_screen.dart';
import 'package:groupingchallange/controllers/message_controller.dart';
import 'package:groupingchallange/widgets/sender_widget.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MessageController controller = Get.put(MessageController());
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
          SenderWidget(
            onTap: () {
              Get.to(() => ChatScreen(
                    user: "A",
                  ));
            },
            title: "A",
          ),
          SizedBox(height: 20),
          SenderWidget(
            onTap: () {
              Get.to(() => ChatScreen(
                    user: "B",
                  ));
            },
            title: "B",
          ),
        ],
      ),
    );
  }
}
