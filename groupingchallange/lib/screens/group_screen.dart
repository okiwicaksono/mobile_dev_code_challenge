import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groupingchallange/constants/enum.dart';
import 'package:groupingchallange/controllers/message_controller.dart';
import 'package:groupingchallange/models/message_dataset.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({Key? key, required this.user}) : super(key: key);
  final String user;
  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen>
    with SingleTickerProviderStateMixin {
  final MessageController messageController = Get.find<MessageController>();
  late TabController _controller;
  int _selectedIndex = 0;

  List<Widget> list = [
    Tab(icon: Icon(Icons.image_outlined)),
    Tab(icon: Icon(Icons.contact_phone_outlined)),
  ];

  @override
  void initState() {
    super.initState();

    _controller = TabController(length: list.length, vsync: this);

    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });

      if (_selectedIndex == 0) {
        messageController.onChangeTypeFilter(AttachmentType.IMAGE, true);
        messageController.onChangeTypeFilter(AttachmentType.CONTACT, false);
      } else {
        messageController.onChangeTypeFilter(AttachmentType.IMAGE, false);
        messageController.onChangeTypeFilter(AttachmentType.CONTACT, true);
      }

      messageController.changeFilterType(FilterCriteria.SAME_DATE);
    });
  }

  @override
  void dispose() {
    super.dispose();
    messageController.resetFilter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text("Media"),
        automaticallyImplyLeading: true,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.sort),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
        bottom: TabBar(
          onTap: (index) {},
          controller: _controller,
          tabs: list,
        ),
      ),
      endDrawer: buildDrawer(),
      body: TabBarView(
        controller: _controller,
        children: [
          buildContainer(),
          buildContainer(),
        ],
      ),
    );
  }

  Container buildContainer() {
    return Container(
        child: GetBuilder<MessageController>(
      builder: (controller) => controller.categoryName.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: controller.categoryName.length,
              itemBuilder: (context, i) {
                final category = controller.categoryName[i];
                List<Widget> widgetImages = [Container()];
                List<Message> imgs = [];
                if (controller.filterSelected == FilterCriteria.SAME_DATE) {
                  imgs.addAll(controller.filteredMessages.where((element) {
                    return element.date == category;
                  }).toList());
                } else if (controller.filterSelected ==
                    FilterCriteria.SAME_SENDER) {
                  imgs.addAll(controller.filteredMessages.where((element) {
                    return element.from == category;
                  }).toList());
                } else if (controller.filterSelected ==
                    FilterCriteria.NO_BODY) {
                  if (category == "empty body") {
                    imgs.addAll(controller.filteredMessages.where((element) {
                      return element.body == null;
                    }).toList());
                  } else {
                    imgs.addAll(controller.filteredMessages.where((element) {
                      return element.body != null;
                    }).toList());
                  }
                } else if (controller.filterSelected ==
                    FilterCriteria.REPEATED_FOUR_TIMES) {
                  if (i == 0) {
                    for (var idx = 0; idx < int.parse(category); idx++) {
                      imgs.add(
                          controller.filteredMessages.firstWhere((element) {
                        return element.id == controller.sequence[idx];
                      }));
                    }
                  } else {
                    int lastCount = 0;
                    for (var i2 = 1; i2 <= i; i2++) {
                      lastCount += int.parse(controller.categoryName[i2 - 1]);
                    }

                    for (var idx = lastCount;
                        idx < lastCount + int.parse(controller.categoryName[i]);
                        idx++) {
                      imgs.add(
                          controller.filteredMessages.firstWhere((element) {
                        return element.id == controller.sequence[idx];
                      }));
                    }
                  }
                } else if (controller.filterSelected ==
                    FilterCriteria.REPEATED_TWO_TIMES) {
                  if (i == 0) {
                    for (var idx = 0; idx < int.parse(category); idx++) {
                      imgs.add(
                          controller.filteredMessages.firstWhere((element) {
                        return element.id == controller.sequence[idx];
                      }));
                    }
                  } else {
                    int lastCount = 0;
                    for (var i2 = 1; i2 <= i; i2++) {
                      lastCount += int.parse(controller.categoryName[i2 - 1]);
                    }

                    for (var idx = lastCount;
                        idx < lastCount + int.parse(controller.categoryName[i]);
                        idx++) {
                      imgs.add(
                          controller.filteredMessages.firstWhere((element) {
                        return element.id == controller.sequence[idx];
                      }));
                    }
                  }
                }

                imgs.forEach((element) {
                  widgetImages.add(buildMessageType(element));
                });

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(category),
                      Divider(),
                      Wrap(
                        children: widgetImages,
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                );
              }),
    ));
  }

  Drawer buildDrawer() {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(height: 20),
                    Text('Options'),
                    Divider(),
                    GetBuilder<MessageController>(
                      builder: (controller) => RadioListTile(
                        value: FilterCriteria.SAME_DATE,
                        groupValue: controller.filterSelected,
                        title: Text("Tanggal"),
                        onChanged: (val) {
                          final selected = val! as FilterCriteria;
                          controller.changeFilterType(selected);
                        },
                      ),
                    ),
                    GetBuilder<MessageController>(
                      builder: (controller) => RadioListTile(
                        value: FilterCriteria.SAME_SENDER,
                        groupValue: controller.filterSelected,
                        title: Text("Pengirim"),
                        onChanged: (val) {
                          controller.changeFilterType(val);
                          Get.back();
                        },
                      ),
                    ),
                    if (messageController.isImageFilterActive)
                      GetBuilder<MessageController>(
                        builder: (controller) => RadioListTile(
                          value: FilterCriteria.NO_BODY,
                          groupValue: controller.filterSelected,
                          title: Text("Title"),
                          onChanged: (val) {
                            controller.changeFilterType(val);
                            Get.back();
                          },
                        ),
                      ),
                    if (messageController.isImageFilterActive)
                      GetBuilder<MessageController>(
                        builder: (controller) => RadioListTile(
                          value: FilterCriteria.REPEATED_FOUR_TIMES,
                          groupValue: controller.filterSelected,
                          title: Text("Berulang Empat Kali"),
                          onChanged: (val) {
                            controller.changeFilterType(val);
                            Get.back();
                          },
                        ),
                      ),
                    if (messageController.isContactFilterActive)
                      GetBuilder<MessageController>(
                        builder: (controller) => RadioListTile(
                          value: FilterCriteria.REPEATED_TWO_TIMES,
                          groupValue: controller.filterSelected,
                          title: Text("Berulang Dua Kali"),
                          onChanged: (val) {
                            controller.changeFilterType(val);
                            Get.back();
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMessageType(Message msg) {
    return GestureDetector(
        onTap: () => Get.dialog(
              Dialog(
                  child: Text(
                msg.toJson().toString(),
              )),
            ),
        child: Builder(
          builder: (context) {
            if (msg.attachment == "image" || msg.attachment == "document") {
              return Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: widget.user == msg.from
                        ? Colors.green[200]
                        : Colors.white),
                child: Image.network(
                  msg.attachment == "image"
                      ? "https://picsum.photos/200/300?random=${msg.timestamp}"
                      : "https://www.iconpacks.net/icons/2/free-attachment-icon-1483-thumb.png",
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              );
            } else if (msg.attachment == "contact") {
              var faker = new Faker();
              return Container(
                margin: EdgeInsets.symmetric(vertical: 2),
                padding: EdgeInsets.symmetric(vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    width: 2,
                    color: Colors.black12,
                  ),
                ),
                child: SizedBox(
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
                          if (widget.user != msg.from) Text("Save Contact"),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
            return Text(msg.body ?? "", textAlign: TextAlign.right);
          },
        ));
  }
}
