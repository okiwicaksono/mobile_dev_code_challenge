import 'package:bubble/bubble.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groupingchallange/constants/enum.dart';
import 'package:groupingchallange/constants/widget_style.dart';
import 'package:groupingchallange/controllers/message_controller.dart';
import 'package:groupingchallange/screens/group_screen.dart';
import 'package:groupingchallange/models/message_dataset.dart';
import 'package:groupingchallange/utils/date_convert.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key, required this.user}) : super(key: key);
  final String user;

  final MessageController controller = Get.find<MessageController>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      // endDrawer: buildDrawer(),
      appBar: buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<MessageController>(
              builder: (controller) => ListView.builder(
                itemCount: controller.filteredMessages.length,
                itemBuilder: (context, index) {
                  final date = controller.filteredMessages[index].date;
                  final timeString = controller.filteredMessages[index].hour;
                  final dateYesterday = index == 0
                      ? ""
                      : DateConvert.convertTsToDate(
                          controller.filteredMessages[index - 1].timestamp,
                          TsConvertTo.DATE);
                  bool showDate = date != dateYesterday;

                  return Column(
                    children: [
                      if (showDate)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Bubble(
                            alignment: Alignment.center,
                            color: Color.fromRGBO(212, 234, 244, 1.0),
                            child: Text(date,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 11.0)),
                          ),
                        ),
                      GestureDetector(
                        onTap: () {
                          Get.dialog(Dialog(
                            child: Text(controller.filteredMessages[index]
                                .toJson()
                                .toString()),
                          ));
                        },
                        child: Bubble(
                          margin: BubbleEdges.only(top: 10),
                          alignment:
                              user != controller.filteredMessages[index].from
                                  ? Alignment.topLeft
                                  : Alignment.topRight,
                          nip: user != controller.filteredMessages[index].from
                              ? BubbleNip.leftTop
                              : BubbleNip.rightTop,
                          color: user != controller.filteredMessages[index].from
                              ? null
                              : Color.fromRGBO(225, 255, 199, 1.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              buildMessageType(
                                  controller.filteredMessages[index], context),
                              SizedBox(height: 10),
                              SizedBox(height: 10),
                              Text(
                                timeString,
                                textAlign: TextAlign.left,
                                style:
                                    TextStyle(fontSize: 10, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Container(
            decoration: kMessageContainerDecoration,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    // controller: messageTextController,
                    // onChanged: (value) {
                    //   messageText = value;
                    // },
                    decoration: kMessageTextFieldDecoration,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Send',
                    style: kSendButtonTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 10),
              IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Get.back();
                  }),
              Container(
                  // key: ValueKey(new Random().nextInt(100)),
                  // padding: EdgeInsets.all(w * 0.05),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: Icon(
                    Icons.person,
                    color: Colors.grey,
                    size: 30,
                  )),
              SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    controller.onChangeTypeFilter(AttachmentType.IMAGE, true);
                    controller.onChangeTypeFilter(
                        AttachmentType.CONTACT, false);
                    // controller.filterByType();
                    controller.changeFilterType(FilterCriteria.SAME_DATE);
                    // controller.filteredByCriteria();
                    await Get.to(() => GroupScreen(
                          user: user,
                        ));
                    controller.resetFilter();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          "USER: " + (user == "A" ? "B" : "A"),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            // color: Colors.black87,
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMessageType(Message msg, context) {
    if (msg.attachment == "image" || msg.attachment == "document") {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            msg.attachment == "image"
                ? "https://picsum.photos/200/300?random=${msg.timestamp}"
                : "https://www.iconpacks.net/icons/2/free-attachment-icon-1483-thumb.png",
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),
          if (msg.body != null) Text(msg.body!)
        ],
      );
    } else if (msg.attachment == "contact") {
      var faker = new Faker();
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    "https://i.pravatar.cc/300?u=${msg.timestamp}",
                    width: 50,
                    height: 50,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(flex: 4, child: Text(faker.person.name())),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text("Send Message"),
                if (user != msg.from) Text("Save Contact"),
              ],
            ),
          ],
        ),
      );
    }
    return Text(msg.body ?? "", textAlign: TextAlign.right);
  }
}
