// To parse this JSON data, do
//
//     final chatWrapper = chatWrapperFromJson(jsonString);

import 'dart:convert';

ChatWrapper chatWrapperFromJson(String str) => ChatWrapper.fromJson(json.decode(str));

String chatWrapperToJson(ChatWrapper data) => json.encode(data.toJson());

class ChatWrapper {
  ChatWrapper({
    this.data,
  });

  List<Datum>? data;

  factory ChatWrapper.fromJson(Map<String, dynamic> json) => ChatWrapper(
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.body,
    this.attachment,
    this.timestamp,
    this.from,
    this.to,
  });

  int? id;
  String? body;
  dynamic? attachment;
  String? timestamp;
  String? from;
  String? to;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    body: json["body"] == null ? null : json["body"],
    attachment: json["attachment"],
    timestamp: json["timestamp"] == null ? null : json["timestamp"],
    from: json["from"] == null ? null : json["from"],
    to: json["to"] == null ? null : json["to"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "body": body == null ? null : body,
    "attachment": attachment,
    "timestamp": timestamp == null ? null : timestamp,
    "from": from == null ? null : from,
    "to": to == null ? null : to,
  };
}
