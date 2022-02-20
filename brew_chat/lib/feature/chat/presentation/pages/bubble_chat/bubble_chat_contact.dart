import 'package:brew_chat/feature/chat/data/models/response_data.dart';
import 'package:brew_chat/feature/chat/presentation/pages/contact_detail.dart';
import 'package:brew_chat/util/convert_ms_to_datetime.dart';
import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';

class BubbleChatContact extends StatelessWidget {
  final ResponseData? responseData;
  final List<ResponseData>? listData;
  final bool? isGroup;

  const BubbleChatContact(
      {Key? key,
      required this.responseData,
      required this.listData,
      required this.isGroup})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isGroup ?? false ? groupContact(context) : cardContact();
  }

  Widget cardContact() {
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
      child: Container(
        width: 150,
        height: 80,
        child: Column(
          children: [
            Row(
              children: const [Icon(Icons.person), Text("Person Name")],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text(
                  "Message",
                  style: TextStyle(color: Colors.blueAccent),
                ),
                Text("Save", style: TextStyle(color: Colors.blueAccent))
              ],
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
                textAlign: responseData?.from == "A"
                    ? TextAlign.right
                    : TextAlign.left,
                style: const TextStyle(color: Colors.grey, fontSize: 11),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget groupContact(BuildContext context) {
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
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContactDetail(data: listData ?? []),
              ));
        },
        child: Container(
          width: 220,
          height: 30,
          child: Column(
            children: [
              Row(
                children: const [
                  Icon(Icons.person),
                  SizedBox(
                    width: 10,
                  ),
                  Text("More than one person"),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 15,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
