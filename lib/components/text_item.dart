import 'package:flutter/material.dart';

class TextItem extends StatelessWidget {
  String id;
  String? message;
  bool showTriangle;
  bool isLeft;

  TextItem(
    this.id,
    this.message,
    this.showTriangle,
    this.isLeft,
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
                        ? Color.fromARGB(255, 158, 190, 197)
                        : Colors.indigo.shade600,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(isLeft ? 0 : 19),
                      bottomLeft: Radius.circular(19),
                      bottomRight: Radius.circular(19),
                      topRight: Radius.circular(!isLeft ? 0 : 19),
                    ),
                  ),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 4),
                          child: Text(
                            message!,
                            softWrap: true,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Text(
                          id,
                          style: TextStyle(fontSize: 8, color: Colors.white),
                          textAlign: TextAlign.right,
                        )
                      ])),
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

// Create a custom triangle
class Triangle extends CustomPainter {
  final Color backgroundColor;
  Triangle(this.backgroundColor);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = backgroundColor;

    var path = Path();
    path.lineTo(-5, 0);
    path.lineTo(0, 10);
    path.lineTo(5, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
