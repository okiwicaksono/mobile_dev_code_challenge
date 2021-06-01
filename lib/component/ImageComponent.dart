import 'package:flutter/material.dart';
import 'package:mobile_dev_code_challenge/class/Message.dart';

class ImageComponent extends StatefulWidget {
  final Message message;
  final String sender;
  final String date;
  ImageComponent({@required this.message, this.sender, this.date});

  @override
  _ImageComponentState createState() => _ImageComponentState();
}

class _ImageComponentState extends State<ImageComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.0,
      margin: widget.sender == 'A'
          ? EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: MediaQuery.of(context).size.width * 0.15)
          : EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              right: MediaQuery.of(context).size.width * 0.15),
      padding: EdgeInsets.all(10.0),
      decoration: ShapeDecoration(
        color: widget.sender == 'A'
            ? Color(0xFFCCA8E9)
            : Theme.of(context).appBarTheme.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      child: Card(
        color: Colors.transparent,
        elevation: 0.0,
        clipBehavior: Clip.antiAlias,
        child: Wrap(
          children: [
            ListTile(
                title: const Image(
                  image: NetworkImage(
                      "https://storage.googleapis.com/gd-wagtail-prod-assets/original_images/MDA2018_inline_03.jpg"),
                  fit: BoxFit.fitHeight,
                  isAntiAlias: true,
                  height: 150,
                ),
                subtitle: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
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
                ),
                leading: Icon(Icons.image)),
          ],
        ),
      ),
    );
  }
}
