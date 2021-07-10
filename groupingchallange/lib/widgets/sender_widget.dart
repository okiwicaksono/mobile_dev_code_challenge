import 'package:flutter/material.dart';

class SenderWidget extends StatelessWidget {
  const SenderWidget({
    Key? key,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  final Function() onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Container(
        margin: EdgeInsets.all(30),
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 3, color: Colors.white)),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 40,
          ),
        ),
      ),
    );
  }
}
