import 'package:flutter/material.dart';

import 'text_item.dart';

class ImageItem extends StatelessWidget {
  String id;
  String? message;
  bool showTriangle;
  IconData? icon;
  bool isLeft;
  bool isNotText;

  ImageItem(
    this.id,
    this.message,
    this.showTriangle,
    this.icon,
    this.isLeft,
    this.isNotText,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
        key: Key("${id}"),
        // margin: EdgeInsets.only(left: 6, right: 6, top: 4, bottom: 4),
        child: Row(
          mainAxisAlignment:
              isLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            isLeft && showTriangle
                ? Container(
                    margin: EdgeInsets.only(top: 15, right: 8),
                    child: CircleAvatar(
                        child: Icon(Icons.person),
                        backgroundColor: Color.fromARGB(255, 49, 137, 161)))
                : SizedBox.shrink(),
            isLeft && showTriangle
                ? Container(
                    margin: EdgeInsets.only(
                      top: 15,
                    ),
                    child: CustomPaint(
                      painter: Triangle(isLeft
                          ? Color.fromARGB(255, 158, 190, 197)
                          : Colors.indigo.shade600),
                    ))
                : SizedBox.shrink(),
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                width: 200,
                padding: const EdgeInsets.all(15),
                margin: EdgeInsets.only(
                  top: 15,
                  bottom: 5,
                  left: isLeft && !showTriangle ? 48 : 0,
                  right: !isLeft && !showTriangle ? 48 : 0,
                ),
                decoration: BoxDecoration(
                  color: isLeft
                      ? Color.fromARGB(255, 158, 190, 197)
                      : Colors.indigo.shade600,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(isLeft ? 0 : 19),
                    bottomLeft: Radius.circular(19),
                    bottomRight: Radius.circular(19),
                    topRight: Radius.circular(!isLeft ? 0 : 19),
                  ),
                ),
                child: message != null
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 4),
                              child: Container(
                                  height: (message ?? "").isEmpty ? 65 : 90,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        icon != null
                                            ? Container(
                                                margin: EdgeInsets.only(
                                                    right: 4, bottom: 4),
                                                child: Icon(
                                                  icon,
                                                  color: Colors.white,
                                                  size: (message ?? "").isEmpty
                                                      ? 60
                                                      : 60,
                                                ))
                                            : SizedBox.shrink(),
                                        (message ?? "").isEmpty
                                            ? SizedBox.shrink()
                                            : Expanded(
                                                child: Text(
                                                  message!,
                                                  softWrap: true,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              )
                                      ])),
                            ),
                            Text(
                              id,
                              style:
                                  TextStyle(fontSize: 8, color: Colors.white),
                              textAlign: TextAlign.right,
                            )
                          ])
                    : Icon(Icons.image, size: 48),
              ),
            ),
            !isLeft && showTriangle
                ? Container(
                    margin: EdgeInsets.only(top: 15),
                    child: CustomPaint(
                      painter: Triangle(isLeft
                          ? Color.fromARGB(255, 158, 190, 197)
                          : Colors.indigo.shade600),
                    ))
                : SizedBox.shrink(),
            !isLeft && showTriangle
                ? Container(
                    margin: EdgeInsets.only(top: 15, left: 8),
                    child: CircleAvatar(
                      child: Icon(Icons.person),
                    ))
                : SizedBox.shrink(),
          ],
        ));
  }
}
