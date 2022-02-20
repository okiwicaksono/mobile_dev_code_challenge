import 'dart:convert';

import 'package:brew_chat/feature/chat/data/models/chat_model.dart';
import 'package:brew_chat/feature/chat/data/models/response_data.dart';
import 'package:brew_chat/feature/chat/presentation/bloc/chat_bloc.dart';
import 'package:brew_chat/feature/chat/presentation/pages/bubble_chat/bubble_chat_contact.dart';
import 'package:brew_chat/feature/chat/presentation/pages/bubble_chat/bubble_chat_document.dart';
import 'package:brew_chat/feature/chat/presentation/pages/bubble_chat/bubble_chat_image.dart';
import 'package:brew_chat/feature/chat/presentation/pages/bubble_chat/bubble_chat_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      BlocProvider.of<ChatBloc>(context).add(GetListChat());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.person),
            SizedBox(
              width: 5,
            ),
            Text("B"),
          ],
        ),
      ),
      body: Stack(
        children: [
          buildBubbleChat(),
          Positioned(
            bottom: 0.0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              color: Colors.white,
              height: AppBar().preferredSize.height,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:[
                  const Icon(Icons.attachment),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    margin:const  EdgeInsets.symmetric(horizontal: 8),
                    width: MediaQuery.of(context).size.width / 1.35,
                      child: const TextField(
                        readOnly: true,
                        enabled: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      )),
                  const Icon(Icons.send)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildBubbleChat() {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state is Loaded) {
          print(json.encode(state.listChat));
          return ListView.builder(
              itemCount: state.listChat.length,
              padding: EdgeInsets.only(bottom: AppBar().preferredSize.height + 5),
              itemBuilder: (BuildContext context, int index) {
                return checkTypeChat(state.listChat[index]);
              });
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget checkTypeChat(ChatModel data) {
    print(json.encode(data));
    if (data.attachment == null) {
      return BubbleChatText(responseData: data.data ?? ResponseData());
    } else if (data.attachment == "image") {
      return checkImageIsGroup(data);
    } else if (data.attachment == "contact") {
      return checkContactGroup(data);
    } else if (data.attachment == "document") {
      return BubbleChatDocument(responseData: data.data ?? ResponseData());
    } else {
      return const SizedBox();
    }
  }

  checkImageIsGroup(ChatModel chatModel) {
    if (chatModel.listData != null) {
      return BubbleChatImage(
          responseData: null, listData: chatModel.listData, isGroup: true);
    } else {
      return BubbleChatImage(
          responseData: chatModel.data, listData: null, isGroup: false);
    }
  }

  checkContactGroup(ChatModel chatModel) {
    if (chatModel.listData != null) {
      return BubbleChatContact(
          responseData: null, listData: chatModel.listData, isGroup: true);
    } else {
      return BubbleChatContact(
          responseData: chatModel.data, listData: null, isGroup: false);
    }
  }
}
