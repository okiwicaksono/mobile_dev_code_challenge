import 'package:flutter/material.dart';

import 'text_item.dart';

class MultiImageItem extends StatelessWidget {
  String id;
  String? message;
  bool showTriangle;
  bool isLeft;
  int? imageQty;

  MultiImageItem(
    this.id,
    this.message,
    this.showTriangle,
    this.isLeft,
    this.imageQty,
  );

  IconData icon = Icons.photo_sharp;

  @override
  Widget build(BuildContext context) {
    String more =
        imageQty! - 4 > 0 ? "+ ${imageQty! - 4} more..." : "view more...";
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
                              height: 180,
                              child: Wrap(children: [
                                Container(
                                    margin:
                                        EdgeInsets.only(right: 4, bottom: 4),
                                    child: Icon(
                                      icon,
                                      color: Colors.white,
                                      size: 80,
                                    )),
                                Container(
                                    margin:
                                        EdgeInsets.only(right: 4, bottom: 4),
                                    child: Icon(
                                      icon,
                                      color: Colors.white,
                                      size: 80,
                                    )),
                                Container(
                                    margin:
                                        EdgeInsets.only(right: 4, bottom: 4),
                                    child: Icon(
                                      icon,
                                      color: Colors.white,
                                      size: 80,
                                    )),
                                Container(
                                    margin:
                                        EdgeInsets.only(right: 4, bottom: 4),
                                    child: Stack(children: [
                                      Icon(
                                        icon,
                                        color: Colors.white,
                                        size: 80,
                                      ),
                                      Positioned(
                                          child: Container(
                                        width: 80,
                                        height: 80,
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          "${more}",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        color: Color.fromRGBO(0, 0, 0, 0.2),
                                      ))
                                    ]))
                              ]),
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
