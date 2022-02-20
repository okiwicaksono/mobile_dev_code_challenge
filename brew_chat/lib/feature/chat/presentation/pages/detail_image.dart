import 'package:brew_chat/feature/chat/data/models/response_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:math' as math;
import 'package:bubble/bubble.dart';

class DetailImage extends StatelessWidget {
  final List<ResponseData> data;
  const DetailImage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Detail"),
      ),
      body: ListView.builder(
          itemCount: data.length ,
          padding: EdgeInsets.only(bottom: AppBar().preferredSize.height + 5),
          itemBuilder: (BuildContext context, int index) {
            return Bubble(
              margin: const BubbleEdges.only(top: 10),
              alignment: data.first.from == "A" ? Alignment.topRight : Alignment.topLeft,
              nipWidth: 8,
              nipHeight: 24,
              nip: data.first.from == "A" ? BubbleNip.rightTop : BubbleNip.leftTop,
              color: data.first.from == "A"
                  ? const Color.fromRGBO(225, 255, 199, 1.0)
                  : Colors.white54,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                width: 150,
                height: 150,
                child: CachedNetworkImage(
                  imageUrl: "https://picsum.photos/200/300?random=${math.Random.secure().nextInt(100000)}",
                  placeholder: (context, url) => const CupertinoActivityIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.picture_in_picture),
                  fit: BoxFit.cover,
                ),
              ),
            );
          }),
    );
  }
}
