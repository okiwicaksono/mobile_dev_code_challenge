import 'dart:convert';
import 'package:chatroom/models/display_model.dart';
import 'package:chatroom/models/msg_model.dart';
import 'package:get/state_manager.dart';

import 'data.dart';

class ChatController extends GetxController {
  var chatList = <DisplayModel>[].obs;

  @override
  void onInit() {
    initializedPage();
    super.onInit();
  }

  void initializedPage() async {
    var result = jsonDecode(data);
    List dataList = (result["data"]);
    List<MessageModel> convertedList = [];
    for (var item in dataList) {
      convertedList.add(MessageModel.fromJson(item));
    }

    convertedList.sort((a, b) => int.tryParse("${a.timestamp}")!
        .compareTo(int.tryParse("${b.timestamp}")!));
    Map<dynamic, dynamic> groupTgl = {};

    bool _showAvatar;
    String lastFrom = "";

    for (MessageModel item in convertedList) {
      DateTime date = DateTime.fromMillisecondsSinceEpoch(
          int.parse("${item.timestamp}") * 1000);
      String tgl = date.toString().split(" ")[0];
      List<DisplayModel> _dt = groupTgl[tgl] ?? [];

      String atch = (item.attachment ?? "").trim().toLowerCase();
      String _type = atch.isEmpty ? "text" : atch;

      lastFrom = _dt.isEmpty ? "" : _dt.last.from!;
      String? newTgl = _dt.isEmpty ? "" : _dt.last.id;

      bool addNewLine = true,
          isSamePersonDate = ((lastFrom == item.from) && (newTgl == tgl));
      _showAvatar = !isSamePersonDate;
      List<dynamic>? _images = [], _contacts = [];

      if (_type == "image") {
        if (_dt.isNotEmpty) {
          if (_dt.last.imageList!.isEmpty &&
              (_dt.last.message ?? "").trim().isEmpty &&
              isSamePersonDate) {
            _showAvatar = _dt.last.showAvatar!;
            addNewLine = false;
          } else if (_dt.last.imageList!.isNotEmpty && isSamePersonDate) {
            _showAvatar = _dt.last.showAvatar!;
            addNewLine = false;
            _images = _dt.last.imageList ?? [];
          }
          _images.add(item);
        }

        if ((item.body ?? "").trim().isNotEmpty) {
          addNewLine = true;
          _images = [];
        }
      } else if (_type == "contact") {
        if (_dt.isNotEmpty) {
          if (_dt.last.contactList!.isNotEmpty && isSamePersonDate) {
            addNewLine = false;
            _showAvatar = _dt.last.showAvatar!;
            _contacts = _dt.last.contactList ?? [];
          }
        }

        _contacts.add(item);
      } else {
        addNewLine = true;
      }

      if (addNewLine) {
        _dt.add(DisplayModel(
            id: "${tgl}",
            type: _type,
            showAvatar: _showAvatar,
            message: item.body,
            imageList: _images,
            contactList: _contacts,
            from: item.from));
      } else {
        _dt.last = DisplayModel(
            id: "${tgl}",
            type: _type,
            showAvatar: _showAvatar,
            message: item.body,
            imageList: _images,
            contactList: _contacts,
            from: item.from);
      }
      groupTgl[tgl] = _dt;
    }

    List<dynamic> tglList = groupTgl.keys.toList();
    List<DisplayModel> finalList = [];

    for (var listItem in tglList) {
      finalList.add(DisplayModel(id: listItem, type: "tanggal"));
      for (DisplayModel displayModel in groupTgl[listItem]) {
        finalList.add((displayModel));
      }
    }
    chatList.value = finalList;
  }
}
