import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_dev_code_challenge/class/Message.dart';
import 'package:mobile_dev_code_challenge/component/BubbleChatTextComponent.dart';
import 'package:mobile_dev_code_challenge/component/ContactComponent.dart';
import 'package:mobile_dev_code_challenge/component/DocumentComponent.dart';
import 'package:mobile_dev_code_challenge/component/ImageComponent.dart';

class ConversationScreen extends StatefulWidget {
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Message> messages = [];
  List<Message> messages2 = [];
  List<Message> filteredMessages = [];
  String previouslySelected = '';
  String selected = '';
  bool isSelected = false;

  final values = [
    'Image Collection',
    'Text Collection',
    'Document',
    'Contact',
    'Image'
  ];
  Future fut;
  bool isAscending;
  void initState() {
    isAscending = true;
    fut = loadData();
    super.initState();
  }

  Future<List<Message>> loadData() async {
    final data = await DefaultAssetBundle.of(context)
        .loadString('assets/message_dataset.json');
    final object = json.decode(data)['data'];
    object.forEach((element) async {
      messages.add(Message.fromMap(element));
    });
    messages2 = List.from(messages, growable: false);
    return messages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        primary: true,
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 7.0),
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white),
              child: Icon(
                Icons.person_outline_rounded,
                color: Theme.of(context).appBarTheme.color,
              ),
            ),
            Text('B'),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState.openEndDrawer();
            },
            icon: Icon(Icons.more_vert_outlined),
            alignment: Alignment.center,
            hoverColor: Theme.of(context).accentColor,
          )
        ],
      ),
      endDrawer: SafeArea(
        child: Drawer(
          elevation: 10.0,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Center(
                    child: Text(
                      'Sort & Filter',
                      textScaleFactor: 1.5,
                    ),
                  ),
                ),
                ListTile(
                  title: Text('Sort by'),
                  subtitle: Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      isAscending ? 'Ascending' : 'Descending',
                    ),
                  ),
                  trailing: Switch(
                    value: isAscending,
                    onChanged: (value) {
                      isAscending = value;
                      if (isAscending == false)
                        setState(() {
                          messages = sortDescending(messages);
                        });
                      else if (isAscending == true)
                        setState(() {
                          messages = sortAscending(messages);
                        });
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  height: 20.0,
                  thickness: 2.0,
                ),
                ListTile(
                  leading: Text('Filter by'),
                ),
                Expanded(
                  child: ListView(
                    children: values.map((String key) {
                      return CheckboxListTile(
                        title: Text(key),
                        value: selected == key,
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (bool value) {
                          setState(() {
                            selected = key;
                            filterMessages(value);
                            if (selected != key) {
                              messages = List.from(messages2, growable: false);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: FutureBuilder<List<Message>>(
                  initialData: messages,
                  future: fut,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Message>> snapshot) {
                    if (!snapshot.hasData || snapshot.hasError) {
                      return Center(
                        child: Text('Loading...'),
                      );
                    }
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 25.0),
                      itemCount: messages.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if (messages[index].attachment == 'document') {
                          return DocumentComponent(
                              message: messages[index],
                              sender: messages[index].sender,
                              date: convertDate(messages[index].date));
                        } else if (messages[index].attachment == 'image' ||
                            messages[index].body.startsWith('gambar')) {
                          return ImageComponent(
                              message: messages[index],
                              sender: messages[index].sender,
                              date: convertDate(messages[index].date));
                        } else if (messages[index].attachment == 'contact') {
                          return ContactComponent(
                              message: messages[index],
                              sender: messages[index].sender,
                              date: convertDate(messages[index].date));
                        }
                        return BubbleChatTextComponent(
                            message: messages[index],
                            sender: messages[index].sender,
                            date: convertDate(messages[index].date));
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String convertDate(DateTime timestamp) {
    var month = DateFormat.MMMM().format(timestamp);
    var formattedDate =
        '${timestamp.day.toString()} $month ${timestamp.year.toString()} ${timestamp.hour.toString()}:${timestamp.minute.toString()}';
    return formattedDate;
  }

  int countSeconds(DateTime date) {
    return date.millisecondsSinceEpoch.abs();
  }

  List<Message> sortDescending(List<Message> msg) {
    List<Message> sortedMessages = List.from(msg);
    sortedMessages
        .sort((b, a) => countSeconds(a.date).compareTo(countSeconds(b.date)));
    messages =
        List<Message>.from(sortedMessages, growable: false).toSet().toList();
    return messages;
  }

  List<Message> sortAscending(List<Message> msg) {
    List<Message> sortedMessages = List.from(msg);
    sortedMessages
        .sort((a, b) => countSeconds(a.date).compareTo(countSeconds(b.date)));
    messages =
        List<Message>.from(sortedMessages, growable: false).toSet().toList();
    return messages;
  }

  void filterMessages(bool value) {
    List<Message> msg = [];
    print(value);
    print(previouslySelected);
    print(selected);
    if (previouslySelected == selected && value == false) {
      selected = '';
      msg = List.from(messages2);
      messages = List.from(msg);
    } else {
      msg = List.from(messages2);
      msg.retainWhere((element) => element.category == selected.toLowerCase());
      messages = List.from(msg);
      previouslySelected = selected;
    }
  }
}
