import 'dart:convert';

import 'package:bubble/bubble.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:groupingchallange/models/message_dataset.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key, required this.user}) : super(key: key);
  String user;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

enum TsConvertTo { DATE, HOUR }

class _ChatScreenState extends State<ChatScreen> {
  Future<MessagesDataset> parseJsonFromAssets(String assetsPath) async {
    return rootBundle
        .loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr))
        .then((json) => MessagesDataset.fromJson(json));
  }

  Color titleText = Color(0xff749aff);
  Color subtitleText = Color(0xff435ea5);
  final kSendButtonTextStyle = TextStyle(
    color: Color(0xff749aff),
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
  );

  final kMessageContainerDecoration = BoxDecoration(
    border: Border(
      top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    ),
  );

  final kMessageTextFieldDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    hintText: 'Type your message here...',
    border: InputBorder.none,
  );
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      endDrawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Container(
                        child: Text('Filter'),
                      ),
                      Divider(),
                      // CheckboxListTile(
                      //   contentPadding: EdgeInsets.all(0),
                      //   dense: true,
                      //   controlAffinity: ListTileControlAffinity.leading,
                      //   value: localToday,
                      //   onChanged: (val) {
                      //     localToday = val;
                      //     setState(() {});
                      //   },
                      //   title: Text("Today"),
                      // ),
                      // CheckboxListTile(
                      //   controlAffinity: ListTileControlAffinity.leading,
                      //   value: localTommorrow,
                      //   onChanged: (val) {
                      //     localTommorrow = val;
                      //     setState(() {});
                      //   },
                      //   title: Text("Tomorrow"),
                      //   contentPadding: EdgeInsets.all(0),
                      //   dense: true,
                      // ),
                      // CheckboxListTile(
                      //   contentPadding: EdgeInsets.all(0),
                      //   dense: true,
                      //   controlAffinity: ListTileControlAffinity.leading,
                      //   value: localYesterday,
                      //   onChanged: (val) {
                      //     localYesterday = val;
                      //     setState(() {});
                      //   },
                      //   title: Text("Yesterday"),
                      // ),
                      SizedBox(height: 20),
                      Text('Options'),
                      Divider(),
                      // CheckboxListTile(
                      //   contentPadding: EdgeInsets.all(0),
                      //   dense: true,
                      //   controlAffinity: ListTileControlAffinity.leading,
                      //   value: localOffline,
                      //   onChanged: (val) {
                      //     localOffline = val;
                      //     setState(() {});
                      //   },
                      //   title: Text("Offline Mode"),
                      // ),
                      // Spacer(),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(primary: subtitleText),
                    onPressed: () async {
                      Get.back();
                    },
                    child: Text(
                      "Reset Filter",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: subtitleText,
                    ),
                    onPressed: () async {
                      Get.back();
                    },
                    child: Text(
                      "Apply Filter",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.sort),
              onPressed: () {
                // initLocalFilter();
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 10),
                IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Get.back();
                    }),
                Container(
                    // key: ValueKey(new Random().nextInt(100)),
                    // padding: EdgeInsets.all(w * 0.05),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Icon(
                      Icons.person,
                      color: Colors.grey,
                      size: 30,
                    )),
                SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      print("tap");
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(
                            "USER: " + widget.user == "A" ? "B" : "A",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              // color: Colors.black87,
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: parseJsonFromAssets("assets/message_dataset.json"),
              builder: (context, snapshot) {
                String? timeStamp = "";
                if (ConnectionState.done == snapshot.connectionState) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Terjadi Error"),
                    );
                  }

                  if (snapshot.hasData) {
                    final data = (snapshot.data as MessagesDataset).data;
                    data.sort((a, b) => a.timestamp.compareTo(b.timestamp));

                    convertTsToDate(String tsString, TsConvertTo convertTo) {
                      final ts = int.parse(tsString);
                      final datetime = DateTime.fromMillisecondsSinceEpoch(
                        ts * 1000,
                      );
                      if (convertTo == TsConvertTo.DATE) {
                        return DateFormat.yMMMd().format(datetime);
                      } else {
                        return DateFormat.Hm().format(datetime);
                      }
                    }

                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final date = convertTsToDate(
                            data[index].timestamp, TsConvertTo.DATE);
                        final timeString = convertTsToDate(
                            data[index].timestamp, TsConvertTo.HOUR);
                        final dateYesterday = index == 0
                            ? ""
                            : convertTsToDate(
                                data[index - 1].timestamp, TsConvertTo.DATE);
                        bool showDate = date != dateYesterday;

                        return Column(
                          children: [
                            if (showDate)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Bubble(
                                  alignment: Alignment.center,
                                  color: Color.fromRGBO(212, 234, 244, 1.0),
                                  child: Text(date,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 11.0)),
                                ),
                              ),
                            GestureDetector(
                              onTap: () {
                                Get.dialog(Dialog(
                                  child: Text(data[index].toJson().toString()),
                                ));
                              },
                              child: Bubble(
                                margin: BubbleEdges.only(top: 10),
                                alignment: widget.user != data[index].from
                                    ? Alignment.topLeft
                                    : Alignment.topRight,
                                nip: widget.user != data[index].from
                                    ? BubbleNip.leftTop
                                    : BubbleNip.rightTop,
                                color: widget.user != data[index].from
                                    ? null
                                    : Color.fromRGBO(225, 255, 199, 1.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    buildMessageType(data[index]),
                                    SizedBox(height: 10),
                                    Text(
                                      timeString,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Container();
              },
            ),
          ),
          Container(
            decoration: kMessageContainerDecoration,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    // controller: messageTextController,
                    // onChanged: (value) {
                    //   messageText = value;
                    // },
                    decoration: kMessageTextFieldDecoration,
                  ),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text(
                    'Send',
                    style: kSendButtonTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMessageType(Message msg) {
    if (msg.attachment == "image" || msg.attachment == "document") {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            msg.attachment == "image"
                ? "https://picsum.photos/200/300?random=${msg.timestamp}"
                : "https://www.iconpacks.net/icons/2/free-attachment-icon-1483-thumb.png",
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),
          if (msg.body != null) Text(msg.body!)
        ],
      );
    } else if (msg.attachment == "contact") {
      var faker = new Faker();
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    "https://i.pravatar.cc/300?u=${msg.timestamp}",
                    width: 50,
                    height: 50,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(flex: 4, child: Text(faker.person.name())),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Send Message"),
                if (widget.user != msg.from) Text("Save Contact"),
              ],
            ),
          ],
        ),
      );
    }
    return Text(msg.body ?? "", textAlign: TextAlign.right);
  }
}
