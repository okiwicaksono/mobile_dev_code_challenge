import 'package:chatroom/components/contact_item.dart';
import 'package:chatroom/components/image_item.dart';
import 'package:chatroom/components/text_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/doc_item.dart';
import 'components/multi_image_item.dart';
import 'controllers/chat_controller.dart';
import 'models/display_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatroom',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(title: 'Chatroom'),
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
  final chatController = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Expanded(
              child: Container(
                  margin: const EdgeInsets.only(right: 8, left: 8),
                  child: GetX<ChatController>(builder: (controller) {
                    List<DisplayModel> list = controller.chatList;

                    return ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (c, i) {
                          DisplayModel item = list[i];

                          return item.type == "tanggal"
                              ? _buildTgl(item)
                              : item.type == "text"
                                  ? _buildText(item)
                                  : item.type == "image"
                                      ? _buildImg(item)
                                      : item.type == "contact"
                                          ? _buildContact(item)
                                          : _buildDoc(item);
                        });
                  }))),
          Container(
            height: 80,
            color: Colors.indigo.shade400,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.attach_file, size: 28)),
                Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(
                            right: 8, left: 8, top: 8, bottom: 8),
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              contentPadding:
                                  EdgeInsets.only(left: 16, right: 16),
                              filled: true,
                              hintStyle: TextStyle(color: Colors.grey[800]),
                              hintText: "Write a message..",
                              fillColor: Colors.white70),
                        ))),
                IconButton(onPressed: () {}, icon: Icon(Icons.send, size: 28)),
              ],
            ),
          )
        ]),
      ),
    );
  }

  _buildTgl(DisplayModel item) {
    return Center(
        child: Container(
            width: 120,
            height: 30,
            margin: EdgeInsets.only(top: 18),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.yellow.shade100,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Text(
              "${item.id}",
              style: TextStyle(fontWeight: FontWeight.bold),
            )));
  }

  _buildDoc(DisplayModel item) {
    return DocItem("${item.id}", "This is a document", item.showAvatar!,
        Icons.file_copy, item.from == "A", true);
  }

  _buildText(DisplayModel item) {
    return TextItem(item.id!, item.message, item.showAvatar!, item.from == "A");
  }

  _buildImg(DisplayModel item) {
    return item.imageList!.isEmpty
        ? _buildImgItem(item)
        : (item.imageList!.length > 3
            ? _buildImgGroup(item)
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: item.imageList!.map((e) {
                  return _buildImgItem(item);
                }).toList()));
  }

  Widget _buildImgItem(DisplayModel item) {
    return ImageItem("${item.id}", item.message, item.showAvatar!,
        Icons.photo_sharp, item.from == "A", true);
  }

  _buildImgGroup(DisplayModel item) {
    return MultiImageItem("${item.id}", item.message, item.showAvatar!,
        item.from == "A", item.imageList!.length);
  }

  _buildContact(DisplayModel item) {
    return ContactItem(
        "${item.id}",
        item.contactList!.isEmpty ? "This is a person" : "More than one person",
        item.showAvatar!,
        item.contactList!.isEmpty ? Icons.account_circle_outlined : Icons.group,
        item.from == "A",
        true);
  }
}
