import 'package:flutter/material.dart';
import 'package:mobile_dev_code_challenge/class/Message.dart';

class BubbleChatTextComponent extends StatefulWidget {
  final Message message;
  final String sender;
  final String date;
  BubbleChatTextComponent({@required this.message, this.sender, this.date});

  @override
  _BubbleChatTextComponentState createState() =>
      _BubbleChatTextComponentState();
}

class _BubbleChatTextComponentState extends State<BubbleChatTextComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      margin: widget.sender == 'A'
          ? EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: MediaQuery.of(context).size.width * 0.20)
          : EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              right: MediaQuery.of(context).size.width * 0.20),
      padding: EdgeInsets.all(10.0),
      decoration: ShapeDecoration(
        color: widget.sender == 'A'
            ? Color(0xFFCCA8E9)
            : Theme.of(context).appBarTheme.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      child: ListTile(
        leading: Icon(Icons.message),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.message.id.toString()),
            Text(
              ' | ',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(widget.date),
          ],
        ),
        title: Text(widget.message.body),
      ),
    );
  }
}
