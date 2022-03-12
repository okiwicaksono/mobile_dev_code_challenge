import 'dart:convert';

class MessagesResponse {
    MessagesResponse({
        required this.data,
    });

    final List<MessageModel> data;

    factory MessagesResponse.fromRawJson(String str) => MessagesResponse.fromJson(json.decode(str));

    factory MessagesResponse.fromJson(Map<String, dynamic> json) => MessagesResponse(
        data: List<MessageModel>.from(json["data"].map((x) => MessageModel.fromJson(x))),
    );
}

class MessageModel{
  final int id;
  final String? body;
  final String? attachment;
  final String timestamp;
  final String from;
  final String to;

  MessageModel({required this.id, this.body, this.attachment, required this.timestamp, required this.from, required this.to});

  factory MessageModel.fromRawJson(String str) => MessageModel.fromJson(json.decode(str));

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
      id: json["id"],
      body: json["body"],
      attachment: json["attachment"],
      timestamp: json["timestamp"],
      from: json['from'],
      to: json['to'],
  );

  @override
  String toString() {
    return '$id $attachment $from';
  }
}
