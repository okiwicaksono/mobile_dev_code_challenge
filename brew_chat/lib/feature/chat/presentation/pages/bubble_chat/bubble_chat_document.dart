import 'package:brew_chat/feature/chat/data/models/response_data.dart';
import 'package:brew_chat/util/convert_ms_to_datetime.dart';
import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';


class BubbleChatDocument extends StatelessWidget {
  final ResponseData responseData;

  const BubbleChatDocument({Key? key, required this.responseData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bubble(
      margin: const BubbleEdges.only(top: 10),
      alignment: responseData.from == "A" ? Alignment.topRight : Alignment.topLeft,
      nipWidth: 8,
      nipHeight: 24,
      nip: responseData.from == "A" ? BubbleNip.rightTop : BubbleNip.leftTop,
      color: responseData.from == "A" ? const Color.fromRGBO(225, 255, 199, 1.0) : Colors.white54,
      child: Column(
        children: [
          const Icon(Icons.insert_drive_file_outlined, size: 50, color: Colors.black54,),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: 80,
            child: Text(ConvertMsToDatetime.convertMsToDatetime(responseData.timestamp ?? "", ), textAlign: responseData.from == "A" ? TextAlign.right : TextAlign.left, style: const TextStyle(
                color: Colors.grey, fontSize: 11
            ),),
          )
        ],
      )
    );
  }
}
