import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messaging_app/helpers/colors.dart';
import 'package:messaging_app/helpers/constanta.dart';
import 'package:messaging_app/helpers/time_converter.dart';
import 'package:messaging_app/models/chats/message_model.dart';
import 'package:messaging_app/views/chat/cubits/cubit/get_messages_cubit.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  drawerItem(String title, {Function()? onTapped}) {
    return GestureDetector(
      onTap: onTapped,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: space3),
        child: Text(
          title,
          style: const TextStyle(color: colorWhite),
        ),
      ),
    );
  }

  chatList() {}

  chatInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: space2, horizontal: space4),
      child: Row(
        children: const [
          Icon(Icons.attachment),
          SizedBox(
            width: space4,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: space2),
                hintText: 'Add a message',
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colorBlack),
                ),
              ),
            ),
          ),
          SizedBox(
            width: space4,
          ),
          Icon(Icons.send)
        ],
      ),
    );
  }

  Widget profileImage(){
    return Container(
      padding: const EdgeInsets.all(space1),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(),
        color: colorWhite
      ),
      child:const  Icon(Icons.person),
    );
  }

  Widget leftWidget(Size size, List<MessageModel> messages){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        profileImage(),
        const SizedBox(width: space2,),
        Flexible(
          child: contentBuilder(size, messages, false)
        ),
        const Spacer()
      ],
    );
  }

  Widget rightWidget(Size size, List<MessageModel> messages){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        contentBuilder(size, messages, true),
        const SizedBox(width: space2,),
        profileImage(),
      ],
    );
  }

  Widget contentContact(List<MessageModel> messages){
    return Row(
      children: [
        messages.length>1? Stack(
          children: [
            const SizedBox(width: 50,),
            profileImage(),
            Positioned(
              left: space4,
              child: profileImage())
          ],
        ) : profileImage(),
        const SizedBox(width: space2,),
        Expanded(child: Text(messages.length>2? '${messages.length-2} more contacts' : messages[0].body??'This is a person'))
      ],
    );
  }

   Widget contentDocument(MessageModel messages){
    return Row(
      children: [
        const Icon(Icons.file_present_outlined),
        const SizedBox(width: space2,),
        Expanded(child: Text(messages.body??'This is a document'))
      ],
    );
  }

  Widget imageWidget(Size size, {bool small = false}){
    return Container(
      width: small ? size.width/6 : size.width/3,
      height: small? size.width/8 : size.width/4,
      decoration: BoxDecoration(
        color: colorWhite,
        // borderRadius: BorderRadius.circular(space2)
        border: Border.all(color: Colors.grey)
      ),
      child: const Icon(Icons.image, size: 40,),
    );
  }

  Widget contentImage(Size size, List<MessageModel> messages){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        messages.length>1? Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                imageWidget(size, small: true),
                imageWidget(size, small: true),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                imageWidget(size, small: true),
                imageWidget(size, small: true),
              ],
            )
          ],
        ) : imageWidget(size),
        const SizedBox(height: space1,),
        messages.length<=4? Text(messages[0].body??'') : Text('${messages.length-4} more images', style: const TextStyle(color: Colors.grey),)
      ],
    );
  }

  Widget contentBuilder(Size size, List<MessageModel> messages, bool isRight){
    return Container(
      padding: const EdgeInsets.all(space2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(space2),
        color: isRight? primaryColor.withOpacity(.3) : Colors.yellow.withOpacity(.3)
      ),
      child: messages[0].attachment=='contact'? 
        contentContact(messages) 
        : messages[0].attachment=='document'? 
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: messages.length,
            primary: false,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return contentDocument(messages[index]) ;
            },
          )
          : messages[0].attachment=='image'? 
            contentImage(size, messages) 
            : Text(messages[0].body??'')
    );
  }

  Widget messageBuilder(Size size, List<MessageModel> messages){
    //Assume B is my account, A is other person
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: space2, horizontal: space4),
      child: messages[0].from=='B'? rightWidget(size, messages) : leftWidget(size, messages)
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => GetMessagesCubit()..request(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Other Person'),
          actions: [
            PopupMenuButton(
              itemBuilder: ((context) => [
                PopupMenuItem(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Edit Profile'),
                  ),
                ),
                PopupMenuItem(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Settings'),
                  ),
                ),
              ]),
            )
          ],
        ),
        drawer: Drawer(
          backgroundColor: primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(space4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: space6),
                drawerItem('App Version 1.0.0'),
                drawerItem(logout, onTapped: () {}),
              ],
            ),
          ),
        ),
        body: BlocBuilder<GetMessagesCubit, GetMessagesState>(
          builder: (context, state) {
            if(state is GetMessagesError){
              return Center(
                child: Text(state.message),
              ); 
            } else if(state is GetMessagesLoaded){
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.groupMessages.length,
                      itemBuilder: (BuildContext context, int index) {
                        final message = state.groupMessages[index];
                        return messageBuilder(size, message);
                      },
                    ),
                  ),
                  chatInput()
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
