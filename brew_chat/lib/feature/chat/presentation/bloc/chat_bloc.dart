import 'dart:async';
import 'dart:convert';
import 'package:brew_chat/feature/chat/data/models/chat_model.dart';
import 'package:brew_chat/feature/chat/data/models/response_data.dart';
import 'package:brew_chat/util/fixture_reader.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  Map<int, List<ResponseData>> finalImageData = {};
  Map<int, List<ResponseData>> finalContactData = {};


  ChatBloc() : super(ChatInitial()) {
    on<ChatEvent>((event, emit) {});
    on<GetListChat>((event, emit) async => await onGetListChat(emit));
  }

  Future<void> onGetListChat(Emitter<ChatState> emitter) async {
    emitter(ChatInitial());
    emitter(Loading());
    var listChat = <ResponseData>[];
    var listChatModel = <ChatModel>[];
    var messageJson = await fixture('message_dataset.json');
    var listChatJson = json.decode(messageJson);
    List<dynamic> listChatData = listChatJson["data"];
    for (var element in listChatData) {
      var data = ResponseData.fromJson(element);
      listChat.add(data);
    }
    // print(json.encode(listChat));
    getImageGroup(listChat);
    getContactGroup(listChat);

    for (var element in listChat) {
      for (var elementImage in finalImageData.keys) {
        var indexChatModel = listChatModel
            .indexWhere((elemantChat) => elemantChat.id == element.id);
        if (finalImageData[elementImage]?.contains(element) == true) {
          var index = listChatModel.indexWhere((element) => element.listData == finalImageData[elementImage]);
          var chatData = ChatModel(
            id: element.id,
            attachment: element.attachment,
            data: null,
            listData: finalImageData[elementImage],
          );

          if(index == -1){
          // if(indexChatModel == -1){
            listChatModel.add(
              chatData,
            );
          }
          // }
        } else {
          var chatData = ChatModel(
            id: element.id,
            attachment: element.attachment,
            data: element,
            listData: null,
          );
          // if(indexChatModel == -1){
            listChatModel.add(
              chatData,
            );
          // }
        }
      }

      for (var elementImage in finalContactData.keys) {
        var indexChatModel = listChatModel
            .indexWhere((elemantChat) => elemantChat.id == element.id);
        if (finalContactData[elementImage]?.contains(element) == true) {
          var index = listChatModel.indexWhere((element) => element.listData == finalContactData[elementImage]);
          var chatData = ChatModel(
            id: element.id,
            attachment: element.attachment,
            data: null,
            listData: finalContactData[elementImage],
          );

          if(index == -1){
            // if(indexChatModel == -1){
            listChatModel.add(
              chatData,
            );
          }
          // }
        } else {
          var chatData = ChatModel(
            id: element.id,
            attachment: element.attachment,
            data: element,
            listData: null,
          );
          // if(indexChatModel == -1){
          listChatModel.add(
            chatData,
          );
          // }
        }
      }

    }

    print("Final Data ========== ${jsonEncode(listChatModel)}");

    var distinctListChatModel = listChatModel.toSet().toList();

    for (var elementImage in finalImageData.keys) {
      finalImageData[elementImage]?.forEach((element) {
        distinctListChatModel.removeWhere((elementChat) =>
            elementChat.id == element.id && elementChat.data != null);
      });
    }

    for (var elementContact in finalContactData.keys) {
      finalContactData[elementContact]?.forEach((element) {
        distinctListChatModel.removeWhere((elementChat) =>
        elementChat.id == element.id && elementChat.data != null);
      });
    }

    await Future.delayed(const Duration(milliseconds: 1));
    emitter(Loaded(distinctListChatModel));
  }

  List<ResponseData> getImageGroup(List<ResponseData> responseData,
      {int? lastIdContainer = -1}) {
    var lastId = lastIdContainer;
    var imageMessage = <ResponseData>[];
    var containerImageMessage = <ResponseData>[];

    for (var element in responseData) {
      if (element.attachment == "image" && element.body == null) {
        containerImageMessage.add(element);
        if (lastId != -1) {
          if (element.id == (lastId ?? -1) + 1) {
            lastId = element.id ?? -1;
            imageMessage.add(element);
          } else if (element.id == (lastId ?? -1)) {
            imageMessage.add(element);
          }
        } else {
          if (imageMessage.isEmpty) {
            lastId = element.id ?? -1;
            imageMessage.add(element);
          } else {
            if (element.id == (lastId ?? -1) + 1) {
              lastId = element.id ?? -1;
              imageMessage.add(element);
            }
          }
        }
      }
    }

    var lastIndexId = containerImageMessage
        .indexWhere((element) => element.id == imageMessage.last.id);

    if (imageMessage.length >= 4) {
      print(
          "imageMessage.first.id.toString() ====== ${imageMessage.first.id.toString()}");
      if (finalImageData.containsKey(imageMessage.first.id)) {
        print("contain");
        finalImageData[imageMessage.first.id]?.addAll(imageMessage);
        // print("finalImageData === ${json.encode(finalImageData)}");
      } else {
        print("not contain");
        print(
            "not contain ${imageMessage.first.id} ===== ${json.encode(imageMessage)}");
        finalImageData.addAll({imageMessage.first.id ?? -1: imageMessage});
        // print("finalImageData === ${json.encode(finalImageData)}");
      }
      try {
        return getImageGroup(responseData,
            lastIdContainer: containerImageMessage[lastIndexId + 1].id);
      } on RangeError {
        return [];
      }
    } else {
      if (lastIndexId == -1) {
        return [];
      } else {
        return getImageGroup(responseData,
            lastIdContainer: containerImageMessage[lastIndexId + 1].id);
      }
    }
  }

  List<ResponseData> getContactGroup(List<ResponseData> responseData,
      {int? lastIdContainer = -1}) {
    var lastId = lastIdContainer;
    var contactMessage = <ResponseData>[];
    var containerContactMessage = <ResponseData>[];

    for (var element in responseData) {
      if (element.attachment == "contact" && element.body == null) {
        containerContactMessage.add(element);
        if (lastId != -1) {
          if (element.id == (lastId ?? -1) + 1) {
            lastId = element.id ?? -1;
            contactMessage.add(element);
          } else if (element.id == (lastId ?? -1)) {
            contactMessage.add(element);
          }
        } else {
          if (contactMessage.isEmpty) {
            lastId = element.id ?? -1;
            contactMessage.add(element);
          } else {
            if (element.id == (lastId ?? -1) + 1) {
              lastId = element.id ?? -1;
              contactMessage.add(element);
            }
          }
        }
      }
    }

    var lastIndexId = containerContactMessage
        .indexWhere((element) => element.id == contactMessage.last.id);

    if (contactMessage.length >= 2) {
      print(
          "imageMessage.first.id.toString() ====== ${contactMessage.first.id.toString()}");
      if (finalContactData.containsKey(contactMessage.first.id)) {
        print("contain");
        finalContactData[contactMessage.first.id]?.addAll(contactMessage);
        // print("finalImageData === ${json.encode(finalImageData)}");
      } else {
        print("not contain");
        print(
            "not contain ${contactMessage.first.id} ===== ${json.encode(contactMessage)}");
        finalContactData.addAll({contactMessage.first.id ?? -1: contactMessage});
        // print("finalImageData === ${json.encode(finalImageData)}");
      }
      try {
        return getContactGroup(responseData,
            lastIdContainer: containerContactMessage[lastIndexId + 1].id);
      } on RangeError {
        return [];
      }
    } else {
      if (lastIndexId == -1) {
        return [];
      } else {
        return getContactGroup(responseData,
            lastIdContainer: containerContactMessage[lastIndexId + 1].id);
      }
    }
  }
}
