import 'package:flutter/material.dart';

import 'text_item.dart';

class ContactItem extends StatelessWidget {
  String id;
  String? message;
  bool showTriangle;
  IconData? icon;
  bool isLeft;
  bool isNotText;

  ContactItem(
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
                    margin: const EdgeInsets.only(top: 15, right: 8),
                    child: const CircleAvatar(
                        child: Icon(Icons.person),
                        backgroundColor: Color.fromARGB(255, 49, 137, 161)))
                : const SizedBox.shrink(),
            isLeft && showTriangle
                ? Container(
                    margin: const EdgeInsets.only(
                      top: 15,
                    ),
                    child: CustomPaint(
                      painter: Triangle(isLeft
                          ? Color.fromARGB(255, 158, 190, 197)
                          : Colors.indigo.shade600),
                    ))
                : const SizedBox.shrink(),
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                width: 250,
                padding: const EdgeInsets.all(15),
                margin: EdgeInsets.only(
                  top: 15,
                  bottom: 5,
                  left: isLeft && !showTriangle ? 48 : 0,
                  right: !isLeft && !showTriangle ? 48 : 0,
                ),
                decoration: BoxDecoration(
                  color: isLeft
                      ? const Color.fromARGB(255, 158, 190, 197)
                      : Colors.indigo.shade600,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(isLeft ? 0 : 19),
                    bottomLeft: const Radius.circular(19),
                    bottomRight: const Radius.circular(19),
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
                                margin: const EdgeInsets.only(bottom: 4),
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      icon != null
                                          ? Container(
                                              margin: const EdgeInsets.only(
                                                  right: 8),
                                              child: Icon(
                                                icon,
                                                color: Colors.white,
                                                size: 24,
                                              ))
                                          : const SizedBox.shrink(),
                                      Expanded(
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
                            Text(
                              id,
                              style: const TextStyle(
                                  fontSize: 8, color: Colors.white),
                              textAlign: TextAlign.right,
                            )
                          ])
                    : const Icon(Icons.image, size: 48),
              ),
            ),
            !isLeft && showTriangle
                ? Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: CustomPaint(
                      painter: Triangle(Colors.indigo.shade600),
                    ))
                : const SizedBox.shrink(),
            !isLeft && showTriangle
                ? Container(
                    margin: const EdgeInsets.only(top: 15, left: 8),
                    child: const CircleAvatar(
                      child: Icon(Icons.person),
                    ))
                : const SizedBox.shrink(),
          ],
        ));
  }
}
