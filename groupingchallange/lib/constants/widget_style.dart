import 'package:flutter/material.dart';

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
