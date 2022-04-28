import 'package:chat_app/model/message.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Chat App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Expanded(
              child: MessageList(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}

class NewMessage extends StatelessWidget {
  const NewMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          const SizedBox(
            width: 30,
            child: Icon(
              Icons.attach_file,
              size: 25,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                label: const Text('Send message'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          const SizedBox(
            width: 30,
            child: Icon(
              Icons.person_outline,
              size: 25,
            ),
          )
        ],
      ),
    );
  }
}

class MessageList extends StatelessWidget {
  const MessageList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messageList.length,
      itemBuilder: ((context, index) {
        Widget child;
        print('---');
        print(messageList[index].attachment);
        print(messageList[index].body);
        print(messageList[index].dateSend);
        print('---');

        if (messageList[index].attachment == null) {
          // text message
          child = Text(messageList[index].body);
        } else if (messageList[index].attachment == 'document') {
          // document message
          child = Row(
            children: const [
              Icon(Icons.file_copy),
              SizedBox(
                width: 10,
              ),
              Text('This is a document'),
            ],
          );
        } else if (messageList[index].attachment == 'image') {
          // image message
          if (messageList[index].group == false) {
            bool group = false;
            int groupLength = 0;
            int groupMore = 0;
            if ((index + 4) < messageList.length &&
                messageList[index].group == false) {
              for (var i = index; i < (index + 4); i++) {
                if (messageList[i].dateSend.day ==
                        messageList[i].dateSend.day &&
                    messageList[i].dateSend.month ==
                        messageList[i].dateSend.month &&
                    messageList[i].attachment == messageList[i].attachment) {
                  group = true;
                  groupLength++;
                }
              }
            }

            child = Container(
              height: 100,
              width: 100,
              color: Colors.grey,
            );

            if (group == true && groupLength == 4) {
              for (var i = index + 4; i < messageList.length; i++) {
                if (messageList[i].dateSend.day ==
                        messageList[index].dateSend.day &&
                    messageList[i].dateSend.month ==
                        messageList[index].dateSend.month &&
                    messageList[i].attachment == 'image') {
                  groupMore++;
                } else {
                  break;
                }
              }

              for (var i = index + 1; i < (index + 4 + groupMore); i++) {
                messageList[i].group = true;
              }
              child = SizedBox(
                height: 200,
                width: 200,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    if (index == 3 && groupMore > 0) {
                      return Container(
                        color: Colors.grey,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('+$groupMore more..'),
                          ),
                        ),
                      );
                    }
                    return Container(
                      color: Colors.grey,
                    );
                  },
                ),
              );
            }
          } else {
            child = Container(
              height: 100,
              width: 100,
              color: Colors.grey,
            );
          }
        } else {
          // contact message
          if (messageList[index].group == false) {
            bool group = false;
            int groupLength = 0;
            int groupMore = 0;
            if ((index + 2) < messageList.length &&
                messageList[index].group == false) {
              for (var i = index; i < (index + 2); i++) {
                if (messageList[i].dateSend.day ==
                        messageList[i].dateSend.day &&
                    messageList[i].dateSend.month ==
                        messageList[i].dateSend.month &&
                    messageList[i].attachment == messageList[i].attachment) {
                  group = true;
                  groupLength++;
                }
              }
            }

            child = Row(
              children: const [
                Icon(Icons.people_outline),
                SizedBox(
                  width: 10,
                ),
                Text('This is a person'),
              ],
            );

            if (group == true && groupLength == 2) {
              for (var i = index + 2; i < messageList.length; i++) {
                if (messageList[i].dateSend.day ==
                        messageList[index].dateSend.day &&
                    messageList[i].dateSend.month ==
                        messageList[index].dateSend.month &&
                    messageList[i].attachment == 'contact') {
                  groupMore++;
                } else {
                  break;
                }
              }

              for (var i = index + 1; i < (index + 2 + groupMore); i++) {
                messageList[i].group = true;
              }
              child = Row(
                children: const [
                  Icon(Icons.people_alt_outlined),
                  SizedBox(
                    width: 10,
                  ),
                  Text('More than one person'),
                ],
              );
            }
          } else {
            child = Row(
              children: const [
                Icon(Icons.people_outline),
                SizedBox(
                  width: 10,
                ),
                Text('This is a person'),
              ],
            );
          }
        }

        if (messageList[index].group == true) {
          return const SizedBox();
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const CircleAvatar(),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: child,
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
