import 'package:flutter/material.dart';
import 'package:mobile_dev_code_challenge/ConversationScreen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      resizeToAvoidBottomPadding: true,
      body: Center(
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: ListTile(
            autofocus: true,
            leading: Icon(Icons.person_outline_rounded),
            title: Text('B'),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            subtitle: Text('Send a message'),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ConversationScreen()));
            },
          ),
        ),
      ),
    );
  }
}
