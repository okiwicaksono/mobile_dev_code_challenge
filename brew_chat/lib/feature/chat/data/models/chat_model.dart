import 'package:brew_chat/feature/chat/data/models/response_data.dart';
import 'package:equatable/equatable.dart';

class ChatModel extends Equatable {
  int? id;
  ResponseData? data;
  List<ResponseData>? listData;
  String? attachment;

  ChatModel({required this.id, this.data, this.listData, this.attachment});

  @override
  List<Object?> get props => [id, data, listData, attachment];

  ChatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    data = json['data'] != null ? ResponseData.fromJson(json['data']) : null;
    if (json['listData'] != null) {
      listData = <ResponseData>[];
      json['listData'].forEach((v) {
        listData!.add(ResponseData.fromJson(v));
      });
    }
    attachment = json['attachment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (listData != null) {
      data['listData'] = listData!.map((v) => v.toJson()).toList();
    }
    data['attachment'] = attachment;
    return data;
  }
}
