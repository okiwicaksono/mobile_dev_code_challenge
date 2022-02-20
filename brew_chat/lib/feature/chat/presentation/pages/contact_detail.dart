import 'package:brew_chat/feature/chat/data/models/response_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';


class ContactDetail extends StatelessWidget {
  final List<ResponseData> data;
  const ContactDetail({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Detail"),
      ),
      body: ListView.builder(
          itemCount: data.length ,
          padding: EdgeInsets.only(bottom: AppBar().preferredSize.height + 5),
          itemBuilder: (BuildContext context, int index) {
            return Bubble(
              margin: const BubbleEdges.only(top: 10),
              alignment: data.first.from == "A" ? Alignment.topRight : Alignment.topLeft,
              nipWidth: 8,
              nipHeight: 24,
              nip: data.first.from == "A" ? BubbleNip.rightTop : BubbleNip.leftTop,
              color: data.first.from == "A"
                  ? const Color.fromRGBO(225, 255, 199, 1.0)
                  : Colors.white54,
              child: Container(
                width: 150,
                height: 80,
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.person),
                        Text("Person Name")
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text("Message", style: TextStyle(color: Colors.blueAccent),),
                        Text("Save", style: TextStyle(color: Colors.blueAccent))
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
