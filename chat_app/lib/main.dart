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
        child: ListView.builder(
          itemCount: messageList.length,
          itemBuilder: ((context, index) {
            Widget child;
            print('---');
            print(messageList[index].attachment);
            print(messageList[index].body);
            print(messageList[index].dateSend);
            print('---');

            if (messageList[index].attachment == null) {
              child = Text(messageList[index].body);
            } else if (messageList[index].attachment == 'document') {
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
              bool group = false;
              int groupLength = 0;
              if ((index + 4) < messageList.length &&
                  messageList[index].group == false) {
                for (var i = index; i < (index + 4); i++) {
                  if (messageList[i].dateSend.day ==
                          messageList[i].dateSend.day &&
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
                for (var i = index + 1; i < (index + 4); i++) {
                  messageList[i].group = true;
                }
                child = SizedBox(
                  height: 200,
                  width: 200,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.grey,
                      );
                    },
                  ),
                );
              }
            } else {
              bool group = false;
              int groupLength = 0;
              if ((index + 2) < messageList.length &&
                  messageList[index].group == false) {
                for (var i = index; i < (index + 2); i++) {
                  if (messageList[i].dateSend.day ==
                          messageList[i].dateSend.day &&
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
                for (var i = index + 1; i < (index + 2); i++) {
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
        ),
      ),
    );
  }
}
