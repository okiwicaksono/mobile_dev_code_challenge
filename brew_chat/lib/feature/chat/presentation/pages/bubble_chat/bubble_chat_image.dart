import 'package:brew_chat/feature/chat/data/models/chat_model.dart';
import 'package:brew_chat/feature/chat/data/models/response_data.dart';
import 'package:brew_chat/feature/chat/presentation/pages/detail_image.dart';
import 'package:brew_chat/util/convert_ms_to_datetime.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:math' as math;

class BubbleChatImage extends StatelessWidget {
  final ResponseData? responseData;
  final List<ResponseData>? listData;
  final bool? isGroup;

  const BubbleChatImage(
      {Key? key,
      required this.responseData,
      required this.listData,
      required this.isGroup})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (isGroup ?? false) ? imageGroup(context) : chatImage();
  }

  Widget chatImage() {
    return Bubble(
      margin: const BubbleEdges.only(top: 10),
      alignment:
          responseData?.from == "A" ? Alignment.topRight : Alignment.topLeft,
      nipWidth: 8,
      nipHeight: 24,
      nip: responseData?.from == "A" ? BubbleNip.rightTop : BubbleNip.leftTop,
      color: responseData?.from == "A"
          ? const Color.fromRGBO(225, 255, 199, 1.0)
          : Colors.white54,
      child: Column(
        children: [
          Container(
            width: 150,
            height: 150,
            child: CachedNetworkImage(
              imageUrl:
                  "https://picsum.photos/200/300?random=${math.Random.secure().nextInt(100000)}",
              placeholder: (context, url) => const CupertinoActivityIndicator(),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.picture_in_picture),
              fit: BoxFit.cover,
            ),
          ),
          Offstage(
            offstage: responseData?.body == null,
            child: Container(
                width: 150,
                child: Text(
                  responseData?.body ?? '',
                  textAlign: responseData?.from == "A"
                      ? TextAlign.right
                      : TextAlign.left,
                )),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            width: 150,
            child: Text(
              ConvertMsToDatetime.convertMsToDatetime(
                responseData?.timestamp ?? "",
              ),
              textAlign:
                  responseData?.from == "A" ? TextAlign.right : TextAlign.left,
              style: const TextStyle(color: Colors.grey, fontSize: 11),
            ),
          )
        ],
      ),
    );
  }

  Widget imageGroup(BuildContext context) {
    return Bubble(
      margin: const BubbleEdges.only(top: 10),
      alignment:
          listData?.first.from == "A" ? Alignment.topRight : Alignment.topLeft,
      nipWidth: 8,
      nipHeight: 24,
      nip: listData?.first.from == "A" ? BubbleNip.rightTop : BubbleNip.leftTop,
      color: listData?.first.from == "A"
          ? const Color.fromRGBO(225, 255, 199, 1.0)
          : Colors.white54,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailImage(
                          data: listData ?? [],
                        )),
              );
            },
            child: Container(
              width: 200,
              height: 200,
              alignment: Alignment.center,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 2,
                  ),
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://picsum.photos/200/300?random=${math.Random.secure().nextInt(100000)}",
                        placeholder: (context, url) =>
                            const CupertinoActivityIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.picture_in_picture),
                        fit: BoxFit.cover,
                      ),
                    );
                  }),
            ),
          ),
          Offstage(
            offstage: (listData?.length ?? -1) <= 4,
            child: Text("See +${((listData?.length ?? -1) - 4)} more", style: TextStyle(color: Colors.blueAccent),),
          )
        ],
      ),
    );
  }
}
