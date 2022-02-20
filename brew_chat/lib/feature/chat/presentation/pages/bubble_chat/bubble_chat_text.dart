import 'package:brew_chat/feature/chat/data/models/response_data.dart';
import 'package:brew_chat/util/convert_ms_to_datetime.dart';
import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';

class BubbleChatText extends StatelessWidget {
  final ResponseData responseData;

  const BubbleChatText({Key? key, required this.responseData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (responseData.from == "A") {
      return bubbleChatRight();
    } else {
      return bubbleChatLeft();
    }
  }

  Widget bubbleChatRight() {
    return Bubble(
      margin: const BubbleEdges.only(top: 10),
      alignment: Alignment.topRight,
      nipWidth: 8,
      nipHeight: 24,
      nip: BubbleNip.rightTop,
      color: const Color.fromRGBO(225, 255, 199, 1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(responseData.body ?? '', textAlign: TextAlign.right),
          const SizedBox(
            height: 5,
          ),
          Text(ConvertMsToDatetime.convertMsToDatetime(responseData.timestamp ?? "", ), textAlign: TextAlign.right, style: const TextStyle(
            color: Colors.grey, fontSize: 11
          ),)
        ],
      ),
    );
  }

  Widget bubbleChatLeft() {
    return Bubble(
      margin: const BubbleEdges.only(top: 10),
      alignment: Alignment.topLeft,
      nipWidth: 8,
      nipHeight: 24,
      nip: BubbleNip.leftTop,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(responseData.body ?? ''),
          const SizedBox(
            height: 5,
          ),
          Text(ConvertMsToDatetime.convertMsToDatetime(responseData.timestamp ?? "", ), textAlign: TextAlign.left, style: const TextStyle(
              color: Colors.grey, fontSize: 11
          ),)
        ],
      ),
    );
  }
}
